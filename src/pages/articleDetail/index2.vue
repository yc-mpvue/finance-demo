<template>
  <div class="article-detail">
    <!-- 假item，用来初始化获取列表每一项高度 -->
    <div class="article-detail-fake-item"></div>
    <!-- 标题 -->
    <div class="article-detail-title"
      v-if="info.title">{{info.title}}</div>
    <!-- 日期 -->
    <div class="article-detail-date"
      v-if="info.date">{{info.date}}</div>
    <!-- 视频封面 -->
    <div class="article-detail-post" v-if="info.video && !isShowVideo" @click="isShowVideo = true" :style="{backgroundImage: 'url('+ info.video[1] || '' +')'}">
      <div class="article-detail-post-play"></div>
    </div>
    <!-- 视频 -->
    <video :src="info.video[0]"
      autoplay
      :custom-cache="false"
      :poster="info.video[1] || ''"
      v-if="info.video && isShowVideo" />
    <!-- 富文本 -->
    <div class="article-detail-html"
      v-if="content">
      <wxParse :content="content"
        @preview="preview"
        @navigate="navigate" />
    </div>
    <!-- 推荐商户 -->
    <div class="article-detail-subtitle"
      v-if="viewList.length">推荐商户</div>
    <!-- 商户列表 -->
    <div v-for="(outter, index) in viewList"
      :key="index"
      :style="{ height: outter.height ? outter.height + 'px' : 'auto', width: '750rpx'}">
      <div v-if="outter.length">
        <store-cell v-for="(inner, idx) in outter"
          :key="idx"
          :merchant="inner"
          @click="onClickStore(inner.merchantInfoId)" />
      </div>
    </div>
    <!-- 底部加载提示 -->
    <div class="article-detail-foot"
      v-show="isShowFoot && viewList.length">- 到底了哦 -</div>
  </div>
</template>

<script>
import StoreCell from '@/components/storeCell/index'
import wxParse from '../../../static/mpvue-wxparse'
import decodeXML from '@/common/utils/decodeXML'
import { simplifyStoreList } from '@/common/utils/filterInterface'

const windowHeight = wx.getSystemInfoSync().windowHeight
let allList = []
let limit = false
let pageNum = 1
let pageSize = 20
let articleid = null
let index = 0
let boundings = []
let itemRact = {}
let isHandle = false
let isNav = false
let latitude = null
let longitude = null

export default {
  components: {
    StoreCell,
    wxParse
  },
  data() {
    return {
      isShowVideo: false,
      viewList: [],
      isShowFoot: false,
      content: '',
      info: {},
      href: ''
    }
  },
  onLoad({ id }) {
    Object.assign(this.$data, this.$options.data())
    articleid = id
    wx.getLocation({
      type: 'gcj02',
      success: res => {
        latitude = res.latitude
        longitude = res.longitude
      },
      complete: () => this.loadData()
    })
    this.initItemBoundings()
  },
  onShow() {
    if (this.href) this.href = ''
    limit = false
    isNav = false
    isHandle = false
    if (this.viewList.length) this.handleViewList()
  },
  onPageScroll({ scrollTop }) {
    for (let i = 0; i < boundings.length; i++) {
      if (
        boundings[i].top < scrollTop + windowHeight &&
        scrollTop + windowHeight <= boundings[i].bottom &&
        index !== i
      ) {
        index = i
        if (!isHandle && !isNav) return this.handleViewList()
      }
    }
  },
  onReachBottom() {
    this.loadData(true)
  },
  methods: {
    initItemBoundings() {
      wx
        .createSelectorQuery()
        .select('.article-detail-fake-item')
        .boundingClientRect(({ top, height }) => {
          itemRact = { top, height }
        })
        .exec()
    },
    handleViewList(idx) {
      if (isNav) return
      if (idx !== undefined && idx === index) return (isHandle = false)
      isHandle = true
      idx = index
      let isNeedLoop = false
      for (let i = 0; i < this.viewList.length; i++) {
        if (i >= idx - 2 && i <= idx + 2 && this.viewList[i] && !Array.isArray(this.viewList[i])) {
          if (!isNeedLoop) isNeedLoop = true
          this.$set(this.viewList, i, allList[i])
        } else if ((i < idx - 2 || i > idx + 2) && Array.isArray(this.viewList[i])) {
          if (!isNeedLoop) isNeedLoop = true
          this.viewList[i] = { height: boundings[i].height }
        }
      }
      if (isNeedLoop) return this.$mp.page.setData({}, this.handleViewList(idx))
      else return (isHandle = false)
    },
    preview(current, urls) {
      wx.previewImage({ current, urls })
      // setTimeout(() => {
      //   if (this.href) wx.navigateTo({ url: `/pages/webView/main?linkObjectStr=${this.href}` })
      //   else {
      //     wx.previewImage({
      //       current: src,
      //       urls
      //     })
      //   }
      // }, 100)
    },
    navigate(href) {
      this.href = href
    },
    async loadData(isPullUp = false) {
      if (limit || this.isShowFoot) return
      limit = true

      wx.showLoading({
        title: '加载中',
        mask: true
      })

      const apiName = 'qryArticleDetail'
      const params = {
        articleInfoId: articleid,
        locationxUser: longitude,
        locationyUser: latitude,
        pageSize,
        turnPageBeginPos: pageNum
      }

      let {
        body: {
          errorCode,
          articleName,
          updateArticleTime,
          articleVideoImg,
          articleContent,
          articleRelateMerchantsList,
          errorMsg
        }
      } = await this.$global.request(apiName, params).catch(() => {
        wx.hideLoading()
        return (limit = false)
      })

      if (errorCode === '0') {
        // 如果不是上拉加载，就加载头部信息
        if (!isPullUp) {
          this.info.title = articleName
          this.info.date = updateArticleTime.split(' ')[0]
          this.info.video = (articleVideoImg && articleVideoImg.split('#')) || ''
          this.content = decodeXML(articleContent)
        }
        // 返回商户数组是否为空
        if (!articleRelateMerchantsList.length) {
          this.isShowFoot = true
          limit = false
          return wx.hideLoading()
        }
        // 过滤冗余数据
        articleRelateMerchantsList = simplifyStoreList(articleRelateMerchantsList)

        let idx = pageNum - 1
        allList[idx] = articleRelateMerchantsList

        this.$set(this.viewList, idx, articleRelateMerchantsList)

        boundings[idx] = {
          height: articleRelateMerchantsList.length * itemRact.height,
          top: !idx ? itemRact.top : boundings[idx - 1].bottom,
          bottom: !idx
            ? itemRact.top + articleRelateMerchantsList.length * itemRact.height
            : boundings[idx - 1].bottom + articleRelateMerchantsList.length * itemRact.height
        }

        if (articleRelateMerchantsList.length < pageSize) this.isShowFoot = true

        pageNum++
        wx.hideLoading()
      } else wx.showToast({ title: errorMsg, icon: 'none' })

      limit = false
    },
    onClickStore(id) {
      if (limit) return
      limit = true
      isNav = true

      let obj = {}
      for (let i = 0; i < this.viewList.length; i++) {
        if (Array.isArray(this.viewList[i])) obj[`$root.0.viewList[${i}]`] = { height: boundings[i].height }
      }
      obj['$root.0.isShowVideo'] = false
      this.$mp.page.setData(obj)

      wx.navigateTo({ url: `/pages/storeOverview/main?storeid=${id}` })
    }
  }
}
</script>

<style lang="scss" scoped>
@import './index.scss';
/* @import url('~mpvue-wxparse/src/wxParse.css'); */
@import '../../../static/mpvue-wxparse/src/wxParse.css';
</style>

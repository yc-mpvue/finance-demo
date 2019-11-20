<template>
  <div class="personal-center">
    <!-- 头部 -->
    <div class="personal-center_header">
      <personal-card :userInfo="user"
        @showLoginDialog="showLoginDialog"
        @signSuccess="signSuccess"
        @handleBtn="nativageTo('userHomepage')">
      </personal-card>
    </div>
    <!-- 代金券 -->
    <div class="personal-center_ticket--wrapper">
      <div class="personal-center_ticket--item"
        @click="onFurtherAction('coupon')">
        <!-- <h3>代金券<img src="/static/images/icon_enter.png" alt=""></h3> -->
        <h3>优惠券</h3>
        <p>{{user.couponNum||0}}</p>
      </div>
      <div class="personal-center_ticket--item"
        @click="toIntegraMall">
        <!-- <h3>积分兑换<img src="/static/images/icon_enter.png" alt=""></h3> -->
        <h3>积分兑换</h3>
        <p>{{user.score||0}}</p>
      </div>
    </div>
    <!-- 图标部分 -->
    <div class="personal-center_icons">
      <div v-for="(item,index) in icons"
        :key="index"
        class="person-center_nativage flex-columm"
        @click="nativageTo(item.path)">
        <img :src="item.icon"
          alt />
        <p>{{item.title}}</p>
      </div>
    </div>
    <my-tabbar :selectNavIndex="4"
      @showUploadNav="showUploadNav=true" />

    <upload-nav :show="showUploadNav"
      @onHide="showUploadNav = false" />

    <!-- 新人好礼提示组件 -->
    <!-- <task-tips v-if="showTip"/> -->

    <!-- 授权弹窗确认层组件 -->
    <my-dialog :show-dialog="showDialog"
      login
      @confirm="hideDialog"
      @cancel="hideDialog"></my-dialog>
  </div>
</template>

<script>
import personalCard from '@/components/personalCard/index'
import myTabbar from '@/components/myTabbar/index'
import myDialog from '@/components/myDialog/index'
import utfTool from '@/common/utils/emoji.js'
import log from '@/common/utils/log.js'
import wxTools from '@/common/utils/wxTools.js'
import { toastTime } from '@/common/utils/config'
import { mapGetters } from 'vuex'
import uploadNav from '@/components/uploadNav'
// import taskTips from '../taskCenter/components/taskTips'

export default {
  data() {
    return {
      timer: null,
      showUploadNav: false,
      showDialog: false,
      // 个人中心图标图片、文字及相应地址
      // 增加时，需要修改样式布局（使用网格布局grid）
      icons: [
        {
          icon: require('static/images/icon_wddd.png'),
          title: '我的订单',
          path: 'myOrder'
        },
        {
          icon: require('static/images/icon_wdsc.png'),
          title: '我的收藏',
          path: 'myCollection'
        },
        {
          icon: require('static/images/icon_wddk.png'),
          title: '我的打卡',
          path: 'myDaka'
        },
        {
          icon: require('static/images/icon_dddp.png'),
          title: '等待点评',
          path: 'waitForComment'
        },
        {
          icon: require('static/images/icon_zjll.png'),
          title: '最近浏览',
          path: 'latelyBelook'
        },
        {
          icon: require('static/images/icon_wdgz.png'),
          title: '我的关注',
          path: 'followers'
        },
        {
          icon: require('static/images/icon_shdl.png'),
          title: '商户核销',
          path: 'shopkeeperLogin'
        },
        {
          icon: require('static/images/icon_shdl.png'),
          title: '商户进驻',
          path: 'shopkeeperSettlein'
        }
      ],
      showTip: false
    }
  },
  components: {
    personalCard,
    myDialog,
    myTabbar,
    uploadNav
    // taskTips
  },
  methods: {
    // 跳转到积分商城
    toIntegraMall() {
      const isLogined = wx.getStorageSync('SESSIONID')
      isLogined ? wx.navigateTo({ url: '/pages/integralMall/main' }) : wx.navigateTo({ url: '/pages/wxLogin/main' })
    },
    // 进一步提示, 或者进一步动作, 根据不同的点击范围而定, coupon, 代金券, score, 积分兑换
    onFurtherAction(typeStr) {
      var actionsList = {
        coupon: 'couponAction',
        score: 'scoreAction'
      }
      var act = actionsList[typeStr]
      act && this[act]()
    },
    couponAction() {
      log('coupon')
      // 增加登录控制
      const isLogined = wx.getStorageSync('SESSIONID') || false
      if (!isLogined) {
        wx.showToast({ title: '需要先登录! 即将跳转到登录页面', icon: 'none', duration: toastTime })
        this.timer = setTimeout(function() {
          wx.navigateTo({ url: '/pages/wxLogin/main' })
        }, 2200)
      } else {
        const url = `/pages/extraCouponList/main`
        wx.navigateTo({ url })
      }
    },
    scoreAction() {
      log('score')
      const title = `敬请期待`
      const icon = 'none'
      const duration = toastTime
      wx.showToast({ title, icon, duration })
    },

    signSuccess(scoreChange) {
      log('add point：', scoreChange, '************old score:', this.user.score)
      // 签到成功，前端修改积分值，切换页面回来获取userinfo接口刷新真实积分值
      this.user.score = parseInt(this.user.score) + parseInt(scoreChange)
      log('************after score:', this.user.score)
    },
    // 图标部分跳转
    nativageTo(path) {
      if (!this.user.userName && path != 'shopkeeperSettlein') this.showDialog = true
      else wx.navigateTo({ url: `../${path}/main` })
    },
    // 点击头像授权
    showLoginDialog() {
      this.showDialog = true
    },
    // 关闭登录弹窗
    hideDialog() {
      this.showDialog = false
    }
  },
  onLoad() {
    // 首次进入个人中心页面取vuex，无则本地缓存中取,本地缓存无则证明未登录，user不取值为空
    if (!this.user.userName) {
      let userStorage = wx.getStorageSync('userInfo')
      this.$store.commit('SET_USER', userStorage || {})
      log(this.user, '打开个人中心获取本地缓存userinfo')
    }
  },
  // 每次进入个人中心都刷新用户信息，获取更新后的头像
  async onShow() {
    wx.hideTabBar()
    if (!this.user.userName) return // 未登录状态，直接return
    // 本地中用户信息，头像审核状态是审核中的时候才刷新数据（因为积分也要刷新所以不以头像审核为准刷新用户信息）
    // if (this.user.userImgUrlCheckFlag == 2) {
    let qryUseInfoRes = await this.$global.request('qryUserInfo')
    if (qryUseInfoRes.body.errorCode != 0) {
      wx.showToast({
        title: `获取用户信息失败${qryUseInfoRes.errorMsg}`,
        icon: 'none',
        duration: toastTime
      })
      return
    }
    qryUseInfoRes.body.userName = utfTool.entitiesToUtf16(qryUseInfoRes.body.userName)
    log(qryUseInfoRes.body, '更新用户信息')
    this.$store.commit('SET_USER', qryUseInfoRes.body)
    wx.setStorageSync('userInfo', qryUseInfoRes.body)
  },
  async created() {
    const res = await this.$global.promisify(wx.getSetting)
    if (res.authSetting['scope.userInfo'] != true) {
      wx.removeStorageSync('SESSIONID') // 清除登录状态
      wx.removeStorageSync('userInfo') // 清除登录状态
      log('未授权用户信息，清除用户登录状态')
    } else log('已授权用户信息')

    // 获取foodType, 利用mpvue的bug, created一定会全部触发, 而写的hack
    wxTools.getFoodTypes()
  }
}
</script>

<style scoped lang="scss">
@import './index.scss';
</style>

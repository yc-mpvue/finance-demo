<template>
  <div>
    <div class="article-list">
      <div class="article-list-item"
        v-for="(item, idx) in list"
        :key="idx"
        @click="onClickItem()">
        <div class="article-list-item-title">{{item.articleName}}</div>
        <div class="article-list-item-date">{{item.updateTime}}</div>
        <div class="img" :style="{ backgroundImage: 'url('+ item.articlePageImg +')' }"></div>
      </div>

      <div class="article-list-foot">- 到底了哦 -</div>
    </div>
  </div>
</template>

<script>
import data from '../../mock/home.js'

export default {
  computed: {
    list() {
      return data
    }
  },
  methods: {
    onClickItem() {
      wx.navigateTo({ url: '../subPackageA/articleDetail/main' })
    }
  }
}
</script>

<style lang="scss" scoped>
@import './index.scss';
</style>

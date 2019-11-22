<template>
  <div class="article-detail">
    <div class="article-detail-title">{{data.title}}</div>
    <div class="article-detail-date">{{data.date}}</div>
    <div class="article-detail-html">
      <parser :html="data.content" lazy-load show-with-animation></parser>
    </div>
  </div>
</template>

<script>
import data from '../../../mock/articleDetail.js'

export default {
  computed: {
    data() {
      return data
    }
  }
}
</script>

<style lang="scss" scoped>
@import './index.scss';
</style>

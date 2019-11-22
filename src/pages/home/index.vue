<template>
  <div class="home">
    <div class="main">
      <swiper :autoplay="true"
        :indicator-dots="true"
        :circular="true"
        indicator-color='rgb(225, 225, 225)'>
        <swiper-item v-for='(item,index) in imgList'
          :key="index"
          @click="clickSwiper">
          <img src="/static/images/wddh.png"
            class="image"
            @click="toAdvertisement(item.link)" />
        </swiper-item>
      </swiper>
      <div class="icon-box">
        <div class="icon-box-item"
          v-for="(item, idx) in iconList"
          :key="idx"
          @click="onClickIcon(item.path)">
          <img :src="item.img" />
          <p>{{ item.name }}</p>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
export default {
  data () {
    return {
      iconList: [
        {
          img: '/static/images/icon_dktj.png',
          name: '顺德必吃',
          path: 'mustEat'
        },
        {
          img: '/static/images/icon_phb.png',
          name: '任务中心',
          path: 'taskCenter'
        },
        {
          img: '/static/images/icon_mszl.png',
          name: '吃游记',
          path: 'articleList',
          type: 2
        },
        {
          img: '/static/images/icon_gdms.png',
          name: '吃在顺德',
          path: 'articleList',
          type: 3
        }
      ],
      imgList: ['', '', '', '']
    }
  },
  methods: {
    onClickIcon (path) {

    },
    clickSwiper (path) {

    }
  },
  onLoad () {
    Object.assign(this.$data, this.$options.data())
  }
}
</script>

<style lang="scss" scoped>
@import "./index.scss";
.home {
  .main {
    /deep/ .image {
      height: 300rpx;
      width: 750rpx;
      background: grey;
    }
    .icon-box {
      display: flex;
      justify-content: space-around;
      margin: 30rpx 0;

      &-item {
        display: flex;
        flex-direction: column;
        flex: 1;
        align-items: center;

        img {
          width: 82rpx;
          height: 82rpx;
        }

        p {
          font-size: 24rpx;
          color: #333333;
          margin-top: 13rpx;
        }
      }
    }
  }
}
</style>
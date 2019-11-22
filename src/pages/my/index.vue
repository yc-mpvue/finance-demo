<template>
  <div class="my">
    <!-- 头部 -->
    
    <!-- 未登录状态部分 -->
    <div class="personal-card_unlogin"
      v-if="!userInfo.userName">
      <img class="personal-card_unlogin--bg"
        src="https://outin-27b06fc3a6d511e99db400163e00b174.oss-cn-shanghai.aliyuncs.com/image/default/7F97B1EB484549CB8C84C0242CA55F77-6-2.png"
        alt="">
      <img src="/static/images/head_wdl.png"
        class="personal-card_unlogin--icon"
        @click="showLoginDialog" />
      <p class="personal-card_unlogin--text"
        @click="showLoginDialog">点击授权登录</p>
    </div>
    <!-- 登录状态部分 -->
    <div class="personal-card_login"
      v-else>
      <img src="https://outin-27b06fc3a6d511e99db400163e00b174.oss-cn-shanghai.aliyuncs.com/image/default/492E675AF6FC4D788FA20C2EE533E081-6-2.png"
        class="personal-center_bk" />
      <div class="personal-header_card">
        <div class="personal-card_login--avatar">
          <img :src="userInfo.userImgUrl"
            alt />
        </div>
        <div class="personal-header_card--info">
          <div class="personal-header_card--name">
            <h1>用户名</h1>
            <div class="personal-header_card--p"
              @click="handleBtn">个人主页
            </div>
          </div>
          <div class="personal-header_card--count">
            <div class="count-info_info">
              <p>
                0
                <span>收藏</span>
              </p>
              <p>
                0
                <span>VIP等级</span>
              </p>
            </div>

          </div>
        </div>
      </div>
      <p class="personal-cenyer_header--viptips">升级VIP能够享受更多折扣优惠</p>
    </div>
    <!-- 代金券 -->
    <div class="personal-center_ticket--wrapper">
      <div class="personal-center_ticket--item"
        @click="onFurtherAction('coupon')">
        <h3>优惠券</h3>
        <p>0</p>
      </div>
      <div class="personal-center_ticket--item"
        @click="toIntegraMall">
        <h3>积分兑换</h3>
        <p>0</p>
      </div>
    </div>
    <!-- 图标部分 -->
    <div class="personal-center_icons">
      <div v-for="(item,index) in icons"
        :key="index"
        class="person-center_nativage flex-columm"
        @click="nativageTo(item.path)">
        <img src=""
          alt />
        <p>{{item.title}}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      userInfo:'',
      // 个人中心图标图片、文字及相应地址
      // 增加时，需要修改样式布局（使用网格布局grid）
      icons: [
        {
          // icon: require('static/images/icon_wddd.png'),
          title: '我的订单',
          path: 'myOrder'
        },
        {
          // icon: require('static/images/icon_wdsc.png'),
          title: '我的收藏',
          path: 'myCollection'
        },
        {
          // icon: require('static/images/icon_wddk.png'),
          title: '我的打卡',
          path: 'myDaka'
        },
        {
          // icon: require('static/images/icon_dddp.png'),
          title: '等待点评',
          path: 'waitForComment'
        },
        {
          // icon: require('static/images/icon_zjll.png'),
          title: '最近浏览',
          path: 'latelyBelook'
        },
        {
          // icon: require('static/images/icon_wdgz.png'),
          title: '我的关注',
          path: 'followers'
        },
        {
          // icon: require('static/images/icon_shdl.png'),
          title: '商户核销',
          path: 'shopkeeperLogin'
        },
        {
          // icon: require('static/images/icon_shdl.png'),
          title: '商户进驻',
          path: 'shopkeeperSettlein'
        }
        // {
        //   icon: require('static/images/icon_shdl.png'),
        //   title: 'imgDebugger',
        //   path: 'debugPage'
        // }
        // {
        //   icon: require('static/images/icon_shdl.png'),
        //   title: '进驻进度',
        //   path: 'shopkeeperSettleinProgress'
        // },
      ]
    }
  },
  methods: {
    onFurtherAction(){
      console.log('点击优惠卷');
    },
    nativageTo(){
      console.log('跳转方法');
    },
    showLoginDialog(){
      console.log('弹窗');
    }
  }
}
</script>

<style lang="scss" scoped>
@import './index.scss';
</style>
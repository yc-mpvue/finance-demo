<template>
  <div class="inviteRecord">
    <img class="banner"
      src="https://outin-27b06fc3a6d511e99db400163e00b174.oss-cn-shanghai.aliyuncs.com/image/default/764E7D225FD14A5F97CEAFBEFCB4591A-6-2.png"
      alt="">
    <div class="main">
      <div class="content">
        <p class="tip">
          奖励发放情况：<span>{{tipMessage}}</span>
        </p>
        <h1>
          <img src="/static/images/yqjl.png"
            alt="">
          <p>邀请记录</p>
          <img src="/static/images/yqjl.png"
            alt="">
        </h1>
        <div class="inviteList">
          <header class="header">
            <div>序号</div>
            <div>邀请账号</div>
            <div>成功邀请时间</div>
          </header>
          <section class="messageList">
            <div class="messageList-wrapper">
              <div class="messageItem"
                v-for="(item,index) in inviteList"
                :key="index">
                <div>{{index>=9?index+1:'0'+(index+1)}}</div>
                <div>{{item.phone}}</div>
                <div>{{item.inviteTime}}</div>
              </div>
            </div>
          </section>
        </div>
        <div class="explain">
          <h1>活动说明：</h1>
          <p>{{activityDesc}}</p>
        </div>
      </div>
      <button class="inviteButton"
        open-type='share'>立即邀请好友</button>
    </div>
  </div>
</template>
<script>
const tips = [
  '你还未完成任务，赶快去邀请好友吧',
  '已发放任务奖励',
  '来晚了~奖励已被领光'
]

export default {
  data () {
    return {
      tipMessage: tips[1],
      inviteList: [
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        },
        {
          phone: '13411221242',
          inviteTime: '2019.06.20 14:00:00'
        }
      ],
      shareLogoImg: '',
      shareTitle: '',
      activityDesc: '1.邀请好友介绍 邀请他人注册CNstorm,邀请越多,获得奖励机会越多,不设上限。受邀人注册和每完成一次付款成功的国际包裹寄送,你将按比例获得该包裹的支付金额的现金奖励。'
    }
  },
}
</script>
<style lang="scss" scoped>
.inviteRecord {
  margin-bottom: 40rpx;

  .banner {
    height: 300rpx;
    width: 750rpx;
  }
  .main {
    .content {
      padding: 0 32rpx;

      .tip {
        margin-top: 25rpx;
        font-size: 28rpx;
        color: #333333;
        span {
          color: #ffa100;
          line-height: 40rpx;
        }
      }
      h1 {
        margin-top: 39rpx;
        font-size: 34rpx;
        color: #333333;
        line-height: 34rpx;
        display: flex;
        justify-content: center;
        align-items: center;
        p {
          margin: 0 19rpx;
        }
        img {
          height: 25rpx;
          width: 24rpx;
        }
      }
      .inviteList {
        margin-top: 30rpx;
        padding: 33rpx 22rpx 40rpx 27rpx;
        height: 470rpx;
        width: 686rpx;
        background: #fff6e6;
        border-radius: 10rpx;
        box-sizing: border-box;

        .header {
          display: flex;
          font-size: 30rpx;
          color: #4e300f;
          div:nth-child(1) {
            width: 103rpx;
          }
          div:nth-child(2) {
            width: 248rpx;
          }
        }
        .messageList {
          margin-top: 43rpx;
          color: #333333;
          overflow-y: auto;
          height: 310rpx;
          .messageList-wrapper {
            .messageItem {
              font-size: 28rpx;
              display: flex;
              margin-bottom: 30rpx;

              div {
                height: 40rpx;
              }
              div:nth-child(1) {
                width: 103rpx;
              }
              div:nth-child(2) {
                width: 248rpx;
              }
              &:last-child {
                margin-bottom: 0;
              }
            }
          }
        }
      }
      .explain {
        margin: 30rpx 0;
        font-size: 28rpx;
        color: #333333;
        h1 {
          text-align: left;
        }
        p {
          word-wrap: break-word;
          word-break: break-all;
          margin-top: 19rpx;
        }
      }
    }
    .inviteButton {
      height: 100rpx;
      width: 700rpx;
      font-size: 32rpx;
      color: #ffffff;
      background: #e72935;
      text-align: center;
      line-height: 100rpx;
      border-radius: 0;
    }
  }
}
</style>

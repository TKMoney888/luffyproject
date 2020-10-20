<template>
  <div class="user-order">
    <Header/>
    <div class="main">
        <div class="banner"></div>
          <div class="profile">
              <div class="profile-info">
                  <div class="avatar"><img class="newImg" width="100%" alt="" src="/static/image/logo@2x.png"></div>
                  <span class="user-name">Mixtea</span>
                  <span class="user-job">深圳市 | 程序员</span>
              </div>
              <ul class="my-item">
                  <li>我的账户</li>
                  <li class="active"><router-link to="/user/order">我的订单</router-link></li>
                  <li>个人资料</li>
                  <li>账号安全</li>
              </ul>
          </div>
          <router-view></router-view>
    </div>
    <Footer/>
  </div>
</template>

<script>
  import Header from "./common/Header"
  import Footer from "./common/Footer"
  export default{
    name:"User",
    data(){
      return {

      };
    },
    components:{
      Header,
      Footer,
    }
  }
</script>

<style scoped>
.main .banner{
    width: 100%;
    height: 324px;
    background: url(/static/image/my_bkging.0648ebe.png) no-repeat;
    background-size: cover;
    z-index: 1;
}
.profile{
    width: 1200px;
    margin: 0 auto;
}
.profile-info{
    text-align: center;
    margin-top: -80px;
}
.avatar{
    width: 120px;
    height: 120px;
    border-radius: 60px;
    overflow: hidden;
    margin: 0 auto;
}
.user-name{
    display: block;
    font-size: 24px;
    color: #4a4a4a;
    margin-top: 14px;
}
.user-job{
    display: block;
    font-size: 11px;
    color: #9b9b9b;
 }
.my-item{
    list-style: none;
    line-height: 1.42857143;
    color: #333;
    width: 474px;
    height: 31px;
    display: -ms-flexbox;
    display: flex;
    cursor: pointer;
    margin: 41px auto 0;
    -ms-flex-pack: justify;
    justify-content: space-between;
}
.my-item .active{
    border-bottom: 1px solid #000;
}
.user-data-list li{
    height: 60px;
    line-height: 60px;
}

.user-data-list .order-info img{
    max-width: 100px;
    max-height: 75px;
    margin-right: 22px;
}
</style>

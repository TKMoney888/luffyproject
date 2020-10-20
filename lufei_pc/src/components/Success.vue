<template>
  <div class="success" v-if="show_page">
    <Header/>
    <div class="main">
        <div class="title">
<!--          <img src="../../static/images/right.svg" alt="">-->
          <div class="success-tips">
              <p class="tips1">您已成功购买 1 门课程！</p>
              <p class="tips2">你还可以加入QQ群 <span>747556033</span> 学习交流</p>
          </div>
        </div>
        <div class="order-info">
            <p class="info1"><b>付款时间：</b><span>{{format(order_info.pay_time)}}</span></p>
            <p class="info2"><b>付款金额：</b><span >{{order_info.real_price.toFixed(2)}}</span></p>
            <p class="info3"><b>课程信息：</b>
              <router-link :key="key" :to="`/course/${course.course_id}`" v-for="course,key in order_info.course_list">《{{course.course_name}}》</router-link>
            </p>
        </div>
        <div class="study">
          <span>立即学习</span>
        </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
  import Header from "./common/Header"
  import Footer from "./common/Footer"
  export default{
    name:"Success",
    data(){
      return {
        show_page: false,
        order_info:{
            pay_time: "",
            course_list:[],
            real_price:0.0
        },
      };
    },
    created(){
      // 把地址栏上面的支付结果，转发给后端
      this.$axios.get("/payments/alipay/result"+location.search).then(response=>{
          this.show_page=true;
          this.order_info=response.data;
      }).catch(error=>{
          if(error.response.status == 404){
              this.$message.success("当前订单已经成功支付！");
              this.$router.push("/user");
          }else{
              console.log(error.response.data);
          }
      })
    },
    methods:{
      format(timestamp){
          let date = new Date(timestamp*1000);
          let Y = date.getFullYear();
          let m = this.full_zero(date.getMonth()+1);
          let d = this.full_zero(date.getDate());
          let H = this.full_zero(date.getHours());
          let i = this.full_zero(date.getMinutes());
          return `${Y}/${m}/${d} ${H}:${i}`;
      },
      full_zero(num){
          return num<10?'0'+num:num;
      },
    },
    components:{
      Header,
      Footer,
    }
  }
</script>

<style scoped>
.success{
  padding-top: 80px;
}
.main{
    height: 100%;
    padding-top: 25px;
    padding-bottom: 25px;
    margin: 0 auto;
    width: 1200px;
    background: #fff;
}
.main .title{
    display: flex;
    -ms-flex-align: center;
    align-items: center;
    padding: 25px 40px;
    border-bottom: 1px solid #f2f2f2;
}
.main .title .success-tips{
    box-sizing: border-box;
}
.title img{
    vertical-align: middle;
    width: 60px;
    height: 60px;
    margin-right: 40px;
}
.title .success-tips{
    box-sizing: border-box;
}
.title .tips1{
    font-size: 22px;
    color: #000;
}
.title .tips2{
    font-size: 16px;
    color: #4a4a4a;
    letter-spacing: 0;
    text-align: center;
    margin-top: 10px;
}
.title .tips2 span{
    color: #ec6730;
}
.order-info{
    padding: 25px 48px;
    padding-bottom: 15px;
    border-bottom: 1px solid #f2f2f2;
}
.order-info p{
    display: -ms-flexbox;
    display: flex;
    margin-bottom: 10px;
    font-size: 16px;
}
.order-info p b{
  font-weight: 400;
  color: #9d9d9d;
  white-space: nowrap;
}
.wechat-code{
    display: flex;
    -ms-flex-align: center;
    align-items: center;
    padding: 25px 40px;
    border-bottom: 1px solid #f2f2f2;
}
.wechat-code>img{
    width: 100px;
    height: 100px;
    margin-right: 15px;
}
.wechat-code p{
    font-size: 14px;
    color: #d0021b;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-align: center;
    align-items: center;
}
.wechat-code p>img{
    width: 16px;
    height: 16px;
    margin-right: 10px;
}
.study{
      padding: 25px 40px;
}
.study span{
  display: block;
  width: 140px;
  height: 42px;
  text-align: center;
  line-height: 42px;
  cursor: pointer;
  background: #ffc210;
  border-radius: 6px;
  font-size: 16px;
  color: #fff;
}
</style>

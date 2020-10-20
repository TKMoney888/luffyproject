<template>
  <div class="user-data">
      <ul class="nav">
        <li class="order-info">订单</li>
        <li class="course-expire">有效期</li>
        <li class="course-price">课程价格</li>
        <li class="real-price">实付金额</li>
        <li class="order-status">交易状态</li>
        <li class="order-do">交易操作</li>
      </ul>
      <div class="my-order-item" v-for="order,key in order_list">
          <div class="user-data-header">
            <span class="order-time">下单时间：{{format(order.created_time)}}</span>
            <span class="order-num">订单号：
                <span class="my-older-number">{{order.order_number}}</span>
            </span>
            <span class="btn btn2" v-if="order.order_status==0" @click="cancelPay(order.order_number,key)">取消订单</span>
          </div>
          <ul class="nav user-data-list" v-for="order_detail in order.order_courses">
            <li class="order-info">
                <img :src="order_detail.course.course_img" alt="">
                <div class="order-info-title">
                  <p class="course-title">{{order_detail.course.name}}</p>
                  <p class="price-service" v-if="order_detail.discount_name">{{order_detail.discount_name}}</p>
                </div>
            </li>
            <li class="course-expire">{{order_detail.expire_text}}</li>
            <li class="course-price">{{order_detail.price}}</li>
            <li class="real-price">{{order_detail.real_price}}</li>
            <li class="order-status" v-if="order.order_status==0">等待支付</li>
            <li class="order-status" v-if="order.order_status==1">交易成功</li>
            <li class="order-status" v-if="order.order_status==2">交易取消</li>
            <li class="order-status" v-if="order.order_status==3">超时取消</li>
            <li class="order-do">
              <span class="btn" v-if="order.order_status==0" @click="payhander(order.order_number)">去付款</span>
              <span class="btn" v-if="order.order_status==1" @click="goto_play(order_detail.course.id)">去学习</span>
            </li>
          </ul>
      </div>

  </div>
</template>

<script>
  import Header from "./common/Header"
  import Footer from "./common/Footer"
  export default{
    name:"UserOrder",
    data(){
      return {
          token:"",
          order_list:[],
      };
    },
    created(){
      // 获取登录信息
      this.token = this.$settings.checkUserLogin(this);
      if(this.token){
          this.get_my_orders();
      }
    },
    methods:{
      format(timestamp){
          let date = new Date(timestamp);
          let Y = date.getFullYear();
          let m = this.full_zero(date.getMonth()+1);
          let d = this.full_zero(date.getDate());
          let H = this.full_zero(date.getHours());
          let i = this.full_zero(date.getMinutes());
          let s = this.full_zero(date.getSeconds());
          return `${Y}-${m}-${d} ${H}:${i}:${s}`;
      },
      full_zero(num){
          return num<10?'0'+num:num;
      },
      get_my_orders(){
        this.$axios.get(`/orders/list/`,{
          headers:{
            "Authorization":"jwt " + this.token,
          },
        }).then(response=>{
          this.order_list = response.data;
        }).catch(error=>{
          console.log( error.response )
        });
      },
      payhander(order_number){
          // 发起支付处理
          this.$axios.get(`/payments/alipay/`,{
              params:{
                  order_number,  // order_number: order_number
              },
              headers:{
                Authorization: "jwt " + this.$settings.checkUserLogin(this),
            }
          }).then(response=>{
              // 发挥链接地址
              location.href=response.data;
          }).catch(error=>{
              console.log(error.response.data.message);
          })
      },
      cancelPay(order_number,key){
          this.$confirm("您确定要取消当前订单么？","提示",{
            confirmButtonText: '取消订单',
            cancelButtonText: '保留订单',
            type: 'warning'
          }).then(()=>{
            // 取消订单
            this.$axios.patch(`/orders/cancel/`,{order_number},{
                headers:{
                  Authorization: "jwt " + this.$settings.checkUserLogin(this),
              }
            }).then(response=>{
                // 取消订单成功
                console.log(this.order_list[key]);
                this.order_list[key].order_status = 2;
            }).catch(error=>{
                console.log(error.response.data.message);
            });
          }).catch(()=>{

          });
      },
       goto_play(course_id){
          // 去学习
          localStorage.course_id = course_id;
          this.$router.push("/player");
       }
    },
    components:{
      Header,
      Footer,
    }
  }
</script>

<style scoped>
.user-data{
    width: 1200px;
    height: auto;
    margin: 0 auto;
    padding-top: 30px;
    border-top: 1px solid #e8e8e8;
    margin-bottom: 63px;
}
.nav{
    width: 100%;
    height: 60px;
    background: #e9e9e9;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-align: center;
    align-items: center;
}
.nav li{
    margin-left: 20px;
    margin-right: 28px;
    height: 60px;
    line-height: 60px;
    list-style: none;
    font-size: 13px;
    color: #333;
    border-bottom: 1px solid #e9e9e9;
    width: 160px;
}
.nav .order-info{ width: 400px; }
.nav .course-expire{ width: 60px; }
.nav .course-price{ width: 130px; }
.user-data-header{
    display: flex;
    height: 44px;
    color: #4a4a4a;
    font-size: 14px;
    background: #f3f3f3;
    -ms-flex-align: center;
    align-items: center;
    position: relative;
}
.order-time{
    font-size: 12px;
    display: inline-block;
    margin-left: 20px;
}
.order-num{
    font-size: 12px;
    display: inline-block;
    margin-left: 29px;
}
.user-data-list{
    height: 100%;
    display: flex;
}
.user-data-list{
  background: none;
}
.user-data-list li{
    height: 60px;
    line-height: 60px;
}
.user-data-list .order-info{
    display: flex;
    align-items: center;
    margin-right: 28px;
}
.user-data-list .order-info img{
    max-width: 100px;
    max-height: 75px;
    margin-right: 22px;
}
.course-title{
    width: 203px;
    font-size: 13px;
    color: #333;
    line-height: 20px;
    margin-top: -10px;
}
.order-info-title .price-service{
    line-height: 18px;
}
.price-service{
    font-size: 12px;
    color: #fa6240;
    padding: 0 5px;
    border: 1px solid #fa6240;
    border-radius: 4px;
    margin-top: 4px;
    position: absolute;
}
.order-info-title{
    margin-top: -10px;
}
.user-data-list .course-expire{
    font-size: 12px;
    color: #ff5502;
    width: 80px;
    text-align: center;
}
.btn {
  width: 100px;
  height: 32px;
  font-size: 14px;
  color: #fff;
  background: #ffc210;
  border-radius: 4px;
  border: none;
  outline: none;
  transition: all .25s ease;
  display: inline-block;
  line-height: 32px;
  text-align: center;
  cursor: pointer;
}
.btn2{
  position: absolute;
  right: 62px;
  top: 0;
  bottom: 0;
  margin: auto;
  background: antiquewhite;
  color: rebeccapurple;
}
</style>

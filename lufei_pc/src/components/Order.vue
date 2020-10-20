<template>
  <div class="cart">
    <Header/>
    <div class="cart-info">
        <h3 class="cart-top">购物车结算 <span>共{{course_list.length}}门课程</span></h3>
        <div class="cart-title">
           <el-row>
             <el-col :span="2">&nbsp;</el-col>
             <el-col :span="10">课程</el-col>
             <el-col :span="8">有效期</el-col>
             <el-col :span="4">价格</el-col>
           </el-row>
        </div>
        <div class="cart-item">
          <el-row :key="key" v-for="course,key in course_list">
             <el-col :span="2" class="checkbox">&nbsp;&nbsp;</el-col>
             <el-col :span="10" class="course-info">
               <router-link :to="`/course/${course.course_id}`"><img :src="$settings.Host+course.course_img" alt=""></router-link>
               <span class="course-title">
               <router-link :to="`/course/${course.course_id}`">{{course.course_name}}</router-link>
               <br>
               <span v-if="parseFloat(course.price)>parseFloat(course.discount_price)">{{course.discount_name}}</span>
               </span>
             </el-col>
             <el-col :span="8"><span>{{course.expire_text}}</span></el-col>
             <el-col :span="4" class="course-price" v-if="course.price>course.discount_price">¥{{course.discount_price}}<br><span>原价 ¥{{course.price}}</span></el-col>
             <el-col :span="4" class="course-price" v-else>¥ {{course.discount_price}}</el-col>
           </el-row>
        </div>
        <div class="discount">
          <div id="accordion">
            <div class="coupon-box">
              <div class="icon-box">
                <span class="select-coupon">使用优惠劵：</span>
                <a class="select-icon" @click="use_coupon=!use_coupon"><img class="sign" :class="use_coupon?'is_show_select':''" src="../../static/image/12.png" alt=""></a>
                <span class="coupon-num">有{{coupon_list.length}}张可用</span>
              </div>
              <p class="sum-price-wrap">商品总金额：<span class="sum-price">{{total_price}}元</span></p>
            </div>
            <div id="collapseOne" v-if="use_coupon">
              <ul class="coupon-list" v-if="coupon_list.length>0">
                <li class="coupon-item"
                    v-for="item in coupon_list"
                    :class="coupon_class(item,false)"
                    @click="select_coupon(item,true)"
                >
                  <p class="coupon-name">{{item.coupon.name}}</p>
                  <p class="coupon-condition" v-if="item.coupon.condition>0">满{{item.coupon.condition}}元可以使用</p>
                  <p class="coupon-condition" v-else>任意使用</p>
                  <p class="coupon-time start_time">开始时间：{{format(item.start_timestamp)}}</p>
                  <p class="coupon-time end_time">过期时间：{{format(item.end_timestamp)}}</p>
                </li>
              </ul>
              <div class="no-coupon" v-else>
                <span class="no-coupon-tips">暂无可用优惠券</span>
              </div>
            </div>
          </div>
          <div class="credit-box" v-if="real_total_price>0">
            <label class="my_el_check_box"><el-checkbox class="my_el_checkbox" v-model="use_credit"></el-checkbox></label>
            <p class="discount-num1" v-if="!use_credit">使用我的贝里</p>
            <p class="discount-num2" v-if="use_credit"><span>总积分：{{my_credit-current_credit}}，可以抵扣 <el-input-number :min="0" :max="max_credit" size="mini" v-model="current_credit"></el-input-number> 积分， 已抵扣￥{{credit_price}}元</span></p>
          </div>
          <p class="sun-coupon-num">优惠券抵扣：<span>{{coupon_price.toFixed(2)}}元</span></p>
        </div>
        <div class="calc">
            <el-row class="pay-row">
              <el-col :span="4" class="pay-col"><span class="pay-text">支付方式：</span></el-col>
              <el-col :span="8">
                <span class="alipay" @click="pay_type=1" v-if="pay_type!=1"><img src="../../static/image/alipay.png" alt="支付宝"></span>
                <span class="alipay" v-if="pay_type==1"><img src="../../static/image/alipay2.png" alt="支付宝"></span>
                <span class="alipay wechat" @click="pay_type=2" v-if="pay_type!=2"><img src="../../static/image/wechat.png" alt="微信支付"></span>
                <span class="alipay wechat" v-if="pay_type==2"><img src="../../static/image/wechat2.png" alt="微信支付"></span>
              </el-col>
              <el-col :span="8" class="count">实付款： <span>¥{{real_total_price}}</span></el-col>
              <el-col :span="4" class="cart-pay"><span @click="gotopay">立即支付</span></el-col>
            </el-row>
        </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
  import Header from "./common/Header"
  import Footer from "./common/Footer"
  export default {
    name:"Order",
    data(){
      return {
        token: "",
        course_list: [],     // 勾选商品列表
        use_coupon: false, // 是否使用优惠券
        use_credit: false, // 是否使用积分
        coupon_list: [  // 用户的优惠券列表
        ],
        coupon: 0,   // 当前用户选择的优惠券ID
        coupon_price: 0, // 优惠券抵扣价格
        my_credit: 0, // 用户拥有的积分
        current_credit: 0,       // 本次订单可以使用的积分
        credit_rmb: 0, // 积分兑换比率
        credit_price: 0,  // 积分折算价格
        pay_type: 1,  // 支付方式
      }
    },
    watch:{
        use_coupon(){
            if (!this.use_coupon ){
                this.coupon= 0;
                this.coupon_price = 0;
            }
        },
        current_credit(){
            this.credit_price = parseFloat(this.current_credit / this.credit_rmb).toFixed(2);

        },
        use_credit(){
            // 如果用户关闭了积分兑换窗口，则还原积分
            this.current_credit = 0;
        }
    },
    components:{
      Header,
      Footer,
    },
    created(){
        this.my_credit = sessionStorage.credit;
        this.credit_rmb = sessionStorage.credit_rmb;
        if( this.my_credit == null || this.credit_rmb == null ){
            this.$message.error("登录信息已失效！请重新登录！");
            localStorage.removeItem("token");
            sessionStorage.removeItem("token");
        }
        this.token = this.$settings.checkUserLogin(this);
        if(this.token){
          this.get_course_list();
          this.get_user_coupon();
        }else{
          this.$router.push("/login");
        }
    },
    computed:{
        total_price(){
            let price = 0;
            for(let course of this.course_list){
                price += parseFloat(course.discount_price);
            }
            return price.toFixed(2);
        },
        real_total_price(){
            return (this.total_price - this.coupon_price - this.credit_price).toFixed(2)
        },
        max_credit(){
           // 计算用户本次订单中能使用的最大积分数量
           let price_to_credit = (this.total_price - this.coupon_price) * this.credit_rmb;
           if(this.my_credit < price_to_credit){
               return parseInt(this.my_credit)
           }else{
               return price_to_credit;
           }
        },
    },
    methods: {
      coupon_class(user_coupon,error_type){
          if(this.check_coupon(user_coupon,error_type)){
            if(this.coupon == user_coupon.id){
                return "active";
            }else{
                return "";
            }
          }else{
            return "disable";
          }
      },
      check_coupon(user_coupon,error_type){
          let can_use = false;
          let error_message = "";

          let sale_course = user_coupon.coupon.course_info;
          let sale_course_price = 0;
          for(let course of this.course_list){
              if(course.course_id == sale_course.course_id){
                  sale_course_price = course.discount_price
              }
          }
          if(sale_course_price < user_coupon.coupon.condition){
            // 判断优惠券是否符合使用条件
            error_message = `对不起,当前优惠券的使用条件是《${sale_course.course_name}》价格在${user_coupon.coupon.condition}元以上才可以使用!`;
          }else if(user_coupon.start_timestamp > user_coupon.now_timestamp){
              error_message = "对不起,当前优惠券没有到启用时间!";
          }else if(user_coupon.end_timestamp < user_coupon.now_timestamp){
              error_message="对不起,当前优惠券已过期!";
          }else if(user_coupon.coupon.coupon_type === 1 && this.total_price < user_coupon.coupon.condition){
              error_message = "对不起,本次订单金额无法使用当前优惠券!";
          }else if(user_coupon.coupon.coupon_type === 2){
              for(let course of this.course_list){
                  if(course.course_id == user_coupon.coupon.course_info.course_id){
                      can_use = true;
                  }
              }

              if(can_use === false && error_message == ""){
                  error_message = `对不起,本次订单只能在购买${user_coupon.coupon.course_info.course_name}!`;
              }
          }else{
              can_use = true;
          }

          if(error_type && error_message){
            this.$message.warning(error_message);
          }

          return can_use;
      },
      select_coupon(user_coupon,error_type){
          if(this.check_coupon(user_coupon,error_type)){
            this.coupon = user_coupon.id;
            let sale = parseFloat(user_coupon.coupon.sale.substr(1));
            if(user_coupon.coupon.coupon_type==1){
                this.coupon_price=sale;
            }else if(user_coupon.coupon.coupon_type==2){
              //折扣
              let course_id = user_coupon.coupon.course_info.course_id;
              let course_info ;
              for (let course of this.course_list){
                  if(course.course_id == course_id){
                      course_info = course;
                      break
                  }
              }

              if (parseFloat(course_info.discount_price) < parseFloat(course_info.discount_price)){
                  this.coupon_price = 0;
              }else{
                  this.coupon_price=course_info.discount_price * (1 - sale);
              }
            }
          }
      },
      format(timestamp){
          let date = new Date(timestamp*1000);
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
      get_user_coupon(){
          // 获取当前用户的所有优惠券
          let user_id =  sessionStorage.user_id || localStorage.user_id;
          this.$axios.get(`/coupon/`,{
              params:{
                  user_id: user_id,
                  is_user: false,
              },
              headers:{
                  Authorization: "jwt " + this.token,
              }
          }).then(response=>{
              this.coupon_list = response.data;
          }).catch(error=>{
              console.log(error.response.data);
          });
        },
      get_course_list(){
        this.$axios.get(`/cart/select/`,{
            headers:{
                Authorization: "jwt " + this.$settings.checkUserLogin(this),
            }
        }).then(response=>{
            // console.log(response);
            this.course_list = response.data;
        }).catch(error=>{
            console.log(error.response.data)
        })
      },
      gotopay() {
          // 上传订单相关信息
          this.$axios.post(`/orders/`, {
              pay_type: 1,
              credit: this.current_credit,
              coupon: this.coupon,
          },{
            headers:{
                Authorization: "jwt " + this.$settings.checkUserLogin(this),
            }
          }).then(response=>{
              // 扣除积分
              sessionStorage.user_credit-=this.current_credit;
              this.my_credit-=this.current_credit;

              // 扣除优惠券

              // 发起支付
              this.payhander(response.data.order_number);
          }).catch(error=>{
              console.log(error.response);
          })
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
      }
    }
  }
</script>

<style scoped>
.cart{
  margin-top: 80px;
}
.cart-info{
  overflow: hidden;
  width: 1200px;
  margin: auto;
}
.cart-top{
  font-size: 18px;
  color: #666;
  margin: 25px 0;
  font-weight: normal;
}
.cart-top span{
    font-size: 12px;
    color: #d0d0d0;
    display: inline-block;
}
.cart-title{
    background: #F7F7F7;
    height: 70px;
}
.calc{
  margin-top: 25px;
  margin-bottom: 40px;
}

.calc .count{
  text-align: right;
  margin-right: 10px;
  vertical-align: middle;
}
.calc .count span{
    font-size: 36px;
    color: #333;
}
.calc .cart-pay{
    margin-top: 5px;
    width: 110px;
    height: 38px;
    outline: none;
    border: none;
    color: #fff;
    line-height: 38px;
    background: #ffc210;
    border-radius: 4px;
    font-size: 16px;
    text-align: center;
    cursor: pointer;
}
.cart-item{
  height: 120px;
  line-height: 120px;
  margin-bottom: 30px;
}
.course-info img {
  width: 175px;
  height: 115px;
  margin-right: 35px;
  vertical-align: middle;
  float: left;
}
.course-title{
  float: left;
  line-height: 32px;
  margin-top: 26px;
}
.course-price{
  line-height: 32px;
  margin-top: 32px;
}
.course-price span{
  text-decoration: line-through;
  color: #5e5e5e;
}
.alipay{
  display: inline-block;
  height: 48px;
  cursor: pointer;
}
.alipay img{
  height: 100%;
  width:auto;
}

.pay-text{
  display: block;
  text-align: right;
  height: 100%;
  line-height: 100%;
  vertical-align: middle;
  margin-top: 20px;
}
.discount{
  text-align: right;
  margin-top: 30px;
}
.coupon-box{
  text-align: left;
  padding-bottom: 22px;
  padding-left:30px;
  border-bottom: 1px solid #e8e8e8;
}
.coupon-box::after{
  content: "";
  display: block;
  clear: both;
}
.icon-box{
  float: left;
}
.icon-box .select-coupon{
  float: left;
  color: #666;
  font-size: 16px;
}
.icon-box::after{
  content:"";
  clear:both;
  display: block;
}
.select-icon{
  width: 20px;
  height: 20px;
  float: left;
}
.select-icon img{
  max-height:100%;
  max-width: 100%;
  margin-left: 10px;
  margin-top: 2px;
  transform: rotate(-90deg);
  transition: transform .5s;
}
.is_show_select{
  transform: rotate(0deg)!important;
}
.coupon-num{
    height: 22px;
    line-height: 22px;
    padding: 0 5px;
    text-align: center;
    font-size: 12px;
    float: left;
    color: #fff;
    letter-spacing: .27px;
    background: #fa6240;
    border-radius: 2px;
    margin-left: 20px;
}
.sum-price-wrap{
    float: right;
    font-size: 16px;
    color: #4a4a4a;
    margin-right: 45px;
}
.sum-price-wrap .sum-price{
  font-size: 18px;
  color: #fa6240;
}

.no-coupon{
  text-align: center;
  width: 100%;
  padding: 50px 0px;
  align-items: center;
  justify-content: center; /* 文本两端对其 */
  border-bottom: 1px solid rgb(232, 232, 232);
}
.no-coupon-tips{
  font-size: 16px;
  color: #9b9b9b;
}
.credit-box{
  height: 30px;
  margin-top: 40px;
  display: flex;
  align-items: center;
  justify-content: flex-end
}
.my_el_check_box{
  position: relative;
}
.my_el_checkbox{
  margin-right: 10px;
  width: 16px;
  height: 16px;
}
.discount-num1{
  color: #9b9b9b;
  font-size: 16px;
  margin-right: 45px;
}
.discount-num2{
  margin-right: 45px;
  font-size: 16px;
  color: #4a4a4a;
}
.sun-coupon-num{
  margin-right: 45px;
  margin-bottom:43px;
  margin-top: 40px;
  font-size: 16px;
  color: #4a4a4a;
  display: inline-block;
}
.sun-coupon-num span{
  font-size: 18px;
  color: #fa6240;
}
.coupon-list{
  margin: 20px 0;
}
.coupon-list::after{
  display: block;
  content:"";
  clear: both;
}
.coupon-item{
  float: left;
  margin: 15px 8px;
  width: 180px;
  height: 100px;
  padding: 5px;
  background-color: #29c6e5;
  cursor: pointer;
}
.coupon-list .active{
  background-color: #ff0000;
  position: relative;
}
.coupon-list .active::after{
  border-left: 3px solid #ffffff;
  border-bottom: 3px solid #ffffff;
  display: block;
  content: "";
  width:40px;
  height: 20px;
  position: absolute;
  bottom: 20px;
  right: 0;
  transform: rotate(-45deg);
}
.coupon-list .disable{
  cursor: not-allowed;
  background-color: #f9b6b6;
  opacity: 0.7;
}
.coupon-condition{
  font-size: 12px;
  text-align: center;
  color: #fff;
}
.coupon-name{
  color: #fff;
  font-size: 24px;
  text-align: center;
}
.coupon-time{
  text-align: left;
  color: #fff;
  font-size: 12px;
}
</style>

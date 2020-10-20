<template>
	<div class="box">
		<img src="/static/image/Loginbg.3377d0c.jpg" alt="">
		<div class="register">
			<div class="register_box">
        <div class="register-title">注册路飞学城</div>
				<div class="inp">
					<input v-model = "mobile" type="text" placeholder="手机号码" class="user">
          <input v-model = "password" type="password" placeholder="密码" class="user">
					<input v-model = "password2" type="password" placeholder="确认密码" class="user">
					<div class="sms">
            <input v-model="sms" maxlength="16" type="text" placeholder="输入验证码" class="user">
            <span class="get_sms" @click="send_sms">{{get_sms_text}}</span>
          </div>
          <div id="geetest"></div>
					<button class="register_btn" @click="registerHandler">注册</button>
					<p class="go_login" >已有账号 <router-link to="/login">直接登录</router-link></p>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
export default {
  name: 'Register',
  data(){
    return {
        sms:"",
        mobile:"",
        password:"",
        password2:"",
        get_sms_text:"点击发送短信",
        is_send:false, // 短信发送冷却状态
    }
  },
  created(){
  },
  methods:{
      send_sms(){
          // 发送短信处理
          let ret = /^1[3-9]\d{9}$/.test(this.mobile);
          if(!ret){
              this.$message.error("对不起,手机格式有误!");
              return;
          }

          if(this.is_send){
              return;
          }
          // 设置短信发送状态
          this.is_send = true;
          // ajax请求发送短信
          this.$axios.get(`/users/sms/${this.mobile}/`).then(response=>{
              this.$message.success(response.data.message);
              let t = 60;
              let timer = setInterval(()=>{
                  if(t>0){
                      t--;
                      this.get_sms_text = `${t}秒后点击发送`;
                  }else{
                      this.get_sms_text = "点击发送短信";
                      this.is_send = false;
                      clearInterval(timer);
                  }
              },1000);
          }).catch(error=>{
              this.is_send = false;
              this.$message.error(error.response.data.message);
          })
      },
      registerHandler(){
          // 注册处理
          let ret = /^1[3-9]\d{9}$/.test(this.mobile);
          if(!ret){
              this.$message.error("对不起,手机格式有误!");
              return;
          }

          this.$axios.post(`/users/`,{
              mobile: this.mobile,
              password: this.password,
              password2: this.password2,
              sms_code: this.sms
          }).then(response=>{
            // 不记住密码
            sessionStorage.token = response.data.token;
            sessionStorage.user_id = response.data.id;
            sessionStorage.user_avatar = response.data.avatar===null?"":response.data.avatar;
            sessionStorage.user_name = response.data.name;
            sessionStorage.user_credit = response.data.user_credit;
            sessionStorage.credit_rmb = response.data.credit_rmb;
            localStorage.removeItem("token");
            localStorage.removeItem("user_id");
            localStorage.removeItem("user_avatar");
            localStorage.removeItem("user_name");
            // 跳转页面
            this.$confirm('注册成功!是否跳转到个人中心?', '网站提示', {
              confirmButtonText: '确定',
              cancelButtonText: '跳转到站点首页',
              type: 'success'
            }).then(() => {
              // 跳转到首页
                this.$router.push("/user");
            }).catch(() => {
              // 跳转到首页
                this.$router.push("/");
            });
          }).catch(error=>{
              this.$message.error("注册失败! " + error.response.data);
          })

      }
  },

};
</script>

<style scoped>
.box{
	width: 100%;
  height: 100%;
	position: relative;
  overflow: hidden;
}
.box img{
	width: 100%;
  min-height: 100%;
}
.box .register {
	position: absolute;
	width: 500px;
	height: 400px;
	top: 0;
	left: 0;
  margin: auto;
  right: 0;
  bottom: 0;
  top: -338px;
}
.register .register-title{
    width: 100%;
    font-size: 24px;
    text-align: center;
    padding-top: 30px;
    padding-bottom: 30px;
    color: #4a4a4a;
    letter-spacing: .39px;
}
.register-title img{
    width: 190px;
    height: auto;
}
.register-title p{
    font-family: PingFangSC-Regular;
    font-size: 18px;
    color: #fff;
    letter-spacing: .29px;
    padding-top: 10px;
    padding-bottom: 50px;
}
.register_box{
    width: 400px;
    height: auto;
    background: #fff;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,.5);
    border-radius: 4px;
    margin: 0 auto;
    padding-bottom: 40px;
}
.register_box .title{
	font-size: 20px;
	color: #9b9b9b;
	letter-spacing: .32px;
	border-bottom: 1px solid #e6e6e6;
	 display: flex;
    	justify-content: space-around;
    	padding: 50px 60px 0 60px;
    	margin-bottom: 20px;
    	cursor: pointer;
}
.register_box .title span:nth-of-type(1){
	color: #4a4a4a;
    	border-bottom: 2px solid #84cc39;
}

.inp{
	width: 350px;
	margin: 0 auto;
}
.inp input{
    border: 0;
    outline: 0;
    width: 100%;
    height: 45px;
    border-radius: 4px;
    border: 1px solid #d9d9d9;
    text-indent: 20px;
    font-size: 14px;
    background: #fff !important;
}
.inp input.user{
    margin-bottom: 16px;
}
.inp .rember{
     display: flex;
    justify-content: space-between;
    align-items: center;
    position: relative;
    margin-top: 10px;
}
.inp .rember p:first-of-type{
    font-size: 12px;
    color: #4a4a4a;
    letter-spacing: .19px;
    margin-left: 22px;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-align: center;
    align-items: center;
    /*position: relative;*/
}
.inp .rember p:nth-of-type(2){
    font-size: 14px;
    color: #9b9b9b;
    letter-spacing: .19px;
    cursor: pointer;
}

.inp .rember input{
    outline: 0;
    width: 30px;
    height: 45px;
    border-radius: 4px;
    border: 1px solid #d9d9d9;
    text-indent: 20px;
    font-size: 14px;
    background: #fff !important;
}

.inp .rember p span{
    display: inline-block;
  font-size: 12px;
  width: 100px;
  /*position: absolute;*/
/*left: 20px;*/

}
#geetest{
	margin-top: 20px;
}
.register_btn{
     width: 100%;
    height: 45px;
    background: #84cc39;
    border-radius: 5px;
    font-size: 16px;
    color: #fff;
    letter-spacing: .26px;
    margin-top: 30px;
}
.inp .go_login{
    text-align: center;
    font-size: 14px;
    color: #9b9b9b;
    letter-spacing: .26px;
    padding-top: 20px;
}
.inp .go_login span{
    color: #84cc39;
    cursor: pointer;
}
.sms{
  margin-top: 15px;
  position: relative;
}
.sms .get_sms{
  position: absolute;
  right: 15px;
  top: 14px;
  font-size: 14px;
  color: #ffc210;
  cursor: pointer;
  border-left: 1px solid #979797;
  padding-left: 20px;
}

</style>

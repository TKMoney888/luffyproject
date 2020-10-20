<template>
	<div class="login box">
		<img src="/static/image/Loginbg.3377d0c.jpg" alt="">
		<div class="login">
			<div class="login-title">
				<img src="/static/image/Logotitle.1ba5466.png" alt="">
				<p>帮助有志向的年轻人通过努力学习获得体面的工作和生活!</p>
			</div>
			<div class="login_box">
				<div class="title">
					<span @click="login_type=0">密码登录</span>
					<span @click="login_type=1">短信登录</span>
				</div>
				<div class="inp" v-if="login_type==0">
					<input v-model="username" type="text" placeholder="用户名 / 手机号码" class="user">
					<input v-model="password" type="password" name="" class="pwd" placeholder="密码">
					<div id="geetest1"></div>
					<div class="rember">
						<p>
							<input type="checkbox" class="no" v-model="remember"/>
							<span>记住密码</span>
						</p>
						<p>忘记密码</p>
					</div>
					<button class="login_btn" @click="captcha">登录</button>
					<p class="go_login" >没有账号 <router-link to="/register">立即注册</router-link></p>
				</div>
				<div class="inp" v-show="login_type==1">
					<input v-model = "username" type="text" placeholder="手机号码" class="user">
					<input v-model = "password"  type="text" class="pwd" placeholder="短信验证码">
          <button id="get_code">获取验证码</button>
					<button class="login_btn">登录</button>
					<p class="go_login" >没有账号 <span>立即注册</span></p>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
export default {
  name: 'Login',
  data(){
    return {
        login_type: 0,
        username:"",
        password:"",
        remember: false, // 是否记住密码
    }
  },

  methods:{
    captcha(){
      var captcha1 = new TencentCaptcha(this.$settings.TC_captcha.app_id, res=>{
          // 当前这里的箭头函数是监听用户对验证码操作的回调函数.
          // res.ret  用户操作的结果
          //        = 0  用户验证通过
          //        = 2  用户取消验证
          // res.ticket    验证成功的票据，当且仅当ret=0时ticket有值
          // res.randstr  随机数,主要是腾讯验证码服务器提供的,后面我们原样提供给腾讯
          if(res.ret == 0){
              this.loginHandle(res.ticket,res.randstr);
          }
      });

      captcha1.show(); // 显示验证码
    },
    loginHandle(ticket,randstr){
        // 登录处理
        // 参数验证处理
        if(this.username.length<1 || this.password.length<1){
            this.$message.error("对不起,用户名或密码不能为空!");
            return;// 阻止代码继续往下执行
        }
        // ajax请求
        this.$axios.post(`/users/login/`,{
            username: this.username,
            password: this.password,
            ticket: ticket,
            randstr: randstr,
        }).then(response=>{
            if(this.remember){
                // 记住密码
                localStorage.token = response.data.token;
                sessionStorage.removeItem("token");
            }else{
                // 不记住密码
                sessionStorage.token = response.data.token;
                localStorage.removeItem("token");
            }
            localStorage.user_id = response.data.user_id;
            localStorage.user_avatar = response.data.avatar;
            localStorage.user_name = response.data.nickname;

						// 记录用户积分
            sessionStorage.credit = response.data.user_credit;
            sessionStorage.credit_rmb = response.data.credit_rmb;

            // 跳转页面
            this.$confirm('登录成功!是否跳转到首页?', '网站提示', {
              confirmButtonText: '确定',
              cancelButtonText: '跳转到个人中心',
              type: 'success'
            }).then(() => {
              // 跳转到首页
                this.$router.push("/");
            }).catch(() => {
              // 跳转到个人中心
                this.$router.push("/user")
            });
        }).catch(error=>{
            console.log(error);
        });
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
.box .login {
	position: absolute;
	width: 500px;
	height: 400px;
	left: 0;
  margin: auto;
  right: 0;
  bottom: 0;
  top: -338px;
}
.login .login-title{
     width: 100%;
    text-align: center;
}
.login-title img{
    width: 190px;
    height: auto;
}
.login-title p{
    font-size: 18px;
    color: #fff;
    letter-spacing: .29px;
    padding-top: 10px;
    padding-bottom: 50px;
}
.login_box{
    width: 400px;
    height: auto;
    background: #fff;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,.5);
    border-radius: 4px;
    margin: 0 auto;
    padding-bottom: 40px;
}
.login_box .title{
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
.login_box .title span:nth-of-type(1){
	color: #4a4a4a;
    	border-bottom: 2px solid #84cc39;
}

.inp{
	width: 350px;
	margin: 0 auto;
}
.inp input{
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
.login_btn{
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
</style>

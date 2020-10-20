export default {
  Host: "http://api.lxh1.com",
  TC_captcha:{
    app_id: "2059674751",
  },
  checkUserLogin(vm){
    // 判断用户是否登录
    vm.token = sessionStorage.token || localStorage.token;
    if(vm.token){
      // 验证token的有效性[有效性或者是否被篡改了]
      vm.$axios.post(`/users/verify/`,{
        token: vm.token,
      }).catch(error=>{
        if(error.response.status == 400){
          vm.token="";
          sessionStorage.removeItem("token");
          localStorage.removeItem("token");
        }
      });
    }else{
      vm.token = "";
    }
    return vm.token;
  }
}

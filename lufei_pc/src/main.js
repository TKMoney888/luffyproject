// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'

Vue.config.productionTip = false

// 加载配置
import settings from "./settings";
Vue.prototype.$settings = settings;

// 样式重置
import "../static/css/reset.css";
import 'element-ui/lib/theme-chalk/index.css';
// elementUI 导入
import ElementUI from 'element-ui';
// 调用插件
Vue.use(ElementUI);

// axios 初始化
import axios from "axios";
axios.defaults.withCredentials=false;
axios.defaults.baseURL = settings.Host;
Vue.prototype.$axios = axios;

// 腾讯防水墙验证码
import "../static/js/TCaptcha.js";

// 初始化vue-video插件
import "video.js/dist/video-js.css"
import "vue-video-player/src/custom-theme.css"
import VideoPlayer from 'vue-video-player'
Vue.use(VideoPlayer);

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})

import Vue from 'vue'
import Router from 'vue-router'

import Home from "../components/Home"
import Login from "../components/Login"
import  Register from "../components/Register"
import  Course from "../components/Course"
import  Detail from "../components/Detail"
import  Cart from "../components/Cart"
import  Order from "../components/Order"
import  Success from "../components/Success"
import User from "../components/User"
import UserOrder from "../components/UserOrder"
import Player from "../components/Player"
Vue.use(Router);

let router = new Router({
  mode:"history",
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home,
    },{
      path: '/home',
      name: 'Home',
      component: Home,
    },
    {
      name:"Login",
      path: "/login",
      component:Login,
    },
    {
      name:"Register",
      path: "/register",
      component:Register,
    },
    {
      name:"Course",
      path: "/course",
      component: Course,
      // 使用嵌套路由[父子路由]的前提是,页面部分内容重叠,路径重叠.
      // children:[
      //   {
      //     path:":id",
      //     component: Detail
      //   },
      // ]
    },
    {
      name:"Detail",
      path: "/course/:id",
      component: Detail,
    },
    {
      name:"Cart",
      path: "/cart",
      component: Cart,
    },
    {
      path: '/order',
      name: 'Order',
      component: Order,
    },
    {
        path: '/payments/alipay/result',
        name: "Success",
        component: Success,
    },
    {
      name:"User",
      path:"/user",
      component: User,
      children:[  // 设置子路由,在父级路由对应的组件中如果存在父子公用部分页面,可以使用router-view来实现子路由
        {
          name:"UserOrder",
          path:"order", // 访问路径　/user/order
          component: UserOrder,
        }
      ]
    },
    {
      path: '/player',
      name: "Player",
      component: Player,
    },
  ]
})

// 导航卫士,进行访问拦截,一般用于权限,错误响应处理
// router.beforeEach(()=>{
//
// });

export default router;

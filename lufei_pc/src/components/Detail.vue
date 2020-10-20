<template>
    <div class="detail">
      <Header/>
      <div class="main">
        <div class="course-info">
          <div class="wrap-left">
              <videoPlayer class="video-player vjs-custom-skin"
              ref="videoPlayer"
              :playsinline="true"
              :options="playerOptions"
              @play="onPlayerPlay($event)"
              @pause="onPlayerPause($event)"
              />
          </div>
          <div class="wrap-right">
            <h3 class="course-name">{{course.name}}</h3>
            <p class="data">{{course.students}}人在学&nbsp;&nbsp;&nbsp;&nbsp;课程总时长：{{course.pub_lessons}}课时/{{course.lessons}}课时&nbsp;&nbsp;&nbsp;&nbsp;难度：{{course.level_name}}</p>
            <div v-if="course.activity_end_time>0">
              <div class="sale-time">
                <p class="sale-type">{{course.discount_name}}</p>
                <p class="expire">距离结束：仅剩 {{has_day}}天 {{has_hours}}小时 {{has_minutes}}分 <span class="second">{{has_seconds}}</span> 秒</p>
              </div>
              <p class="course-price">
                <span>活动价</span>
                <span class="discount">¥ {{course.discount_price}}</span>
                <span class="original">¥ {{course.min_price && course.min_price.toFixed(2)}}</span>
              </p>
            </div>
            <div v-else>
              <p class="course-price"><span class="discount">¥ {{course.min_price && course.min_price.toFixed(2)}}</span></p>
            </div>
            <div class="buy">
              <div class="buy-btn">
                <button class="buy-now">立即购买</button>
                <button class="free">免费试学</button>
              </div>
              <div class="add-cart" @click="cartHandler"><img src="/static/image/cart-yellow.svg" alt="">加入购物车</div>
            </div>
          </div>
        </div>
        <div class="course-tab">
          <ul class="tab-list">
            <li :class="tabIndex==1?'active':''" @click="tabIndex=1">详情介绍</li>
            <li :class="tabIndex==2?'active':''" @click="tabIndex=2">课程章节 <span :class="tabIndex!=2?'free':''">(试学)</span></li>
            <li :class="tabIndex==3?'active':''" @click="tabIndex=3">用户评论 (42)</li>
            <li :class="tabIndex==4?'active':''" @click="tabIndex=4">常见问题</li>
          </ul>
        </div>
        <div class="course-content">
          <div class="course-tab-list">
            <div class="tab-item" v-if="tabIndex==1">
              <div class="content" v-html="add_image_url(course.brief)">

              </div>
            </div>
            <div class="tab-item" v-if="tabIndex==2">
              <div class="tab-item-title">
                <p class="chapter">课程章节</p>
                <p class="chapter-length">共{{chapters.length}}章 147个课时</p>
              </div>
              <div class="chapter-item" v-for="chapter in chapters">
                <p class="chapter-title"><img src="/static/image/1.svg" alt="">第{{chapter.number}}章·{{chapter.name}}</p>
                <ul class="lesson-list">
                  <li class="lesson-item" v-for="lesson in chapter.lesson_list">
                    <p class="name"><span class="index">{{chapter.number}}-{{lesson.number}}</span> {{lesson.name}}<span class="free" v-if="lesson.free_trail">免费</span></p>
                    <p class="time">{{lesson.duration}} <img src="/static/image/chapter-player.svg"></p>
                    <button class="try" v-if="lesson.free_trail">立即试学</button>
                    <button class="try" v-else>立即购买</button>
                  </li>
                </ul>
              </div>
            </div>
            <div class="tab-item" v-if="tabIndex===3">
              用户评论
            </div>
            <div class="tab-item" v-if="tabIndex===4">
              常见问题
            </div>
          </div>
          <div class="course-side">
             <div class="teacher-info">
               <h4 class="side-title"><span>授课老师</span></h4>
               <div class="teacher-content">
                 <div class="cont1">
                   <img :src="course.teacher.image">
                   <div class="name">
                     <p class="teacher-name">{{course.teacher.name}}</p>
                     <p class="teacher-title">{{course.teacher.signature}} {{course.teacher.title}}</p>
                   </div>
                 </div>
                 <p class="narrative" >{{course.teacher.brief}}</p>
               </div>
             </div>
          </div>
        </div>
      </div>
      <Footer/>
    </div>
</template>

<script>
import Header from "./common/Header"
import Footer from "./common/Footer"
// 1.加载播放器组件
import {videoPlayer} from 'vue-video-player';

export default {
    name: "Detail",
    data(){
      return {
        token: "",
        course:{ // 课程信息
            teacher:{},
        },
        chapters:{ // 当前课程的所有章节课时列表

        },
        tabIndex:2, // 当前选项卡显示的下标,
        // 4. 配置播放器参数
        playerOptions:{
          playbackRates: [0.5, 1.0, 1.5, 2.0], // 播放速度
          autoplay: false, //如果true,则自动播放
          muted: false, // 默认情况下将会消除任何音频。
          loop: false, // 循环播放
          preload: 'auto',  // 建议浏览器在<video>加载元素后是否应该开始下载视频数据。auto浏览器选择最佳行为,立即开始加载视频（如果浏览器支持）
          language: 'zh-CN',
          aspectRatio: '16:9', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
          fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
          sources: [{ // 播放资源和资源格式
            type: "video/mp4",
            src: "http://192.168.136.1:5000/home/lib/1.mp4" //你的视频地址（必填）
          }],
          poster: "../static/image/course-cover.jpeg", //视频封面图
          width: document.documentElement.clientWidth, // 默认视频全屏时的最大宽度
          notSupportedMessage: '此视频暂无法播放，请稍后再试', //允许覆盖Video.js无法播放媒体源时显示的默认信息。
        }
      }
    },
    computed:{
      has_day(){
          let day = parseInt(this.course.activity_end_time / 60 / 60 / 24);
          day = day<10?('0'+day):day;
          return day;
      },
      has_hours(){
          let hours = parseInt(this.course.activity_end_time / 60 / 60 % 24);
          hours = hours<10?('0'+hours):hours;
          return hours;
      },
      has_minutes(){
          let minutes = parseInt(this.course.activity_end_time / 60 % 60);
          minutes = minutes<10?('0'+minutes):minutes;
          return minutes;
      },
      has_seconds(){
          let seconds = parseInt(this.course.activity_end_time % 60);
          seconds = seconds<10?('0'+seconds):seconds;
          return seconds;
      }
    },
    created(){
      // console.log("路由参数", this.$route.params); // 获取路由参数
      // console.log("查询参数", this.$route.query);  // 获取查询字符串 ?号后面的就是查询字符串
      this.course.id = this.$route.params.id;
      this.get_course();
      this.get_chapters();
    },
    methods: {
      onPlayerPlay(event){
          console.log("开始播放视频，关闭广告");
      },
      onPlayerPause(event){
          console.log("暂停播放广告");
      },
      get_course(){
          // 获取课程信息
          this.$axios.get(`/courses/${this.course.id}`).then(response=>{
              this.course = response.data;
              this.playerOptions.poster = response.data.course_img;
              this.playerOptions.sources[0].src = response.data.course_video;
              setInterval(()=>{
                this.course.activity_end_time=this.course.activity_end_time-1;
              },1000);
          }).catch(error=>{
              console.log(error.response.data);
          });
      },
      add_image_url(content){
          while(content.search(`src="/media`) !==-1){
              content = content.replace(/src="\/media/,`src="${this.$settings.Host}/media`)
          }
          return content
      },
      get_chapters(){
          // 获取章节课时列表
          this.$axios.get(`/courses/chapters/`,{
              params:{
                  course:this.course.id,
              }
          }).then(response=>{
              this.chapters = response.data;
          }).catch(error=>{
              console.log(error.response.data);
          })
      },
      cartHandler(){
          // 添加商品到购物车
          this.$settings.checkUserLogin(this);
          if(this.token){
              this.$axios.post(`/cart/course/`,{
                course_id: this.course.id,
              },{
                  headers:{
                      Authorization: "jwt " + this.token,
                  }
              }).then(response=>{
                  this.$confirm('添加商品课程成功!是否跳转到购物车?', '网站提示', {
                    confirmButtonText: '立即跳转',
                    cancelButtonText: '继续购物',
                    type: 'success'
                  }).then(() => {
                    // 跳转到购物车
                      this.$router.push("/cart");
                  }).catch(() => {
                    // 跳转到商品课程列表
                      this.$router.push("/course")
                  });
                  this.$message.success(response.data.message);
              }).catch(error=>{
                  console.log(error.response.data);
              })
          }else{
              this.$message.error("对不起, 当前用户未登录");
              this.$router.push("/login");
          }
      }
    },
    components:{
      Header,
      Footer,
      videoPlayer, // 2. 注册播放器组件到当前页面中
    }
}
</script>

<style scoped>
.main{
  background: #fff;
  padding-top: 30px;
}
.course-info{
  width: 1200px;
  margin: 0 auto;
  overflow: hidden;
}
.wrap-left{
  float: left;
  width: 690px;
  height: 388px;
  background-color: #000;
}
.wrap-right{
  float: left;
  position: relative;
  height: 388px;
}
.course-name{
  font-size: 20px;
  color: #333;
  padding: 10px 23px;
  letter-spacing: .45px;
}
.data{
  padding-left: 23px;
  padding-right: 23px;
  padding-bottom: 16px;
  font-size: 14px;
  color: #9b9b9b;
}
.sale-time{
  width: 464px;
  background: #fa6240;
  font-size: 14px;
  color: #4a4a4a;
  padding: 10px 23px;
  overflow: hidden;
}
.sale-type {
  font-size: 16px;
  color: #fff;
  letter-spacing: .36px;
  float: left;
}
.sale-time .expire{
  font-size: 14px;
  color: #fff;
  float: right;
}
.sale-time .expire .second{
  width: 24px;
  display: inline-block;
  background: #fafafa;
  color: #5e5e5e;
  padding: 6px 0;
  text-align: center;
}
.course-price{
  background: #fff;
  font-size: 14px;
  color: #4a4a4a;
  padding: 5px 23px;
}
.discount{
  font-size: 26px;
  color: #fa6240;
  margin-left: 10px;
  display: inline-block;
  margin-bottom: -5px;
}
.original{
  font-size: 14px;
  color: #9b9b9b;
  margin-left: 10px;
  text-decoration: line-through;
}
.buy{
  width: 464px;
  padding: 0px 23px;
  position: absolute;
  left: 0;
  bottom: 20px;
  overflow: hidden;
}
.buy .buy-btn{
  float: left;
}
.buy .buy-now{
  width: 125px;
  height: 40px;
  border: 0;
  background: #ffc210;
  border-radius: 4px;
  color: #fff;
  cursor: pointer;
  margin-right: 15px;
  outline: none;
}
.buy .free{
  width: 125px;
  height: 40px;
  border-radius: 4px;
  cursor: pointer;
  margin-right: 15px;
  background: #fff;
  color: #ffc210;
  border: 1px solid #ffc210;
}
.add-cart{
  float: right;
  font-size: 14px;
  color: #ffc210;
  text-align: center;
  cursor: pointer;
  margin-top: 10px;
}
.add-cart img{
  width: 20px;
  height: 18px;
  margin-right: 7px;
  vertical-align: middle;
}

.course-tab{
    width: 100%;
    background: #fff;
    margin-bottom: 30px;
    box-shadow: 0 2px 4px 0 #f0f0f0;

}
.course-tab .tab-list{
    width: 1200px;
    margin: auto;
    color: #4a4a4a;
    overflow: hidden;
}
.tab-list li{
    float: left;
    margin-right: 15px;
    padding: 26px 20px 16px;
    font-size: 17px;
    cursor: pointer;
}
.tab-list .active{
    color: #ffc210;
    border-bottom: 2px solid #ffc210;
}
.tab-list .free{
    color: #fb7c55;
}
.course-content{
    width: 1200px;
    margin: 0 auto;
    background: #FAFAFA;
    overflow: hidden;
    padding-bottom: 40px;
}
.course-tab-list{
    width: 880px;
    height: auto;
    padding: 20px;
    background: #fff;
    float: left;
    box-sizing: border-box;
    overflow: hidden;
    position: relative;
    box-shadow: 0 2px 4px 0 #f0f0f0;
}
.tab-item{
    width: 880px;
    background: #fff;
    padding-bottom: 20px;
    box-shadow: 0 2px 4px 0 #f0f0f0;
}
.tab-item-title{
    justify-content: space-between;
    padding: 25px 20px 11px;
    border-radius: 4px;
    margin-bottom: 20px;
    border-bottom: 1px solid #333;
    border-bottom-color: rgba(51,51,51,.05);
    overflow: hidden;
}
.chapter{
    font-size: 17px;
    color: #4a4a4a;
    float: left;
}
.chapter-length{
    float: right;
    font-size: 14px;
    color: #9b9b9b;
    letter-spacing: .19px;
}
.chapter-title{
    font-size: 16px;
    color: #4a4a4a;
    letter-spacing: .26px;
    padding: 12px;
    background: #eee;
    border-radius: 2px;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-align: center;
    align-items: center;
}
.chapter-title img{
    width: 18px;
    height: 18px;
    margin-right: 7px;
    vertical-align: middle;
}
.lesson-list{
    padding:0 20px;
}
.lesson-list .lesson-item{
    padding: 15px 20px 15px 36px;
    cursor: pointer;
    justify-content: space-between;
    position: relative;
    overflow: hidden;
}
.lesson-item .name{
    font-size: 14px;
    color: #666;
    float: left;
}
.lesson-item .index{
    margin-right: 5px;
}
.lesson-item .free{
    font-size: 12px;
    color: #fff;
    letter-spacing: .19px;
    background: #ffc210;
    border-radius: 100px;
    padding: 1px 9px;
    margin-left: 10px;
}
.lesson-item .time{
    font-size: 14px;
    color: #666;
    letter-spacing: .23px;
    opacity: 1;
    transition: all .15s ease-in-out;
    float: right;
}
.lesson-item .time img{
    width: 18px;
    height: 18px;
    margin-left: 15px;
    vertical-align: text-bottom;
}
.lesson-item .try{
    width: 86px;
    height: 28px;
    background: #ffc210;
    border-radius: 4px;
    font-size: 14px;
    color: #fff;
    position: absolute;
    right: 20px;
    top: 10px;
    opacity: 0;
    transition: all .2s ease-in-out;
    cursor: pointer;
    outline: none;
    border: none;
}
.lesson-item:hover{
    background: #fcf7ef;
    box-shadow: 0 0 0 0 #f3f3f3;
}
.lesson-item:hover .name{
    color: #333;
}
.lesson-item:hover .try{
    opacity: 1;
}

.course-side{
    width: 300px;
    height: auto;
    margin-left: 20px;
    float: right;
}
.teacher-info{
    background: #fff;
    margin-bottom: 20px;
    box-shadow: 0 2px 4px 0 #f0f0f0;
}
.side-title{
    font-weight: normal;
    font-size: 17px;
    color: #4a4a4a;
    padding: 18px 14px;
    border-bottom: 1px solid #333;
    border-bottom-color: rgba(51,51,51,.05);
}
.side-title span{
    display: inline-block;
    border-left: 2px solid #ffc210;
    padding-left: 12px;
}

.teacher-content{
    padding: 30px 20px;
    box-sizing: border-box;
}

.teacher-content .cont1{
    margin-bottom: 12px;
    overflow: hidden;
}

.teacher-content .cont1 img{
    width: 54px;
    height: 54px;
    margin-right: 12px;
    float: left;
}
.teacher-content .cont1 .name{
    float: right;
}
.teacher-content .cont1 .teacher-name{
    width: 188px;
    font-size: 16px;
    color: #4a4a4a;
    padding-bottom: 4px;
}
.teacher-content .cont1 .teacher-title{
    width: 188px;
    font-size: 13px;
    color: #9b9b9b;
    white-space: nowrap;
}
.teacher-content .narrative{
    font-size: 14px;
    color: #666;
    line-height: 24px;
}

</style>

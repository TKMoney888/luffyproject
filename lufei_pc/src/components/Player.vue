<template>
    <div class="player">
      <div id="player"></div>
      <div id="chapter_list">
        <el-tree :data="course_info.children" @node-click="handleNodeClick"></el-tree>
      </div>
    </div>
</template>

<script>
export default {
  name:"Player",
  data () {
    return {
      token:"",
      course_info:{},
      vid: 0,
    }
  },
  created(){
      // 检查用户是否登录了
      this.token = this.$settings.checkUserLogin(this);
      if(this.token){
          let user_name = localStorage.user_name || sessionStorage.user_name;
          let course_id = localStorage.course_id;
          // 获取课程的章节课时列表
          this.get_course_info(course_id);
      }
  },
  watch: {
    vid(){
        // 当用户点击播放课时的时候,vid就会发生变化,此时播放加密视频吧
        this.player_video(this.vid);
    }
  },
  methods:{
      get_course_info(course_id){
          // 获取章节课时信息
          this.$axios.get(`/courses/chapters2/`,{
              params:{"course":course_id},
              headers:{
                  "Authorization": "jwt " + this.token,
              }
          }).then(response=>{
              console.log(response.data);
              this.course_info = response.data;
          })
      },
      handleNodeClick(data){
          // 当用户点击课时播放
          if(data.lesson_type && data.lesson_type == 2){
            this.vid = data.lesson_link
          }
      },
      player_video(vid){
        // 播放加密视频
        let self = this;
        var player = polyvPlayer({
        wrap: '#player',
        width: document.documentElement.clientWidth * 0.8, // 页面宽度
        height: document.documentElement.clientHeight, // 默认页面高度为当前浏览器页面高度
        forceH5: true,
        vid: vid,
        code: localStorage.user_name, // 一般是用户昵称
        // 视频加密播放的配置
        playsafe: function (vid, next) { // 向后端发送请求获取加密的token
            self.$axios.get(`/courses/play/`,{
              params:{
                vid: vid,
              },
              headers:{
                "Authorization":"jwt " + self.token,
              }
            }).then(function (response) {
                // 获取播放视频的token令牌
                next(response.data);
            })
        }
      });
      }
  }
}
</script>

<style scoped>
  #player{
    width: 80%;
    float: left;
  }
  #chapter_list{
    width: 20%;
    float: right;
  }
</style>

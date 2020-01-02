<template>
  <div id="user">
    <img alt="Vue logo" src="../assets/logo.png">
    <p>我裂开了</p>
    <input type="button" value="测试" @click="test">
  </div>
</template>

<script>

export default {
  	name: 'user',
  	data: function(){
		return{
			study_status:0,
			student_id:0,
			student_name:'',
		}
	},
	beforeCreate(){
		//未登录，跳转到登录界面
		window.console.log("创建前")
		window.console.log(this.$store.state.student_id)
		if(this.$store.state.student_id==""){
			window.location = "login.html"
		}
	},
	created(){
		this.student_id = parseInt(this.$store.state.student_id)
		this.student_name = this.$store.state.student_name
		window.console.log(this.student_id)
		window.console.log(this.student_name)
	},
	methods: {
		getstatus:function(){
			let that = this
			let param = new URLSearchParams()
			param.append('student_id',this.student_id)
			this.$axios({
				method:'post',
				url:'http://localhost:8000/app/getstudentstatus',
				data:param,
			}).then(function(response){
				window.console.log(response)
				that.study_status = response.data.study_status
			})
		},
		test:function(){
			this.$store.dispatch("Logout")
			window.location = "login.html"
		}
	},
  // components: {
  //   HelloWorld
  // }
}
</script>

<style>
#user {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

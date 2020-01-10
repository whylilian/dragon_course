<template>
    <div id="teacherlogin">
        <div id="base">
            <img id = "u24" src = "../assets/u24.png">
				<p id = "word">单词赢</p>
				<p id = "text">教师端登录窗口</p>
				<div id = "box1">
					<p>账号密码登陆</p>
				</div>
				<div class = "box2" id = "account-box">
					<div class = "box3">
						<img class = "u671" src = "../assets/u671.png">
					</div>
					<input type = "text" class = "input" id = "account" placeholder = "账号" v-model="username">
				</div>
				<div class = "box2" id = "password-box">
					<div class = "box3">
						<img class = "u671" src = "../assets/u671.png">
					</div>
					<input type = "password" class = "input" id = "password" placeholder = "密码" v-model="password">
				</div>
				<a herf = "#" id = "forget-password" >忘记密码</a>
				<input type = "button" id = "login" value = "登录" @click="send">
        </div>
    </div>
</template>

<script>
export default {
    name:'teacherlogin',
    data: function(){
		return{
			username: '',
            password: '',
		}
    },
	methods: {
		send: function(){
			let that = this
			let param = new URLSearchParams()
			param.append('teacher_username',this.username)
			param.append('teacher_password',this.password)
			this.$axios({
				method:'post',
				url:'http://localhost:8000/app/teacherlogin',
				data:param,
			}).then(function(response){
                window.console.log(response)
                window.console.log(typeof(response.data.teacher_id))
				if(response.data.login_status=='succeed'){
                    let teacher_id = response.data.teacher_id
                    let teacher_name = response.data.teacher_name
                    that.$store.dispatch("TeacherLogin",{teacher_id,teacher_name})
                    window.location = 'teacher.html'
				}else if(response.data.login_status=='failed'){
                    window.alert("密码错误，请重新输入")
                    window.location = "teacherlogin.html"
                }else if(response.data.login_status=='not_exist'){
                    window.alert("用户名不存在，请重新输入")
                    window.location = "teacherlogin.html"
                }
			})
		}
    },
}
</script>

<style scoped>
#teacherlogin {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    background-size:100% 100%;
    margin: none;
    height: 100%;
    width: 100%;
}
#base {
    width: 500px;
    height: 500px;
    margin: auto;
    padding-top: 100px;
    padding-bottom: 100px;

}

#u24 {
    width: 65px;
    height: 50px;
    margin-left: 150px;
    margin-top: 30px;
	margin: auto;
}

#word {
    font-size: 30px;
    display: inline;
    font-weight: bold;
}

#text {
    color: hsla(0, 0%, 0%, 0.427450980392157);
	margin: 0px;
}

#box1 {
    width: 140px;
    height: 50px;
    text-align: center;
    padding-top: 10px;
    margin-left: 100px;
    margin-top: 30px;
    font-size: 18px;
    color: #1890FF;
    border-bottom: solid #1890FF;
}

.box2 {
    display: flex;
    width: 350px;
    height: 40px;
    margin-left: 70px;
    margin-top: 30px;
    font-size: 16px;
    color: hsla(0, 0%, 0%, 0.247058823529412);
    box-sizing: border-box;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    background-color: rgba(255, 255, 255, 1);
}

.box3 {
    width: 16px;
    height: 16px;
    margin: 0;
    margin-top: 10px;
    margin-left: 14px;
}

.input {
    width: 310px;
    height: 38px;
    font-size: 16px;
    color: rgba(0, 0, 0, 0.447058823529412);
    box-sizing: border-box;
    background: inherit;
    background-color: rgba(255, 255, 255, 1);
    border-radius: 4px;
    border-width: 0px;
    word-wrap: break-word;
    text-transform: none;
    padding-right: 0;
    margin-left: 10px;
}

#box4 {
    width: 20px;
    height: 20px;
    box-sizing: border-box;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    background-color: rgba(255, 255, 255, 1);
}

#select {
    margin-left: 0px;
    margin-top: 30px;
}

#forget-password {
    display: inline;
    margin-left: 190px;
    font-size: 16px;
    color: #1890FF;
}

#login {
    display: block;
    width: 350px;
    height: 40px;
    margin-left: 70px;
    margin-top: 30px;
    font-size: 16px;
    color: white;
    box-sizing: border-box;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    background-color: #1890FF;
}

.u671 {
    width: 16px;
    height: 16px;
}
</style>
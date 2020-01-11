<template>
	<div id="app">
		<div id = "base1">
			<div id = "base2">
				<img id = "u24" src = "../assets/u24.png">
				<p id = "word">单词赢</p>
				<p id = "text">三天背完小升初   七天背完中高考</p>
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
				<input type = "button" id = "login" value = "登陆" @click="send">
			</div>
		</div>
	</div>
</template>

<script>

export default {
	name: 'app',
	data: function(){
		return{
			username: '',
            password: '',
		}
    },
    created(){
        window.console.log("创建")
        window.console.log(this.$store.state.coin_rank)
    },
	methods: {
		send: function(){
			let that = this
			let param = new URLSearchParams()
			param.append('student_username',this.username)
            param.append('student_password',this.password)
			this.$axios({
				method:'post',
				url:'http://localhost:8000/app/',
				data:param,
			}).then(function(response){
                window.console.log(response)
				if(response.data.login_status=='succeed'){
                    let student_id = response.data.student_id
                    let student_name = response.data.student_name
                    let coins = response.data.coins.toString()
                    let daka_num = response.data.daka_num.toString()
                    let enable_daka = response.data.enable_daka.toString()
                    that.$store.dispatch("Login",{student_id,student_name,coins,daka_num,enable_daka})
                    window.location = 'main.html'
				}else if(response.data.login_status=='failed'){
                    window.alert("密码错误，请重新输入")
                    window.location = "login.html"
                }else if(response.data.login_status=='not_exist'){
                    window.alert("用户名不存在，请重新输入")
                    window.location = "login.html"
                }
			})
		}
    },
  // components: {
  //   HelloWorld
  // }
}
</script>

<style>
body {
    background:url(../assets/background.png)  no-repeat center center;
    background-attachment:fixed;
    background-size:cover;
    margin: 0;
    background-color:#CCCCCC;
}
#app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;
    background-size:100% 100%;
    margin: none;
    height: 100%;
    width: 100%;
}
#base1 {
    width: 100%;
    height: 100%;
    margin: 0;
}

#base2 {
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
}

#word {
    font-size: 30px;
    display: inline;
    font-weight: bold;
}

#text {
    margin-left: 130px;
    color: hsla(0, 0%, 0%, 0.427450980392157);
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
    color: rgba(0, 0, 0, 1);
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

#forget-password {
    display: inline;
    margin-left: 350px;
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
    border: none;
    box-sizing: border-box;
    background: inherit;
    background-color: #1890FF;
}

.u671 {
    width: 16px;
    height: 16px;
}
</style>

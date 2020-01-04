<template>
	<div id="setting">
		<!--导航条及logo-->
        <div id="navigation" class="navigationStyle">
            <div id="logo" class="logoStyle">
               <img src="../assets/u24.png" id="logoimg" class="logoimgStyle" width="35" height="35">
                <p id="logotext">单词赢</p>
            </div>
            <input type = "button" class = "button-style1" id = "exit" value = "退出" @click="logout">
            <input type = "button" class = "button-style1" id = "help" value = "帮助">
            <input type = "button" class = "button-style1" id = "setting" value = "设置" @click="gosetting">
            <input type = "button" class = "button-style1" id = "rank" value = "排行榜" @click="gorank">
            <input type = "button" class = "button-style" value = "主页" @click="gomain">
        </div>

        <!--主体部分-->
        <div id = main>

	    	<!--修改密码部分-->
	    	<div class = "input">
	    		<p>请输入新密码</p>
            	<input type = "text" class = "password" id = "new-password" v-bind:value="password1">
	    	</div>

	    	<div class = "input">
	    		<p>请确认新密码</p>
            	<input type = "text" class = "password" id = "confirm-password" v-bind:value="password2">
	    	</div>
            <input type = "button" class = "button-style2" id = "confirm" value = "确认" @click="change_password">
            <input type = "button" class = "button-style2" id = "cancel" value = "取消" @click="gomain">

        </div>
	</div>
</template>

<script>

export default {
	name: 'setting',
	data: function(){
		return{
			student_id: 0,
            student_name: '',
            coin_rank:{},
            word_rank:{},
            point_rank:{},
            password1:"",
            password2:"",
		}
    },
    beforeCreate(){
		//未登录，跳转到登录界面
		if(this.$store.state.student_id==""){
			window.location = "login.html"
		}
	},
	created(){
		this.student_id = parseInt(this.$store.state.student_id)
		this.student_name = this.$store.state.student_name
        let that = this
        this.$axios({
            method:'get',
            url:'http://localhost:8000/app/getrank',
        }).then(function(response){
            that.coin_rank = response.data.coin_rank
            that.word_rank = response.data.word_rank
            that.point_rank = response.data.point_rank
        })
	},
	methods: {
		logout:function(){
            this.$store.dispatch("Logout")
			window.location = "login.html"
        },
        gomain:function(){
            window.location = "main.html"
        },
        gorank:function(){
            window.location = "chart.html"
        },
        gosetting:function(){
            window.location = "setting.html"
        },
        change_password:function(){
            if(this.password1 == this.password2 && this.password1 != ""){
                let message = '你确定要修改密码吗？'
                if(window.confirm(message) == true){
                    let that = this
                    let param = new URLSearchParams()
                    param.append('new_password',this.password1)
                    this.$axios({
                        method:'post',
                        url:'http://localhost:8000/app/changepassword',
                        data:param,
                    }).then(function(response){
                        window.alert(response.data.change_status)
                        window.location = "main.html"
                    })
                }
            }else if(this.password1!=this.password2){
                window.alert("两次输入密码不相同，请重新输入")
                this.password1 = ""
                this.password2 = ""
            }else if(this.password1 == ""){
                window.alert("密码不能为空")
                this.password1 = ""
                this.password2 = ""
            }
        }
    },
  // components: {
  //   HelloWorld
  // }
}
</script>

<style scoped> 
/* 导航条 */
.navigationStyle {
    overflow: hidden;
    background-color: #e0edfdf1;
}

/* logo */
.logoimgStyle {
    float: left;
	list-style: none;
    margin: 10px 10px;
}

/* logo块 */
.logoStyle {
	width: 150px;
	margin: 0;
	background-color: white;
}

/* 单词赢 */
#logotext {
	float: left;
	margin: 15px 5px;
	padding: 0;
	list-style: none;
	font-family: 'PingFangSC-Semibold', 'PingFang SC Semibold', 'PingFang SC';
    font-weight: 650;
    font-style: normal;
    font-size: 18px;
    color: #0096FA;
    text-align: left;
    line-height: 26px;
}

/* 导航链接 */
.button-style1 {
    height: 56px;
    float: right;
    display: block;
    color: black;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
    background: inherit;
    background-color: #e0edfdf1;
    border-radius: 4px;
    border-width: 0px;
    word-wrap: break-word;
    text-transform: none;
}

/* 导航 - 修改颜色 */
.button-style1:hover {
    background-color: #ddd;
    color: black;
}

/* 主体框 */
#main {
    width: 500px;
    height: 400px;
    margin: auto;
    margin-top: 150px;
}

.input {
	display: flex;
	font-size: 18px;
	font-weight: bold;
	padding-top: 30px;
	padding-left: 20px;
}

.password {
    width: 300px;
    height: 50px;
    background: inherit;
    background-color: rgba(255, 255, 255, 1);
	border-radius: 4px;
    margin-left: 10px;
    font-size: 20px;
}

.button-style2 {
	width: 150px;
	height: 50px;
    font-size: 16px;
    color: white;
    box-sizing: border-box;
    border-width: 1px;
    border-style: solid;
    border-radius: 5px;
	background: inherit;
	margin-top: 30px;
}

#confirm {
	margin-left: 10px;
	background-color: green;
}
#cancel {
	margin-left: 50px;
	background-color: red;
}
</style>
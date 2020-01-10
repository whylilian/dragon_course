<template>
	<div id="setting">
		<navigation></navigation>

        <!--主体部分-->
        <div id = "main">

	    	<!--修改密码部分-->
	    	<div class = "change">
	    		<p>请输入新密码</p>
            	<input type = "text" class = "password" id = "new-password" v-model="password1">
	    	</div>

	    	<div class = "change">
	    		<p>请确认新密码</p>
            	<input type = "text" class = "password" id = "confirm-password" v-model="password2">
	    	</div>
            <input type = "button" class = "button-style2" id = "confirm" value = "确认" @click="change_password">
            <input type = "button" class = "button-style2" id = "cancel" value = "取消" @click="gomain">

        </div>
	</div>
</template>

<script>

import Navigation from "../components/Navigation.vue"

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
        gomain:function(){
            window.location = "main.html"
        },
        change_password:function(){
            let that = this
            window.console.log(this.password1)
            if(this.password1 == this.password2 && this.password1 != ""){
                let message = '你确定要修改密码吗？'
                if(window.confirm(message) == true){
                    let param = new URLSearchParams()
                    param.append('new_password',this.password1)
                    param.append('student_id',this.student_id)
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
    components: {
        Navigation
    }
}
</script>

<style scoped> 
#setting {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin: none;
    height: 100%;
    width: 100%;
  
}

/* 主体框 */
#main {
    width: 500px;
    height: 400px;
    margin: auto;
    margin-top: 150px;
}

.change {
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
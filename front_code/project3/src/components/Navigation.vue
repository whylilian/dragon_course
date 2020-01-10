<template>
    <!--导航条及logo-->
    <div id="navigation" class="navigationStyle">
        <div id="logo" class="logoStyle">
           <img src="../assets/u24.png" id="logoimg" class="logoimgStyle" width="35" height="35">
            <p id="logotext">单词赢</p>
        </div>
        <input type = "button" class = "button-style" id = "exit" value = "退出" @click="logout">
        <input type = "button" class = "button-style" id = "help" value = "帮助">
        <input type = "button" class = "button-style" id = "setting" value = "修改密码" @click="gosetting">
        <input type = "button" class = "button-style" value = "排行榜" @click="gorank">
        <input type = "button" class = "button-style" value = "主页" @click="gomain">
    </div>
</template>

<script>

export default {
    name:'Navigation',
    methods:{
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
    }
}
</script>

<style scoped>
/*导航条*/
.navigationStyle {
    overflow: hidden;
    background-color: #e0edfdf1;
}
/*logo*/
.logoimgStyle {
	float: left;
	list-style: none;
	margin: 10px 10px;
	
}
/*logo块*/
.logoStyle {
	width: 150px;
	margin: 0;
	background-color: white;
}
/*单词赢*/
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
/*导航链接*/
.button-style {
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
/*导航 - 修改颜色*/
.button-style:hover {
    background-color: #ddd;
    color: black;
}
</style>
<template>
	<div id="chart">
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
        <p id = "word2">排行榜</p>
        <div id = "box3">
            <div class = "chart" id = "studytime-today">
                <div class = "title" id = "title-box1">
                    <p class = "title-word">金币数</p>
                    <p v-for="(value,key,index) in coin_rank">{{index+1}}        {{key}}        {{value}}</p>
                </div>
            </div>
            <div class = "chart" id = "studytime-lastmonth">
                <div class = "title" id = "title-box2">
                    <p class = "title-word">熟练的单词数</p>
                    <p v-for="(value,key,index) in word_rank">{{index+1}}        {{key}}        {{value}}</p>
                </div>
            </div>
            <div class = "chart" id = "goldcoin-week">
                <div class = "title" id = "title-box3">
                    <p class = "title-word">总积分</p>
                    <p v-for="(value,key,index) in point_rank">{{index+1}}        {{key}}        {{value}}</p>
                </div>
            </div>
        </div>
	</div>
</template>

<script>

export default {
	name: 'chart',
	data: function(){
		return{
			student_id: 0,
            student_name: '',
            coin_rank:{},
            word_rank:{},
            point_rank:{},
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
    },
  // components: {
  //   HelloWorld
  // }
}
</script>

<style scoped>
#chart {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin: none;
    height: 100%;
    width: 100%;
  
}
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
#word2 {
    margin-top: 80px;
    text-align: center;
    font-size: 24px;
    font-weight: 700;
}
#box3 {
    display: flex;
    width: 1000px;
    height: 450px;
    margin: 10px auto 0;
}
.chart {
    width: 300px;
    height: 430px;
    margin-top: 10px;
    margin-left: 10px;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    background-color: rgba(255, 255, 255, 1);
}
.title {
    width: 300px;
    height: 30px;
    border-bottom: 1px solid;
}
.title-word {
    margin: 0;
    font-size: 14px;
    padding-top: 5px;
    padding-left: 8px;
    text-align: center;
}
</style>
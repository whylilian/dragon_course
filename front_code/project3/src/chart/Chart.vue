<template>
	<div id="chart">
		<navigation></navigation>
        <p id = "word2">排行榜</p>
        <div id = "box3">
            <div class = "chart" id = "studytime-today">
                <div class = "title" id = "title-box1">
                    <img id="img1" class="img-style" src="../assets/gold.png">
                    <img id="first" class="img-style2" src='../assets/first.png'>                    
                    <img id="second" class="img-style2" src='../assets/second.png'>  
                    <img id="third" class="img-style2" src='../assets/third.png'>
                    <div class = "rank" v-for="(value,key,index) in coin_rank">
                        <span id="num">{{index+1}}</span>
                        <span id="uname">{{key}}</span>
                        <span id="grade">{{value}}</span>
                        <img id="img5" src='../assets/medal.png'>
                    </div>
                </div>
            </div>
            <div class = "chart" id = "studytime-lastmonth">
                <div class = "title" id = "title-box2">
                    <img id="img2" class="img-style" src="../assets/word.png">
                    <img id="first" class="img-style2" src='../assets/first.png'>                    
                    <img id="second" class="img-style2" src='../assets/second.png'>  
                    <img id="third" class="img-style2" src='../assets/third.png'>
                    <div class = "rank" v-for="(value,key,index) in word_rank">
                        <span id="num">{{index+1}}</span>
                        <span id="uname">{{key}}</span>
                        <span id="grade">{{value}}</span>
                        <img id="img5" src='../assets/medal.png'>
                    </div>
                </div>
            </div>
            <div class = "chart" id = "goldcoin-week">
                <div class = "title" id = "title-box3">
                    <img id="img3" class="img-style" src="../assets/score.png">
                    <img id="first" class="img-style2" src='../assets/first.png'>                    
                    <img id="second" class="img-style2" src='../assets/second.png'>  
                    <img id="third" class="img-style2" src='../assets/third.png'>
                    <div class = "rank" v-for="(value,key,index) in point_rank">
                        <span id="num">{{index+1}}</span>
                        <span id="uname">{{key}}</span>
                        <span id="grade">{{value}}</span>
                        <img id="img4" src='../assets/time.png'>
                    </div>
                </div>
            </div>
        </div>
	</div>
</template>

<script>

import Navigation from "../components/Navigation.vue"

export default {
	name: 'chart',
	data: function(){
		return{
			student_id: 0,
            student_name: '',
            coin_rank:{这是第一名:"1",这是第二名:'2'},
            word_rank:{这是第一名:"1",这是第二名:'2'},
            point_rank:{这是第一名:"1",这是第二名:'2'},
		}
    },/*
    beforeCreate(){
		//未登录，跳转到登录界面
		if(this.$store.state.student_id==""){
			window.location = "login.html"
		}
	},*/
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
    components: {
        Navigation
    }
}
</script>

<style scoped>
/* #chart {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin: none;
    height: 100%;
    width: 100%;
  
} */

#word2 {
    margin-top: 20px;
    text-align: center;
    font-size: 24px;
    font-weight: 700;
}
#box3 {
    display: flex;
    width: 1000px;
    height: 700px;
    margin: 10px auto 0;
    margin-top: 50px;
}
.chart {
    width: 300px;
    height: 650px;
    margin-top: 10px;
    margin-left: 10px;
    border-radius: 4px;
    background: inherit;
    background-color: rgba(255, 255, 255, 1);
}
.title {
    width: 300px;
    height: 30px;
}
.title-word {
    margin: 0;
    font-size: 14px;
    padding-top: 5px;
    padding-left: 8px;
    text-align: center;
}
.rank {
    width: 255px;
    height: 45px;
    margin-left: 15px;
    border-radius: 5px;
    background-color: #EEF9FF;
    margin-top: 5px;
    line-height: 45px;
    text-align: 10px;
    padding-left: 15px;
}
.img-style {
    width:255px;
    padding-left: 20px;
    margin: auto;
    margin-top: -50px;
}
#img2 {
    padding-top: 11px;
}
#img4 {
    float: right;
    margin-top: 8px;
    margin-right: 10px; 
    width: 29px;
    height: 29px;
}
#img5 {
    float: right;
    margin-top: 0px;
    margin-right: 5px; 
    width: 47px;
    height: 37px;
}
.img-style2{
    width: 30%
}
#first {
    margin-left:20px;
}
#second {
    float: left;
    margin-top:20px;
}
#third {
    float: right;
    margin-top:20px;
}
#num {
    color: #409EFF;
    font-family: Arial, Helvetica, sans-serif;
    line-height: 45px;
    float: left;
    font-size: 16px;
}
#uname{
    margin-left: 20px;
    line-height: 45px;
    float: left;
    font-family:'Microsoft YaHei UI';
    font-weight: 500;
    font-size: 16px;
    color: #606266;
}
#grade{
    float: right;
    margin-right: 15px;
    font-family: Arial, Helvetica, sans-serif;
    font-size: 16px;
    color: #606266;
    font-weight: 500;
}
</style>
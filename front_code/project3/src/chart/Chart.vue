<template>
	<div id="chart">
		<navigation></navigation>
        <p id = "word2">排行榜</p>
        <div id = "box3">
            <div class = "chart" id = "studytime-today">
                <div class = "title" id = "title-box1">
                    <img id="img1" class="img-style" src="../assets/gold.png">
                    <div class = "rank" v-for="(value,key,index) in coin_rank">
                        <span id="num">{{index+1}}、</span>
                        <span id="uname">{{key}}</span>
                        <span id="grade">{{value}}</span>
                    </div>
                </div>
            </div>
            <div class = "chart" id = "studytime-lastmonth">
                <div class = "title" id = "title-box2">
                    <img id="img2" class="img-style" src="../assets/word.png">
                    <div class = "rank" v-for="(value,key,index) in word_rank">
                        <span id="num">{{index+1}}、</span>
                        <span id="uname">{{key}}</span>
                        <span id="grade">{{value}}</span>
                    </div>
                </div>
            </div>
            <div class = "chart" id = "goldcoin-week">
                <div class = "title" id = "title-box3">
                    <img id="img3" class="img-style" src="../assets/score.png">
                    <div class = "rank" v-for="(value,key,index) in point_rank">
                        <span id="num">{{index+1}}、</span>
                        <span id="uname">{{key}}</span>
                        <span id="grade">{{value}}</span>
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
    width: 270px;
    height: 25px;
    margin-left: 15px;
    border-radius: 5px;
    background-color: #e0edfdf1;
    margin-top: 10px;
}
.img-style {
    width:200px;
    padding-left: 60px;
    margin: auto;
}
#img2 {
    padding-top: 11px;
}
#uname{
    margin-left: 20px;
}
#grade{
    margin-left: 140px;
}
</style>
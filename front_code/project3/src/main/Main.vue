<template>
	<div id="mainpage">
		<!--导航条及logo-->
        <div id="navigation" class="navigationStyle">
            <div id="logo" class="logoStyle">
               <img src="../assets/u24.png" id="logoimg" class="logoimgStyle" width="35" height="35">
                <p id="logotext">单词赢</p>
            </div>
            <input type = "button" class = "button-style" id = "exit" value = "退出" @click="logout">
            <input type = "button" class = "button-style" id = "help" value = "帮助">
            <input type = "button" class = "button-style" id = "setting" value = "设置">
            <input type = "button" class = "button-style" value = "排行榜" @click="gorank">
            <input type = "button" class = "button-style" value = "主页" @click="gomain">
        </div>
        <!--主体部分-->
        <div id = "main">
            <!--左侧块-->
            <div id = "left">
                <!--左上角-->
                <div id = "top-left">
                    <div id="headportrait" class="headportraitStyle">
                        <img src="../assets/u35.png" width="35" height="35" id="headportrait_img" class="headportrait_imgStyle">
                    </div>
                    <div id="h3head" class="h3headStyle">
                        <h3>{{student_name}}</h3>
                    </div>
                    <div id="p1" class="p1Style">
                        <p>金币数：{{coins}}</p>
                    </div>
                    <input type="button" id="clockOn" class="clockOnStyle" value="打卡" >
                </div>
                <!--左下角-->
                <div id = "buttom-left">
                    <input type = "button" class = "select" id = "learning" value = "正在学习">
                    <input type = "button" class = "select" id = "learning-records" value = "学习统计">
                    <input type = "button" class = "select" id = "word-book" value = "单词本">
                    <input type = "button" class = "select" id = "word-match" value = "单词比赛">
                </div>
            </div>
            <!--右侧块-->
            <div id = "right">
            </div>
        </div>
	</div>
</template>

<script>

export default {
	name: 'mainpage',
	data: function(){
		return{
			student_id: 0,
            student_name: '',
            coins: 0,
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
        this.coins = parseInt(this.$store.state.coins)
		window.console.log(this.student_id)
		window.console.log(this.student_name)
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
        }
    },
  // components: {
  //   HelloWorld
  // }
}
</script>

<style scoped>
#mainpage {
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
/* 主体部分 */
#main {
    display: flex;
    width: 1200px;
    height: 700px;
    margin: 100px auto;
}

/* 左侧部分 */
#left {
    width: 300px;
    height: 400px;
}

/* 左上角部分 */
#top-left {
    width: 300px;
    height: 120px;
}

.headportraitStyle {
    width: 35px;
    height: 35px;
    margin: 15px 8px 5px 5px;
    float: left;
}
/* 我爱背单词 */
.h3headStyle {
    width: 94px;
}

#h3head {
    margin: 20px 5px 20px 5px;
    float:left; 
}
h3 {
    margin: 0;
}

/* 我的金币 */
.p1Style {
    float: left;
    margin: 5px;
    width: 120px;
  }

/* 打卡按钮 */
.clockOnStyle {
    background-color: rgb(16, 150, 190); /* Green */
    border: none;
    margin-left: 5px;
    margin-top: 13px;
    border-radius: 8px;
    color: white;
    padding: 7px 12px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
}

/* 左下角部分 */
.buttom-left {
    width: 300px;
    height: 280px;
}

/*按钮被按下时*/
.select:focus {
    border-right-width: 4px;
    border-right-color: rgb(6, 115, 204) ;
    background-color:  rgba(93, 204, 255, 0.192);
    color:rgb(14, 140, 243);
}

/*按钮样式*/
.select {
    background-color: rgba(255, 253, 253, 0.945); 
    border: 1px solid whitesmoke;
    width: 200px;
    margin-top: 10px;
    border-radius: 4px; 
    color: black;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
}

/*鼠标在按钮上时*/
.select:hover {
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
    background-color: rgba(93, 204, 255, 0.192); 
	color:rgb(14, 140, 243);
}

#right {
    margin-left: 50px;
    width: 850px;
    height: 700px;
    background-color: black;
}
</style>
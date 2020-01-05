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
            <input type = "button" class = "button-style" id = "setting" value = "修改密码" @click="gosetting">
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
                    <input type = "button" class = "select" id = "learning" value = "正在学习" @click="mybooks">
                    <input type = "button" class = "select" id = "learning-records" value = "学习统计" @click="statistics">
                    <input type = "button" class = "select" id = "word-book" value = "单词本">
                    <input type = "button" class = "select" id = "word-match" value = "单词比赛">
                </div>
            </div>
            <!--右侧块-->
            <div id = "right" v-show="show">
                <div v-show="show_books">
                    <div v-for="index in books">
                        <p>教材名称：{{index.book_name}}</p>
                        <p>教材编号：{{index.book_id}}</p>
                        <p>教材启用状态：{{index.enable}}</p>
                        <input type="button" value="进入学习" v-if="index.enable==1" @click="study(index.book_id,index.book_name)">
                        <input type="button" value="请求开通教材" v-if="index.enable==0" @click="">
                    </div>
                </div>
                <div v-show="show_study">
                    <!--切换单词书按钮-->
                    <input type = "button" id = "switch-book" value = "切换单词书">
                    <!--第一行文字及标签-->
                    <div id = "box1">
                        <p id = "word1">{{course_name}}</p>
                        <p id = "word2">学前检测</p>
                        <span class = "num" id = "num1" v-if="study_status==1">？</span>
                        <span class="num" v-if="study_status==2">{{}}</span>
                        <span class = "num" id = "num2">VS</span>
                        <span class = "num" id = "num3">？</span>
                    </div>

                    <!--第二行内容-->
                    <div id = "box2">
                        <div id = "word3">
                            <p>{{now_book_name}}</p>
                        </div>
                        <!--圆形百分比，待补充-->
                        <div id = "rate">
                        </div>
                        <div id = "btn">
                            <input type = "button" class = "button-style3" id = "preschool-test" value="学前检测" @click="goxueqian" v-if="study_status==1">
                        </div>
                    </div>

                    <!--第三行内容-->
                    <div id = "box3">
                        <input type = "button" class = "button-style4" id = "unit1" value = "1">
                        <input type = "button" class = "button-style4" id = "unit2" value = "2">
                        <input type = "button" class = "button-style4" id = "unit3" value = "3">
                        <input type = "button" class = "button-style4" id = "unit4" value = "4">
                        <input type = "button" class = "button-style4" id = "unit5" value = "5">
                        <input type = "button" class = "button-style4" id = "unit6" value = "6">
                        <input type = "button" class = "button-style4" id = "unit7" value = "7">
                        <input type = "button" class = "button-style4" id = "unit8" value = "8">
                        <input type = "button" class = "button-style4" id = "unit9" value = "9">
                        <input type = "button" class = "button-style4" id = "unit10" value = "10">
                        <input type = "button" class = "button-style4" id = "unit11" value = "11">
                        <input type = "button" class = "button-style4" id = "unit12" value = "12">
                    </div>
                </div>
                <div v-show="show_xueqian">
                    <p id = "word_xueqian1">初中核心词</p>
			        <img src="../assets/u209.png" id="u209">
			        <p id = "word_xueqian2">3分钟测出你的词汇掌握水平</p>
			        <p id = "word_xueqian3">根据检测结果定制针对性学习方案</p>
			        <p id = "word_xueqian4">你需要在3分钟内完成以下题目，请保持专注</p>
			        <input type = "button" id = "start" value = "立即开始" @click="startxueqian">
                </div>
                <div v-if="show_statistics">
                    <p>总共学习单词数量：{{word_numbers}}</p>
                    <table>
                        <tr>
                            <th>序号</th>
                            <th>测试类型</th>
                            <th>分数</th>
                        </tr>
                        <tr v-for="index in tests_type">
                            <td>{{index}}</td>
                            <td>{{tests_type[index-1]}}</td>
                            <td>{{tests_grade[index-1]}}</td>
                        </tr>
                    </table>
                </div>
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
            show:false,
            test:{},
            show_study:false,
            show_statistics:false,
            show_xueqian:false,
            show_books:false,
            tests_type:{},
            tests_grade:{},
            books:{},
            word_numbers:0,
            study_status:0,
            now_book_id:0,
            now_book_name:'',
            course_name:'',
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
        },
        gosetting:function(){
            window.location = "setting.html"
        },
        mybooks:function(){
            this.show = true
            this.show_study = false
            this.show_xueqian = false
            let that = this
            let param = new URLSearchParams
            param.append('student_id',this.student_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/getbooks',
                data:param,
            }).then(function(response){
                window.console.log(response)
                that.books = response.data
                that.show_books = true
            })
        },
        study:function(book_id,book_name){
            this.show = true
            let that = this
            this.now_book_id = book_id
            this.now_book_name = book_name
            this.show_books = false
            let param = new URLSearchParams
            param.append('student_id',this.student_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/studystatus',
                data:param,
            }).then(function(response){
                window.console.log(response)
                that.study_status = response.data.study_status
                that.course_name = response.data.course_name
                that.show_study = true
            })
        },
        goxueqian:function(){
            this.show = true
            this.show_study = false
            this.show_xueqian = true
        },
        statistics:function(){
            this.show = true
            this.show_statistics = true
            let that = this
            let param = new URLSearchParams
            param.append('student_id',this.student_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/studentstatistics',
                data:param,
            }).then(function(response){
                window.console.log(response)
                that.tests_type = response.data.tests_type
                that.tests_grade = response.data.tests_grade
                that.word_numbers = response.data.word_numbers
            })
        },
        startxueqian:function(){
            let that = this
              
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
    background-color: #ffffff;
}

/* 学前测试开始页面CSS开始 */
#word_xueqian1 {
    height: 40px;
    font-size: 30px;
    font-weight: bold;
    margin-left: 50px;
}
#u209 {
     display: block;
     width: 350px;
     height: 200px;
     margin: 70px auto 0;
}
#word_xueqian2 {
    text-align: center;
    font-size: 14px;
    font-weight: bold;
    color: hsla(0, 0%, 0%, 0.427450980392157);
    margin-top: 30px;
}
#word_xueqian3 {
    text-align: center;
    font-size: 14px;
    color: hsla(0, 0%, 0%, 0.427450980392157);
}
#word_xueqian4 {
    text-align: center;
    font-size: 14px;
    margin-top: 100px;
}
/* 学前测试开始页面CSS结束 */

/* 开始按钮 */
#start {
    margin: 15px auto 0;
    width: 100px;
    height: 40px;
    font-size: 14px;
    color: white;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    background-color: #1890FF;
}

/* 教材和当前学习单词书页面CSS开始 */
#switch-book {
    width: 130px;
    height: 45px;
    font-size: 14px;
    color: black;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    border-color: black;
    background: inherit;
    background-color: white;
    margin-left: 500px;
}
/* 第一行文字及标签 */
#box1 {
    width: 850px;
    height: 50px;
    display: flex;
    margin-top: 50px;
}
#word1 {
    font-size: 14px;
    margin-left: 50px;
    display: block;
}
#word2 {
    font-size: 14px;
    margin-left: 200px;
}
.num {
    font-size: 30px;
    margin-left: 20px;
}
#num1 {
    color: orange;
}
#num2 {
    color: black;
}
#num3 {
    color: black;
}
/* 第二行内容 */
#box2 {
    width: 850px;
    height: 250px;
    margin-top: 50px;
    display: flex;
}
#word3 {
    width: 150px;
    height: 100px;
    font-size: 30px;
    font-weight: bold;
    margin-left: 50px;
}
#rate {
    width: 150px;
    height: 150px;
    margin-top: 50px;
    margin-left: 150px;
}
#btn {
    width: 200px;
    height: 150px;
    margin-top: 50px;
    margin-left: 100px;
    display: flex;
    flex-direction: column;
}
.button-style3 {
    width: 150px;
    height: 40px;
    font-size: 14px;
    color: white;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    background-color: #1890FF;
}
/* 第三行内容 */
#box3 {
    width: 600px;
    height: 200px;
}
.button-style4 {
    width: 70px;
    height: 70px;
    border: none;
    font-size: 20px;
    border-radius: 50%;
    background: inherit;
    background-color:#D3D3D3;
    margin-left: 20px;
    margin-top: 20px;
}
/* 教材和当前学习单词书页面CSS结束 */
</style>
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
                    <input type = "button" class = "select" id = "word-book" value = "单词本" @click="check_familiarity">
                    <input type = "button" class = "select" id = "word-match" value = "单词比赛">
                </div>
            </div>
            <!--右侧块-->
            <div id = "right" v-show="show">
                <div v-show="show_books">
                    <div v-for="index in books">
                        <div id="book_box">
                            <p>教材名称：{{index.book_name}}</p>
                            <p>教材编号：{{index.book_id}}</p>
                            <p>教材启用状态：{{index.enable}}</p>
                            <input type="button" value="进入学习" v-if="index.enable==1" @click="study(index.book_id,index.book_name)">
                            <input type="button" value="请求开通教材" v-if="index.enable==0" @click="">
                        </div>
                    </div>
                </div>
                <div v-show="show_study">
                    <!--切换单词书按钮-->
                    <input type = "button" id = "switch-book" value = "切换单词书" @click="mybooks">
                    <!--第一行文字及标签-->
                    <div id = "box1">
                        <p id = "word1">{{course_name}}</p>
                        <p id = "word2">学前检测</p>
                        <span class = "num" id = "num1" v-if="study_status==1">？</span>
                        <span class="num" v-if="study_status==2">{{before_grade}}</span>
                        <span class = "num" id = "num2">VS</span>
                        <span class = "num" id = "num3" v-if="study_status!=3">？</span>
                        <span class="num" v-if="study_status==3">{{after_grade}}</span>
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
                <!--单词本页面-->
                <div v-show="show_word_book">
                    <div>
                        <span>复习顺序：</span>
                        <input type="radio" name="radio1" value="familiarity" v-model="word_order" @click="check_familiarity">熟悉程度
                        <input type="radio" name="radio1" value="letter" v-model="word_order" @click="check_letter">字母顺序
                        <span id="word_status1">生词</span>
                        <span id="word_status2">熟悉</span>
                        <span id="word_status3">熟练</span>
                    </div>
                    <br>
                    <div id="wordbook" v-for="index in  words">
                        <div id="wordbook1" v-if="index.degree==1">
                            {{index.spell}}{{index.mean}}
                        </div>
                        <div id="wordbook2" v-if="index.degree==2">
                            {{index.spell}}{{index.mean}}
                        </div>
                        <div id="wordbook3" v-if="index.degree==3">
                            {{index.spell}}{{index.mean}}
                        </div>
                    </div>
                </div>
                <!--学前学习进入页面-->
                <div v-show="show_xueqian">
                    <p id = "word_xueqian1">初中核心词</p>
			        <img src="../assets/u209.png" id="u209">
			        <p id = "word_xueqian2">3分钟测出你的词汇掌握水平</p>
			        <p id = "word_xueqian3">根据检测结果定制针对性学习方案</p>
			        <p id = "word_xueqian4">你需要在3分钟内完成以下题目，请保持专注</p>
			        <input type = "button" id = "start" value = "立即开始" @click="startxueqian">
                </div>
                <!--学习统计页面-->
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
                <div v-show="show_test">
                    <!--标题 -->
                    <div id = "title">
                        <p id = "word">学前检测（计划检测28题）</p>
                    </div>
                    <!--选择题-->
                    <div v-for="(value,key,index) in test_before">
                        <div id = "one-choice">
                            <h2>{{key}}、{{value.spell}}</h2>
                            <input type = "radio" class = "option" :name = "key" value = "A" v-model="test_select[key]">A:{{value.A}}
                            <input type = "radio" class = "option" :name = "key" value = "B" v-model="test_select[key]">B:{{value.B}}
                            <input type = "radio" class = "option" :name = "key" value = "C" v-model="test_select[key]">C:{{value.C}}
                            <input type = "radio" class = "option" :name = "key" value = "D" v-model="test_select[key]">D:{{value.D}}
                        </div>
                    </div>
                    <input type = "button" id = "commit" value = "提交" @click="commit_test">
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
			student_id: 0,//学生id
            student_name: '',//学生姓名
            coins: 0,//当前学生拥有的金币数
            coin_rank:{},//金币排行榜字典
            word_rank:{},//单词书排行榜字典
            point_rank:{},//积分排行榜字典
            show:false,//显示右边主体框
            test:{},
            show_study:false,//显示学习页面
            show_statistics:false,//显示学习统计页面
            show_xueqian:false,//显示学前测试进入页面
            show_books:false,//显示课程课本选择页面
            show_word_book:false,//显示单词书页面
            show_test:false,//显示学前测试页面
            tests_type:{},//测试类型的字典
            tests_grade:{},//测试类型对应的测试分数的字典
            books:{},
            words:{},
            test_select:{},//测试页面学生做的选项
            test_before:{},//测试题数据
            word_numbers:0,
            study_status:0,//记录学生学习状态，用来判断是否进行学前测试、学后测试
            now_book_id:0,//当前学习的书本id
            now_book_name:'',//当前学习的书本名字
            before_grade:0,//学前测试的成绩
            after_grade:0,//学后测试的成绩
            course_name:'',//学生上的课程名字
            word_order:'familiarity',//单词书单词排序的类别
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
        check_familiarity:function(){
            this.show = true
            this.show_study = false
            this.show_xueqian = false
            this.show_statistics = false
            this.show_books = false
            this.show_test = false
            this.word_order = 'familiarity'
            let that = this
            let param = new URLSearchParams
            param.append('order',this.word_order)
            param.append('student_id',this.student_id)
            window.console.log(this.word_order)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/wordbook',
                data:param,
            }).then(function(response){
                window.console.log(response)
                that.words = response.data
                that.show_word_book = true
            })
        },
        check_letter:function(){
            this.show = true
            this.show_study = false
            this.show_xueqian = false
            this.show_statistics = false
            this.show_books = false
            this.show_test = false
            this.word_order = 'letter'
            let that = this
            let param = new URLSearchParams
            param.append('order',this.word_order)
            param.append('student_id',this.student_id)
            window.console.log(this.word_order)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/wordbook',
                data:param,
            }).then(function(response){
                window.console.log(response)
                that.words = response.data
                that.show_word_book = true
            })
        },
        mybooks:function(){
            this.show = true
            this.show_study = false
            this.show_xueqian = false
            this.show_statistics = false
            this.show_word_book = false
            this.show_test = false
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
            this.show_books = false
            this.show_statistics = false
            this.show_xueqian = false
            this.show_word_book = false
            this.show_test = false
            let that = this
            this.now_book_id = book_id
            this.now_book_name = book_name
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
            this.show_xueqian = true
            this.show_study = false
            this.show_statistics = false
            this.show_books = false
            this.show_word_book = false
            this.show_test = false
        },
        statistics:function(){
            this.show = true
            this.show_statistics = true
            this.show_study = false
            this.show_xueqian = false
            this.show_books = false
            this.show_word_book = false
            this.show_test = false
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
            this.show = true
            this.show_statistics = false
            this.show_study = false
            this.show_xueqian = false
            this.show_books = false
            this.show_word_book = false
            let param = new URLSearchParams
            param.append('student_id',this.student_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/testbefore',
                data:param,
            }).then(function(response){
                that.test_before = response.data
                that.show_test = true
            })
        },
        commit_test:function(){
            let message = '确定提交吗？'
            if(window.confirm(message)==true){
                let that = this
                let count = 0
                let i = 1
                for(let item in this.test_select){
                    if(item!=i && i!=28){
                        window.alert('你还有选项未选择')
                        return
                    }
                    i++
                    if(this.test_select[item]==this.test_before[item].correct){
                        count++
                    }
                }
                this.before_grade = parseInt((count/28)*100)
                this.study_status = 2
                this.show = true
                this.show_study = true
                this.show_statistics = false
                this.show_xueqian = false
                this.show_books = false
                this.show_word_book = false
                this.show_test = false
                let param = new URLSearchParams
                param.append('student_id',this.student_id)
                param.append('before_grade',this.before_grade)

            }
        }
    },
  // components: {
  //   HelloWorld
  // }
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
/*按钮被按下时*/
.select:focus {
    border-right-width: 4px;
    border-right-color: rgb(6, 115, 204) ;
    background-color:  rgba(93, 204, 255, 0.192);
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

#book_box{
    width: 250px;
    height: 200px;
    margin: 10px;
    float: left;
    border: 2px solid black;
}
/* 开始按钮 */
#start {
    display:block;
    margin:0 auto;
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

/* 单词书页面CSS开始 */
#wordbook{
    width: 100px;
    height: 80px;
    margin: 10px;
    float: left;
}
#wordbook1{
    background-color: red;
    width: 100px;
    height: 80px;
    text-align: center;
    color: white;
    margin: 10px;
    float: left;
}
#wordbook2{
    background-color: blue;
    width: 100px;
    height: 80px;
    text-align: center;
    color: white;
    margin: 10px;
    float: left;
}
#wordbook3{
    background-color: green;
    width: 100px;
    height: 80px;
    text-align: center;
    color: white;
    margin: 10px;
    float: left;
}
#word_status1{
    background-color:red;
    color:white;
    padding: 10px;
    margin: 20px;
    width: 50px;
    height: 30px;
}
#word_status2{
    background-color:blue;
    color:white;
    padding: 10px;
    margin: 20px;
    width: 50px;
    height: 30px;
}
#word_status3{
    background-color:green;
    color:white;
    padding: 10px;
    margin: 20px;
    width: 50px;
    height: 30px;
}
/* 单词书页面结束 */

/* 学前测试页面CSS开始 */
#commit {
    width: 150px;
    height: 40px;
    font-size: 14px;
    color: white;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    background-color: #1890FF;
    display:block;
    margin:0 auto;
}
</style>
<template>
	<div id="mainpage">
		<navigation></navigation>
        <!--主体部分-->
        <div id = "main">
            <!--左侧块-->
            <div id = "left">
                <!--左上角-->
                <div id = "top-left">
                    <div id="headportrait" class="headportraitStyle">
                        <img src="../assets/tubiao.png" width="35" height="35" id="headportrait_img" class="headportrait_imgStyle">
                    </div>
                    <div id="h3head" class="h3headStyle">
                        <h3>{{student_name}}</h3>
                    </div>
                    <div id="p1" class="p1Style">
                        <p>金币数：{{coins}}</p>
                    </div>
                    <div id="p2" class="p2Style">
                        <p>累计打卡天数：{{daka_num}}</p>
                    </div>
                    <input type="button"class="clockOnStyle1" value="打卡" v-if="enable_daka==0" @click="daka">
                    <input type="button"class="clockOnStyle2" value="已打卡" v-if="enable_daka==1" :disabled="enable_daka==1">
                </div>
                <!--左下角-->
                <div id = "buttom-left">
                    <input type = "button" :class = "{select1:button1,select2:!button1}" value = "正在学习" @click="mybooks">
                    <input type = "button" :class = "{select1:button2,select2:!button2}" value = "学习统计" @click="statistics">
                    <input type = "button" :class = "{select1:button3,select2:!button3}" value = "单词本" @click="check_familiarity">
                    <input type = "button" :class = "{select1:button4,select2:!button4}" value = "单词比赛" @click="match">
                </div>
            </div>
            <!--右侧块-->
            <div id = "right" v-show="show">
                <div v-show="show_books">
                    <div v-for="index in books">
                        <div id="book_box">
                            <p>{{index.book_name}}</p>
                            <p>教材编号：{{index.book_id}}</p>
                            <p v-if="index.enable==1">启用状态：已启用</p>
                            <p v-if="index.enable!=1">启用状态：未启用</p>
                            <input type="button" :class="{gostudy1:index.enable==1,gostudy2:index.enable!=1}" value="进入学习" :disabled="index.enable!=1" @click="study(index.book_id,index.book_name)">
                        </div>
                    </div>
                </div>
                <div v-show="show_study">
                    <!--切换单词书按钮-->
                    <input type = "button" id = "switch-book" value = "切换单词书" @click="mybooks">
                    <!--第一行文字及标签-->
                    <div id = "box1">
                        <p id = "word1">{{course_name}}</p>
                        <p id = "before-study">学前检测</p>
                        <span class = "num" id = "num1" v-if="study_status==1">？</span>
                        <span class="num" v-if="study_status==2||study_status==3">{{before_grade}}</span>
                        <span class = "num" id = "num2">VS</span>
                        <span class = "num" id = "num3" v-if="study_status!=3">？</span>
                        <span class="num" v-if="study_status==3">{{after_grade}}</span>
                        <p id = "after-study">学后检测</p>
                    </div>
                    <!--第二行内容-->
                    <div id = "box2">
                        <div id = "word3">
                            <p>{{now_book_name}}</p>
                        </div>
                        <div id = "btn">
                            <el-progress type="circle" :percentage="percentage" style="width:126px;height:126px;"></el-progress>
                        </div>
                        <input type = "button" class = "button-style3" value="学前检测" @click="goxueqian" v-if="study_status==1">
                        <input type="button" class="button-style3" value="巩固测试" @click="gonggu" v-if="study_status==2">
                        <input type="button" class="button-style3" value="学后测试" @click="xuehou" v-if="study_status==3">
                    </div>
                    <!--第三行内容-->
                    <div id = "box3">
                        <input type = "button" v-for="(value,key,index) in now_book_unit" :class="{not_finish:value==0,finish:value==1}" :disabled="study_status==1" v-model="key" @click="gostudy(key)">
                    </div>
                </div>
                <!--单词本页面-->
                <div v-show="show_word_book">
                    <!--上方框-->
                    <div id = "top-box">

                        <p id = "order">复习顺序:</p>
                        <div class = "review-mode">
                            <input type="radio" name="radio1" value="familiarity" v-model="word_order" @click="check_familiarity">熟悉程度
                        </div>
                        <div class = "review-mode">
                            <input type="radio" name="radio1" value="letter" v-model="word_order" @click="check_letter">字母顺序
                        </div>
                        <div class = "color" id = "red"></div>
                        <p class = "proficiency">生词</p>
                        <div class = "color" id = "blue"></div>
                        <p class = "proficiency">熟悉</p>
                        <div class = "color" id = "green"></div>
                        <p class = "proficiency">熟练</p>
                    </div>

                    <!--下方框-->
                    <div id = "buttom-box">
                        <div v-for="(value,key,index) in words">
                        <input type = "button" class = "button-color" id = "button-red" v-if="value.degree==1&&key>start_index&&key<=start_index+12" :value="value.spell">
                        <input type = "button" class = "button-color" id = "button-blue" v-if="value.degree==2&&key>start_index&&key<=start_index+12" :value="value.spell">
                        <input type = "button" class = "button-color" id = "button-green" v-if="value.degree==3&&key>start_index&&key<=start_index+12" :value="value.spell">
                        </div>
                    </div>
                    <input type = "button" id = "next_group" value = "下一组" @click="next_group" v-if="start_index<=word_length&&start_index+12<word_length">
                    <input type="button" id="pre_group" value="上一组" @click="pre_group" v-if="start_index>=12">
                    <!-- <el-button-group>
                        <el-button type="primary" icon="el-icon-arrow-left" @click="pre_group" v-if="start_index>=12">上一组</el-button>
                        <el-button type="primary" @click="next_group" v-if="start_index<=word_length&&start_index+12<word_length">下一组<i class="el-icon-arrow-right el-icon--right"></i></el-button>
                    </el-button-group> -->
                </div>
                <!--学前学习进入页面-->
                <div v-show="show_xueqian">
                    <p id = "word_xueqian1">初中核心词</p>
			        <img src="../assets/u209.png" id="u209">
			        <p id = "word_xueqian2">3分钟测出你的词汇掌握水平</p>
			        <p id = "word_xueqian3">根据检测结果定制针对性学习方案</p>
			        <p id = "word_xueqian4">你需要在3分钟内完成以下题目，请保持专注</p>
			        <input type = "button" id = "start" value = "立即开始" @click="starttest">
                </div>
                <!--学习统计页面-->
                <div v-if="show_statistics" id="shabi">
                    <el-scrollbar>
                        <h2 id="word_number">总共学习单词数量：{{word_numbers}}</h2>
                        <ve-line :data="chartData"></ve-line>
                        <h2 id="word_number">最近一周内单词学习情况图表：{{word_numbers}}</h2>
                        <ve-histogram :data="chartData"></ve-histogram>
                        <h2 id="word_number">本月学习时间统计：{{word_numbers}}</h2>
                        <ve-pie :data="pieData" :settings="pie_settings"></ve-pie>
                        <hr>
                        <p id="title1">测试成绩</p>
                        <div id="bake">
                            <table>
                                <tr>
                                    <th width="8%" class="table">序号</th>
                                    <th  width="8%" class="table">测试类型</th>
                                    <th  width="8%" class="table">分数</th>
                                    <th  width="8%" class="table">通过</th>
                                </tr>
                                <tr v-for="(key,value,index) in tests_type">
                                    <td>{{index+1}}</td>
                                    <td v-if="tests_type[index]==1">学前测试</td>
                                    <td v-if="tests_type[index]==2">巩固测试</td>
                                    <td v-if="tests_type[index]==3">学后测试</td>
                                    <td>{{tests_grade[index]}}</td>
                                    <td v-if="tests_grade[index]<60" color="red">否</td>
                                    <td v-if="tests_grade[index]>=60" color="green">是</td>
                                </tr>
                            </table>
                        </div>
                    </el-scrollbar>
                </div>
                <div v-show="show_test">
                    <!--标题 -->
                    <div id = "title">
                        <p id = "word" v-if="study_status==1">学前检测（计划检测28题）</p>
                        <p id = "word" v-if="study_status==3">学后检测（计划检测28题）</p>
                        <img src = "../assets/time.png" id = "time-picture">
                        <span id = "count-down">{{show_time}}</span>

                        <hr>
                    </div>
                    <!--选择题-->
                    <div v-for="(value,key,index) in test_timu">
                        <div id = "one-choice">
                            <div v-if="key>test_index&&key<=test_index+4">
                                <h2>{{key}}、{{value.spell}}</h2>
                                <el-radio v-model="test_select[key]" label="A">A:{{value.A}}</el-radio>
                                <el-radio v-model="test_select[key]" label="B">B:{{value.B}}</el-radio>
                                <el-radio v-model="test_select[key]" label="C">C:{{value.C}}</el-radio>
                                <el-radio v-model="test_select[key]" label="D">D:{{value.D}}</el-radio>
                                <!-- <input type = "radio" class = "option" :name = "key" value = "A" v-model="test_select[key]">A:{{value.A}}
                                <input type = "radio" class = "option" :name = "key" value = "B" v-model="test_select[key]">B:{{value.B}}
                                <input type = "radio" class = "option" :name = "key" value = "C" v-model="test_select[key]">C:{{value.C}}
                                <input type = "radio" class = "option" :name = "key" value = "D" v-model="test_select[key]">D:{{value.D}} -->
                            </div>
                        </div>
                    </div>
                    <!-- 每页显示4题 -->
                    <input type = "button" id = "last-page" value = "上一页" v-if="test_index>=4" @click="pre_page">
                    <input type = "button" id = "next-page" value = "下一页" v-if="test_index<24" @click="next_page">
                    <input type = "button" id = "commit" value = "提交" @click="commit_test" v-if="test_index>=24">
                </div>
                <div v-show="show_gonggu">
                    <!--标题 -->
                    <div id = "title">
                        <p id = "word">巩固检测（计划检测10题）</p>
                        <img src = "../assets/time.png" id = "time-picture">
                        <span id = "count-down">{{show_time}}</span>
                        <hr>
                    </div>
                    <!--选择题-->
                    <div v-for="(value,key,index) in test_timu">
                        <div id = "one-choice">
                            <div v-if="key>test_index&&key<=test_index+4">
                                <h2>{{key}}、{{value.spell}}</h2>
                                <el-radio v-model="test_select[key]" label="A">A:{{value.A}}</el-radio>
                                <el-radio v-model="test_select[key]" label="B">B:{{value.B}}</el-radio>
                                <el-radio v-model="test_select[key]" label="C">C:{{value.C}}</el-radio>
                                <el-radio v-model="test_select[key]" label="D">D:{{value.D}}</el-radio>
                                <!-- <input type = "radio" class = "option" :name = "key" value = "A" v-model="test_select[key]">A:{{value.A}}
                                <input type = "radio" class = "option" :name = "key" value = "B" v-model="test_select[key]">B:{{value.B}}
                                <input type = "radio" class = "option" :name = "key" value = "C" v-model="test_select[key]">C:{{value.C}}
                                <input type = "radio" class = "option" :name = "key" value = "D" v-model="test_select[key]">D:{{value.D}} -->
                            </div>
                        </div>
                    </div>
                    <!-- 每页显示4题 -->
                    <input type = "button" id = "last-page" value = "上一页" v-if="test_index>=4" @click="pre_page">
                    <input type = "button" id = "next-page" value = "下一页" v-if="test_index<8" @click="next_page">
                    <input type = "button" id = "commit" value = "提交" @click="commit_test_gonggu" v-if="test_index>=8">
                </div>
                <!-- 显示所有单词比赛信息页面 -->
                <div v-show="show_match">
                    <p class = "title">我参加的比赛</p>
                    <div id = "match-box1">
                        <div class = "match" v-for="index in commit">
                            <div id = "first-box">
                                <p class = "words" id = "words1">{{index.match}}</p>
                                <p class = "words" id = "words3">已参加</p>
                            </div>
                            <p class = "words" id = "words4">{{index.start_time}}-{{index.end_time}}</p>
                            <div id = "third-box">
                                <p class = "words" id = "words7">我的排名：{{index.match_rank}}</p>
                                <a id = "detail" @click="match_detail(index.match_id)">详情>></a>
                            </div>
                        </div>
                    </div>
                    <p class = "title">单词比赛</p>
                    <div id = "match-box2">
                        <div class = "match" v-for="index in uncommit">
                            <div id = "forth-box">
                                <p class = "words" id = "words8">{{index.match}}</p>
                                <p class = "words" id = "words10">我要参加</p>
                            </div>
                            <p class = "words" id = "words11">{{index.start_time}}-{{index.end_time}}</p>
                            <div id = "sixth-box">
                                <p class = "words" id = "words14">我的排名 999</p>
                                <a id = "detail" @click="match_detail(index.match_id)">详情>></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div v-show="show_match_detail">
                    <div id = "match_div">
                        <div id = "match_topleft" v-for="(value,key,index) in match_detail_message" v-if="key=='match_detail'">
                            <p v-if="key=='match_detail'" id = "name">{{match_detail_message[key].match_name}}</p>
                            <p v-if="key=='match_detail'" class = "title_match" id = "time">比赛时间</p>
                            <p v-if="key=='match_detail'" class = "text_match" id = "match-time">{{match_detail_message[key].match_time}}</p>
                            <p v-if="key=='match_detail'" class = "title_match" id = "scope">参赛范围</p>
                            <p v-if="key=='match_detail'" class = "text_match" id = "match-scope">{{match_detail_message[key].match_scope}}</p>
                            <p v-if="key=='match_detail'" class = "title_match" id = "content">比赛内容</p>
                            <p v-if="key=='match_detail'" class = "text_match" id = "match-content">{{match_detail_message[key].match_message}}</p>
                            <p v-if="key=='match_detail'" class = "title_match" id = "reward">奖励</p>
                            <p v-if="key=='match_detail'" class = "text_match" id = "match-reward">奖励10积分</p>
                            <p v-if="key=='match_detail'" class = "title_match" id = "rule">比赛规则</p>
                            <p v-if="key=='match_detail'" class = "text_match" id = "match-rule">{{match_detail_message[key].match_rule}}</p>
                        </div>
                        <div id = "match_buttomleft">
                            <input type = "button" class = "button_match" id = "join" value = "我要参加" v-if="isjoin==0" @click="join_match">
                            <input type = "button" class = "button_match" id = "start-challenge" value = "开始挑战" v-if="isjoin==1" @click="start_match">
                        </div>
			        </div>
                    <div id = "match_rank">
                    </div>
                </div>
            </div>
        </div>
	</div>
</template>

<script>
import Navigation from "../components/Navigation.vue"
export default {
    name: 'mainpage',
	data: function(){
		return{
			student_id: 0,//学生id
            student_name: '',//学生姓名
            coins: 0,//当前学生拥有的金币数
            enable_daka:0,
            daka_num:0,
            coin_rank:{},//金币排行榜字典
            word_rank:{},//单词书排行榜字典
            point_rank:{},//积分排行榜字典
            test:{},
            button1:true,
            button2:true,
            button3:true,
            button4:true,
            show:false,//显示右边主体框
            show_study:false,//显示学习页面
            show_statistics:false,//显示学习统计页面
            show_xueqian:false,//显示学前测试进入页面
            show_books:false,//显示课程课本选择页面
            show_word_book:false,//显示单词书页面
            show_test:false,//显示学前测试页面
            show_match:false,//显示全部比赛信息页面
            show_match_detail:false,//显示比赛详细信息页面
            show_gonggu:false,
            tests_type:{},//测试类型的字典
            tests_grade:{},//测试类型对应的测试分数的字典
            books:{},
            words:{},//学生单词本的字典
            word_length:0,//学生单词本单词的总共数量
            start_index:0,
            test_select:{},//测试页面学生做的选项
            test_timu:{},//测试题数据
            test_index:0,//判断当前测试页面显示的题号
            commit:{},//学生参加的单词比赛
            uncommit:{},//学生未参加的单词比赛
            word_numbers:0,
            study_status:0,//记录学生学习状态，用来判断是否进行学前测试、学后测试
            now_book_id:0,//当前学习的书本id
            now_book_name:'',//当前学习的书本名字
            now_book_unit:{},//当前学习书的单元情况
            before_grade:0,//学前测试的成绩
            after_grade:0,//学后测试的成绩
            course_name:'',//学生上的课程名字
            word_order:'familiarity',//单词书单词排序的类别
            show_time:180,
            time_id:0,
            match_detail_message:{},//比赛详细页面的信息
            isjoin:0,//判断可以参加比赛
            percentage:0,
		}
    },
    // beforeCreate(){
	// 	//未登录，跳转到登录界面
	// 	if(this.$store.state.student_id==""){
	// 		window.location = "login.html"
	// 	}
	// },
	// created(){
	// 	this.student_id = parseInt(this.$store.state.student_id)
    //     this.student_name = this.$store.state.student_name
    //     this.coins = parseInt(this.$store.state.coins)
    //     this.enable_daka = parseInt(this.$store.state.enable_daka)
    //     this.daka_num = parseInt(this.$store.state.daka_num)
	// 	window.console.log(this.student_id)
    //     window.console.log(this.student_name)
	// },
	methods: {
        daka:function(){
            let that = this
            let param = new URLSearchParams
            param.append('student_id',this.student_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/daka',
                data:param,
            }).then(function(response){
                window.console.log(response)
                that.daka_num = response.data.daka_num
                that.coins = response.data.coins
                that.enable_daka =response.data.enable_daka
                let daka_num = that.daka_num
                let coins = that.coins
                let enable_daka = that.enable_daka
                that.$store.dispatch('daka',{daka_num,coins,enable_daka})
            })
        },
        check_familiarity:function(){
            if(this.time_id!=0){
                clearInterval(this.time_id)//防止点击其他页面时计时还在继续
                this.time_id = 0
                this.show_time = 180
            }
            this.show = true
            this.show_study = false
            this.show_xueqian = false
            this.show_statistics = false
            this.show_books = false
            this.show_test = false
            this.show_match = false
            this.show_match_detail = false
            this.show_gonggu = false
            this.start_index = 0
            // 更改button样式
            this.button1 = true
            this.button2 = true
            this.button3 = false
            this.button4 = true
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
                that.word_length = Object.keys(that.words).length
                that.show_word_book = true
            })
        },
        check_letter:function(){
            if(this.time_id!=0){
                clearInterval(this.time_id)//防止点击其他页面时计时还在继续
                this.time_id = 0
                this.show_time = 180
            }
            this.show = true
            this.show_study = false
            this.show_xueqian = false
            this.show_statistics = false
            this.show_books = false
            this.show_test = false
            this.show_match = false
            this.show_match_detail = false
            this.show_gonggu = false
            this.start_index = 0
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
        pre_group:function(){
            if(this.time_id!=0){
                clearInterval(this.time_id)//防止点击其他页面时计时还在继续
                this.time_id = 0
                this.show_time = 180
            }
            this.show = true
            this.show_study = false
            this.show_xueqian = false
            this.show_statistics = false
            this.show_books = false
            this.show_test = false
            this.show_match = false
            this.show_match_detail = false
            this.show_gonggu = false
            this.show_word_book = true
            this.start_index -= 12
        },
        next_group:function(){
            if(this.time_id!=0){
                clearInterval(this.time_id)//防止点击其他页面时计时还在继续
                this.time_id = 0
                this.show_time = 180
            }
            this.show = true
            this.show_study = false
            this.show_xueqian = false
            this.show_statistics = false
            this.show_books = false
            this.show_test = false
            this.show_match = false
            this.show_match_detail = false
            this.show_gonggu = false
            this.show_word_book = true
            this.start_index += 12
        },
        mybooks:function(){
            if(this.time_id!=0){
                clearInterval(this.time_id)//防止点击其他页面时计时还在继续
                this.time_id = 0
                this.show_time = 180
            }
            this.show = true
            this.show_study = false
            this.show_xueqian = false
            this.show_statistics = false
            this.show_word_book = false
            this.show_test = false
            this.show_match = false
            this.show_match_detail = false
            this.show_gonggu = false
            // 更改button样式
            this.button1 = false
            this.button2 = true
            this.button3 = true
            this.button4 = true
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
        gostudy:function(key){
            let book_id = this.now_book_id
            let study_unit = key
            this.$store.dispatch('unit',{study_unit,book_id})
            window.location = 'study.html'
        },
        study:function(book_id,book_name){
            if(this.time_id!=0){
                clearInterval(this.time_id)//防止点击其他页面时计时还在继续
                this.time_id = 0
                this.show_time = 180
            }
            this.show = true
            this.show_books = false
            this.show_statistics = false
            this.show_xueqian = false
            this.show_word_book = false
            this.show_test = false
            this.show_match = false
            this.show_match_detail = false
            this.show_gonggu = false
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
            let param1 = new URLSearchParams
            param1.append('student_id',this.student_id)
            param1.append('book_id',this.now_book_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/unit',
                data:param1,
            }).then(function(response){
                window.console.log(response)
                that.now_book_unit = response.data
            })
            let param2 = new URLSearchParams
            param2.append('student_id',this.student_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/beforetestgrade',
                data:param2,
            }).then(function(response){
                window.console.log(response)
                that.before_grade = response.data.grade
            })
            let param3 = new URLSearchParams
            param3.append('book_id',this.now_book_id)
            param3.append('student_id',this.student_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/percentage',
                data:param3,
            }).then(function(response){
                that.percentage = response.data['fanchart']
            })
        },
        goxueqian:function(){
            if(this.time_id!=0){
                clearInterval(this.time_id)//防止点击其他页面时计时还在继续
                this.time_id = 0
                this.show_time = 180
            }
            this.show = true
            this.show_xueqian = true
            this.show_study = false
            this.show_statistics = false
            this.show_books = false
            this.show_word_book = false
            this.show_test = false
            this.show_match = false
            this.show_match_detail = false
            this.show_gonggu = false
        },
        statistics:function(){
            this.chartData = {
                columns: ['日期', '单词数'],
                rows: [
                  { '日期': '1月1日', '单词数': 123 },
                  { '日期': '1月2日', '单词数': 1223 },
                  { '日期': '1月3日', '单词数': 2123 },
                  { '日期': '1月4日', '单词数': 4123 },
                  { '日期': '1月5日', '单词数': 3123 },
                  { '日期': '1月6日', '单词数': 7123 }
                ]
            }
            this.pieData = {
                columns: ['日期','时间'],
                rows: [
                  { '日期': '1月1日', '时间':12},
                  { '日期': '1月2日', '时间':122},
                  { '日期': '1月3日', '时间':212},
                  { '日期': '1月4日', '时间':412},
                  { '日期': '1月5日', '时间':312},
                  { '日期': '1月6日', '时间':712}
                ]
            }
            this.pie_settings = {
                limitShowNum: 5
            }
            if(this.time_id!=0){
                clearInterval(this.time_id)//防止点击其他页面时计时还在继续
                this.time_id = 0
                this.show_time = 180
            }
            this.show = true
            this.show_statistics = true
            this.show_study = false
            this.show_xueqian = false
            this.show_books = false
            this.show_word_book = false
            this.show_test = false
            this.show_match = false
            this.show_match_detail = false
            this.show_gonggu = false
            // 更改button样式
            this.button1 = true
            this.button2 = false
            this.button3 = true
            this.button4 = true
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
        starttest:function(){
            let that = this
            this.show = true
            this.show_statistics = false
            this.show_study = false
            this.show_xueqian = false
            this.show_books = false
            this.show_word_book = false
            this.show_match = false
            this.show_match_detail = false
            this.show_gonggu = false
            let param = new URLSearchParams
            param.append('student_id',this.student_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/testall',
                data:param,
            }).then(function(response){
                that.test_timu = response.data
                that.test_index = 0
                that.show_test = true
                that.time_id = setInterval(that.clock,1000)
                window.console.log(that.time_id)
            })
        },
        clock:function(){
            if(this.show_time>0){
                this.show_time -= 1
            }else{
                clearInterval(this.time_id)
                this.time_id = 0
                this.show_time = 180
                window.alert('测试时间到')
                let count = 0
                for(let item in this.test_select){
                    if(this.test_select[item] == this.test_timu[item].correct){
                        count++
                    }
                }
                this.before_grade = parseInt((count/28)*100)
                this.test_index = 0
                this.study_status = 2
                this.show = true
                this.show_study = true
                this.show_statistics = false
                this.show_xueqian = false
                this.show_books = false
                this.show_word_book = false
                this.show_test = false
                this.show_match = false
                this.show_match_detail = false
                this.show_gonggu = false
                let param = new URLSearchParams
                param.append('student_id',this.student_id)
                param.append('test_grade',this.before_grade)
                param.append('test_type',1)
                this.$axios({
                    method:'post',
                    url:'http://localhost:8000/app/inputtest',
                    data:param,
                }).then(function(response){
                    window.console.log(response)
                    if(response.data.status=='succeed'){
                        window.alert('恭喜你，测试完成')
                    }
                })
            }
        },
        commit_test:function(){
            let message = '确定提交吗？'
            if(window.confirm(message)==true){
                let that = this
                let count = 0
                let i = 1
                let length = Object.keys(this.test_select).length
                //判断是否有空选项
                if(length!=28){
                    window.alert('你还有选项未选择')
                    return
                }
                while(i<=length){
                    if(this.test_select[i]==this.test_timu[i].correct){
                        count++
                    }
                    i++
                }
                clearInterval(this.time_id)//已经提交答案，停止倒计时
                this.time_id = 0
                this.show_time = 180
                that.test_index = 0
                this.before_grade = parseInt((count/28)*100)
                this.show = true
                this.show_study = true
                this.show_statistics = false
                this.show_xueqian = false
                this.show_books = false
                this.show_word_book = false
                this.show_test = false
                this.show_match = false
                this.show_match_detail = false
                this.show_gonggu = false
                let param = new URLSearchParams
                param.append('student_id',this.student_id)
                param.append('test_grade',this.before_grade)
                if(this.study_status==1){
                    param.append('test_type',this.study_status)
                    this.study_status = 2
                }else if(this.study_status==3){
                    param.append('test_type',this.study_status)
                }
                this.$axios({
                    method:'post',
                    url:'http://localhost:8000/app/inputtest',
                    data:param,
                }).then(function(response){
                    window.console.log(response)
                    if(response.data.status=='succeed'){
                        window.alert('恭喜你，测试完成')
                        that.test_select = {}
                        that.test_timu = {}
                    }
                })
            }
        },
        commit_test_gonggu:function(){
            let message = '确定提交吗？'
            if(window.confirm(message)==true){
                let that = this
                let count = 0
                let i = 1
                let length = Object.keys(this.test_select).length
                //判断是否有空选项
                if(length!=10){
                    window.alert('你还有选项未选择')
                    return
                }
                while(i<=length){
                    if(this.test_select[i]==this.test_timu[i].correct){
                        count++
                    }
                    i++
                }
                clearInterval(this.time_id)//已经提交答案，停止倒计时
                this.time_id = 0
                this.show_time = 180
                that.test_index = 0
                let grade = parseInt((count/10)*100)
                this.show = true
                this.show_study = true
                this.show_statistics = false
                this.show_xueqian = false
                this.show_books = false
                this.show_word_book = false
                this.show_test = false
                this.show_match = false
                this.show_match_detail = false
                this.show_gonggu = false
                let param = new URLSearchParams
                param.append('student_id',this.student_id)
                param.append('test_grade',this.before_grade)
                param.append('test_type',this.study_status)
                this.$axios({
                    method:'post',
                    url:'http://localhost:8000/app/inputtest',
                    data:param,
                }).then(function(response){
                    window.console.log(response)
                    if(response.data.status=='succeed'){
                        window.alert('恭喜你，测试完成,测试分数：'+grade)
                        that.test_select = {}
                        that.test_timu = {}
                    }
                })
            }
        },
        next_page:function(){
            this.test_index += 4
        },
        pre_page:function(){
            this.test_index -= 4
        },
        match:function(){
            if(this.time_id!=0){
                clearInterval(this.time_id)//防止点击其他页面时计时还在继续
                this.time_id = 0
                this.show_time = 180
            }
            this.show = true
            this.show_study = false
            this.show_statistics = false
            this.show_xueqian = false
            this.show_books = false
            this.show_word_book = false
            this.show_test = false
            this.show_match_detail = false
            this.show_match = true
            this.show_gonggu = false
            // 更改button样式
            this.button1 = true
            this.button2 = true
            this.button3 = true
            this.button4 = false
            let that = this
            let param = new URLSearchParams
            param.append('student_id',this.student_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/match',
                data:param
            }).then(function(response){
                window.console.log(response)
                that.commit = response.data.commit
                that.uncommit = response.data.uncommit
                window.console.log(that.commit)
                window.console.log(that.uncommit)
            })
        },
        match_detail:function(match_id){
            this.$store.dispatch('match',match_id)
            this.show = true
            this.show_statistics = false
            this.show_study = false
            this.show_xueqian = false
            this.show_books = false
            this.show_word_book = false
            this.show_match = false
            this.show_test = false
            this.show_gonggu = false
            let that = this
            let param = new URLSearchParams
            param.append('match_id',match_id)
            param.append('student_id',this.student_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/matchmessage',
                data:param,
            }).then(function(response){
                window.console.log(response)
                that.match_detail_message = response.data
                that.isjoin = response.data['match_detail'].isjoin
                window.console.log(that.isjoin)
                that.show_match_detail = true
            })
        },
        join_match:function(){
            let message = '确认参加吗？'
            if(window.confirm(message)==true){
                let match_id = parseInt(this.$store.state.match_id)
                let that = this
                let param1 = new URLSearchParams
                param1.append('match_id',match_id)
                this.$axios({
                    method:'post',
                    url:'http://localhost:8000/app/enablejoin',
                    data:param1
                }).then(function(response){
                    if(response.data['enable_join']==0){
                        window.alert('对不起，比赛时间已过！')
                    }else if(response.data['enable_join']==1){
                        window.alert('对不起，比赛时间还没到！')
                    }else{
                        let param = new URLSearchParams
                        param.append('student_id',that.student_id)
                        param.append('match_id',match_id)
                        that.$axios({
                            method:'post',
                            url:'http://localhost:8000/app/joinmatch',
                            data:param,
                        }).then(function(response){
                            window.console.log(response)
                            if(response.data['status'] == 'succeed'){
                                window.alert('加入比赛成功')
                                that.isjoin = 1
                            }
                        })
                    }
                })
            }
        },
        start_match:function(){
            let message = '确认立刻开始挑战吗？'
            if(window.confirm(message)==true){
                let match_id = parseInt(this.$store.state.match_id)
                let that = this
                let on = false
                let param1 = new URLSearchParams
                param1.append('match_id',match_id)
                this.$axios({
                    method:'post',
                    url:'http://localhost:8000/app/enablejoin',
                    data:param1
                }).then(function(response){
                    if(response.data['enable_join']==0){
                        window.alert('对不起，比赛时间已过！')
                    }else if(response.data['enable_join']==1){
                        window.alert('对不起，比赛时间还没到！')
                    }else{
                        window.location = 'match.html'
                    }
                })
            }
        },
        gonggu:function(){
            this.show = true
            this.show_study = false
            this.show_statistics = false
            this.show_xueqian = false
            this.show_books = false
            this.show_word_book = false
            this.show_test = false
            this.show_match = false
            this.show_match_detail = false
            let that = this
            let param = new URLSearchParams
            param.append('student_id',this.student_id)
            param.append('book_id',this.now_book_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/gonggutest',
                data:param,
            }).then(function(response){
                window.console.log(response)
                that.test_timu = response.data
                that.show_gonggu = true
            })
        },
        xuehou:function(){
            let message = '确定参加学后测试吗？'
            this.show = true
            this.show_study = false
            this.show_statistics = false
            this.show_xueqian = false
            this.show_books = false
            this.show_word_book = false
            this.show_match = false
            this.show_match_detail = false
            this.show_gonggu = false
            if(window.confirm(message)==true){
                let that = this
                let param = new URLSearchParams
                param.append('student_id',this.student_id)
                this.$axios({
                    method:'post',
                    url:'http://localhost:8000/app/testall',
                    data:param,
                }).then(function(response){
                    window.console.log(response)
                    that.test_timu = response.data
                    that.show_test = true
                    that.show_time = 180
                    that.time_id = setInterval(that.clock,1000)
                })
            }
        },
    },
    components: {
        Navigation,
    }
}
</script>

<style scoped>

table{
    border: 1px;
    text-align: center;
}

/* 主体部分 */
#main {
    display: flex;
    width: 1200px;
    height: 700px;
    margin: 100px auto;
    overflow-x: hidden;
    overflow-y: hidden;
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
    background-color: #ffffff;
    display: flex;
    flex-wrap: wrap;
    align-content: flex-start;

}
/* 左下角部分 */
#buttom-left {
    width: 300px;
    height: 280px;
    background-color: #ffffff;
    text-align: center;
}

.headportraitStyle {
    width: 35px;
    height: 35px;
    margin: 15px 8px 5px 5px;
}
/* 我爱背单词 */
.h3headStyle {
    width: 94px;
}

#h3head {
    margin: 20px 5px 20px 5px;
}
h3 {
    margin: 0;
}

/* 我的金币 */
.p1Style {
    margin: 5px;
    width: 120px;
}
.p2Style {
    margin-left: 40px;
}
/* 打卡按钮 */
.clockOnStyle1 {
    height: 40px;
    background-color: rgb(16, 150, 190); /* Green */
    border: none;
    border-radius: 8px;
    color: white;
    padding: 7px 12px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin-top: 5px;
    margin-left: 30px;
    outline: none;

}
.clockOnStyle2 {
    height: 40px;
    background-color: rgb(214, 201, 18); /* Green */
    border: none;
    border-radius: 8px;
    color: white;
    padding: 7px 12px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin-top: 5px;
    margin-left: 30px;
    outline: none;

}


/*按钮样式*/
.select1 {
    background-color: rgba(223, 215, 215, 0.658); 
    width: 200px;
    margin-top: 10px;
    border-radius: 4px; 
    color: black;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    border: none;
}
.select2{
    background-color:  rgba(93, 255, 115, 0.842);
    color:rgb(255, 255, 255);
    width: 200px;
    margin-top: 10px;
    border-radius: 4px; 
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    border: none;
}

#right {
    margin-left: 50px;
    width: 850px;
    height: 700px;
    background-color: #ffffff;
    position: relative;

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
    text-align: center;
    background-color: rgb(216, 191, 116);
    float: left;
    
}
.gostudy1{
    display:block;
    margin:0 auto;
    width: 100px;
    height: 40px;
    font-size: 14px;
    color: white;
    border: none;
    border-radius: 4px;
    background: inherit;
    background-color: #1890FF;
}
.gostudy2{
    display:block;
    margin:0 auto;
    width: 100px;
    height: 40px;
    font-size: 14px;
    color: white;
    border: none;
    border-radius: 4px;
    background: inherit;
    background-color: rgb(130, 132, 134);
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
    color: white;
    border: none;
    border-radius: 4px;
    background: inherit;
    background-color: #1890FF;
    margin-left: 550px;
}
/* 第一行文字及标签 */
#box1 {
    width: 850px;
    height: 50px;
    display: flex;
    margin-top: 50px;
    margin-left: 0;
}
#word1 {
    font-size: 18px;
    margin-left: 50px;
    display: block;
}
#before-study {
    font-size: 18px;
    margin-left: 200px;
}
#after-study {
    font-size: 18px;
    margin-left: 20px;
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
    height: 45px;
    font-size: 14px;
    color: white;
    border: none;
    border-radius: 4px;
    background: inherit;
    background-color: #1890FF;
    position: relative;
    left: 100px;
}
/* 第三行内容 */
#box3 {
    width: 500px;
    height: 200px;
    margin: auto;
    text-align: center;
}

.not_finish{
    width: 70px;
    height: 70px;
    border: none;
    font-size: 20px;
    border-radius: 50%;
    background: inherit;
    background-color:#e21c1c;
    margin-left: 20px;
    margin-top: 20px;
    color: white;
}
.finish{
    width: 70px;
    height: 70px;
    border: none;
    font-size: 20px;
    border-radius: 50%;
    background: inherit;
    background-color:rgb(97, 216, 41);
    margin-left: 20px;
    margin-top: 20px;
    color: white;
}
/* 教材和当前学习单词书页面CSS结束 */

/* 单词书页面CSS开始 */
/* 上方框 */
#top-box {
    width: 100%;
    height: 50px;
    display: flex;
}

#order {
    font-size: 16px;
    font-weight: bold;
    margin: 0;
    padding-left: 30px;
    padding-top: 20px;
}

.review-mode{
    width: 90px;
    height: 50px;
    font-size: 16px;
    padding-top: 20px;
    margin-left: 30px;
}

.color {
    width: 15px;
    height: 15px;
    border-radius: 50%;
    margin-top: 20px;
}

#red {
    background-color: rgb(238,100,100);
    margin-left: 230px;
}


#blue {
    background-color: #3CE9E9;
    margin-left: 40px;
}

#green {
    background-color: #6CE076;
    margin-left: 40px;
}

.proficiency {
    font-size: 16px;
    padding-left: 10px;
}

/* 下方框 */
#buttom-box {
    width: 100%;
    height: 600px;
    display: flex;
    flex-wrap: wrap;
    align-content: flex-start;
}

.button-color {
    margin-left: 40px;
    margin-top: 40px;
    width: 191px;
    height: 100px;
    background: #ffffff;
    border-radius: 10px;
    outline: none;
}

#button-red {
    border: 1.5px solid rgb(238,100,100);
    box-shadow: inset 0px -5px rgb(238,100,100);
}

#button-blue {
    border: 1.5px solid #3CE9E9;
    box-shadow: inset 0px -5px #3CE9E9;
}
#button-green {
    border: 1.5px solid #6CE076;
    box-shadow: inset 0px -5px #6CE076;
}

#pre_group{
    width: 150px;
    height: 40px;
    font-size: 14px;
    color: white;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    background-color: #1890FF;
    position: absolute;
    top: 630px;
    left: 480px;
}
#next_group {
    width: 150px;
    height: 40px;
    font-size: 14px;
    color: white;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    background-color: #1890FF;
    position: absolute;
    top: 630px;
    left: 670px;
}
#div1{
    width: 235px;
    height: 150px;
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
    position: absolute;
    top: 550px;
    left: 350px;
}
#next-page {
    width: 150px;
    height: 40px;
    font-size: 14px;
    color: white;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    background-color: #1890FF;
    position: absolute;
    top: 630px;
    left: 670px;
}
#last-page {
    width: 150px;
    height: 40px;
    font-size: 14px;
    color: white;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    background-color: #1890FF;
    position: absolute;
    top: 630px;
    left: 480px;
}

/* 学前测试页面CSS结束 */

/* 所有比赛信息页面CSS开始 */
#my_match1{
    background-color: #D3D3D3;
    float: left;
    width: 300px;
    height: 275px;
}

/* 上方框 */
#match-box1{
    width: 100%;
    height: 260px;
    display: flex;
}

#time-picture {
    margin-left: 250px;
    margin-top: 10px;
}

#count-down {
    font-size: 16px;
    position: relative;
    bottom: 20px;
}


/* 参加的比赛框 */
.match {
    width: 300px;
    height: 155px;
    margin-top: 50px;
    margin-left: 50px;
    background-color: rgb(212, 211, 209);
}
.title {
    font-size: 30px;
    font-weight: bold;
    margin: 0;
    padding-left: 30px;
    padding-top: 30px;
}

/* 第一行 */
#first-box {
    width: 300px;
    height: 40px;
    display: flex;
}

.words {
    font-size: 16px;
}

#words1 {
    padding-left: 5px;
}

#words3 {
    color: #0096FA;
    padding-left: 170px;
}

#words4 {
    text-align: center;
}

#words5 {
    text-align: center;
}

/* 最后一行内容 */
#third-box {
    margin-top: 40px;
    width: 300px;
    height: 45px;
    display: flex;
}

#words7 {
    margin: 0;
    padding-left: 100px;
}

#detail {
    color: #0096FA;
    padding-left: 30px;
    font-size: 16px;
}

/* 下方框 */
#match-box2{
    width: 100%;
    height: 260px;
    display: flex;
}

/* 第一行 */
#forth-box {
    width: 300px;
    height: 40px;
    display: flex;
}

#words8 {
    padding-left: 5px;
}

#words9 {
    padding-left: 50px;
}

#words10 {
    color: #0096FA;
    padding-left: 150px;
}

#words11 {
    text-align: center;
}

#words12 {
    text-align: center;
}

/* 最后一行内容 */
#sixth-box {
    margin-top: 40px;
    width: 300px;
    height: 45px;
    display: flex;
}

#words14 {
    margin: 0;
    padding-left: 100px;
}
#word_number{
    text-align: center;
}
#title1 {
    text-align: center;
    font-weight: bold;
    font-size: xx-large;
}

#bake {
    width:800px;
    height:500px;
    border: 1px solid rgb(255, 252, 252);

}
.table{
    font-family: 微软雅黑;
	font-size: 16px;
	font-weight: bold;
	color: #020a11;
	background-color:#e9faff;
}

/* 比赛详细信息页面CSS开始 */
/* 右侧块中左侧部分 */
#match_div {
    width: 400px;
    height: 700px;
    float: left;
}
/* 右侧块中左上角部分 */
#match_topleft {
    width: 400px;
    height: 470px;
    padding-top: none;
	background-color: white;
}
/* 比赛的名字 */
#name {
    font-size: 20px;
    font-weight: bold;
    text-align: center;
    margin: 0;
}
/* 比赛介绍中的小标题*/
.title_match {
    font-size: 16px;
    font-weight: 600;
    padding-left: 30px;
}
/* 小标题下的内容 */
.text_match {
    font-size: 12px;
    padding-left: 30px;
}
/* 右侧块中的左下角部分*/
#match_buttomleft {
    width: 400px;
	height: 230px;
	background-color: white;
}
/* 下方两个按钮样式 */
.button_match {
	width: 200px;
	height: 50px;
    font-size: 16px;
    color: white;
    box-sizing: border-box;
    border-width: 1px;
    border-style: solid;
    border-radius: 30px;
    background: inherit;
	margin-top: 40px;
	margin-left: 100px;
}
#join {
	background-color: green;
}
#start-challenge {
	background-color: orange;
}
/* 右侧块中的右侧块 */
#match_rank {
	width: 450px;
	height: 700px;
	background-color: white;
    float: left;
}
/* 比赛详细信息页面CSS结束 */
#shabi {
    width: 850px;
    height: 720px;
}
.el-scrollbar {
    height: 100%;
    overflow-x: hidden;
}
#shabi .el-scrollbar .el-scrollbar__wrap {
    overflow-x: hidden;
    height: 100%;
}
.is-horizontal {
    display: none;
}
</style>
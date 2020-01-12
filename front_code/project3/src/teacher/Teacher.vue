<template>
    <div id="teachermain">
        <div id="header"></div>
        <div id="menu1" class="menu">
            <ul>
                <input type = "button" id="my_information" class="menu_1" value="我的信息">
                <input type = "button" class="option" value="个人信息" @click="goteacher_msg">
                <input type = "button" class="option" value="修改密码" @click="gorewrite_pwd">
                
                <input type = "button" id="study_management" class="menu_1" value="学习管理">
                <input type = "button" class="option" value="课程列表" @click="goteacher_classes">
                <input type = "button" class="option" value="学生名册" @click="goteacher_students">
                <input type = "button" class="option" value="学习统计" @click="goteacher_chart">
                <input type = "button" class="option" value="单词比赛" @click="goteacher_compete">

                <input type = "button" id="system_setup" class="menu_1" value="系统设置">
                <input type = "button" class="option" value="退出" @click="logout">
            </ul>
        </div>
        <div id="botton_list1" class="botton_list">
            <input type = "button" class="button1" value="个人面板" @click="goteacher_msg">
            <input type = "button" class="button1" value="学员面板" @click="goteacher_students">
            <input type = "button" class="button1" value="课程列表" @click="goteacher_classes">
            <input type = "button" class="button1" value="单词比赛" @click="goteacher_compete">
            <input type = "button" class="button1" value="学生名册" @click="goteacher_students">
            <input type = "button" class="button1" value="学习统计" @click="goteacher_chart">
        </div>
        <div id="msg_window" v-show="msg">
            <div id="window_header">
                个人信息
            </div>
            <div id="msg">
                <p>用户id：{{teacher_id}}</p>
                <p>用户名：{{teacher_username}}</p>
                <p>教师姓名：{{teacher_name}}</p>
                <p>教师性别：{{teacher_sex}}</p>
                <p>教师年龄：{{teacher_age}}</p>
                <p>教师电话：{{teacher_phone}}</p>
                <p>教师住址：{{teacher_address}}</p>
                <div>
                    <input type = "button" class="button1" id="sure" value="确定" @click="goteacher_classes">
                </div>
            </div>
        </div>
        <div id="msg_window" v-show="rewrite">
            <div id="window_header">
                修改密码
            </div>
            <div id="rewrite" style="text-align:center;">
                <div id="box1">
                    <span>请输入旧密码：</span>
                    <input type = "password" class = "input" id = "old_password" placeholder = "密码" v-model="old_password">
                </div>
                <div id="box1">
                    <span>请输入新密码：</span>
                    <input type = "password" class = "input" placeholder = "密码" v-model="new_password1">
                </div>
                <div id="box1">
                    <span>请确认新密码：</span>
                    <input type = "password" class = "input" placeholder = "密码" v-model="new_password2">
                </div>
                <!-- <input type = "button" id="sure" value="确定" @click="send_rewrite"> -->
                <el-button round id="sure" @click="send_rewrite">确定</el-button>
            </div>  
        </div>
        <div id="msg_window" v-show="classes">
            <div id="window_header">
                课程列表
            </div>
            <div id="botton_list2" class="botton_list">
                <el-button class="button2" icon="el-icon-plus" @click="goclasses_add">新增课程</el-button>
            </div>
            <div id="classes_add" v-show="classes_add">
                <el-input placeholder="请输入新增课程id" v-model="add_course_id" clearable maxlength="5" show-word-limit size="medium"></el-input>
                <el-input placeholder="请输入新增课程名称" v-model="add_course_name" clearable></el-input>
                <el-input placeholder="请输入课程单词书id" v-model="add_class_book_id" clearable></el-input>
                <el-button type="primary" @click="sure_classes_add">确定</el-button>
                <el-button type="primary" @click="cancel_classes_add">取消</el-button>
            </div>
            <div id="table_div">
                <table id="table-a">
                    <tr>
                        <th>课程id</th>
                        <th>课程名称</th>
                        <th>课程人数</th>
                        <th>操作</th>
                    </tr>
                    <tr v-for="(value,key,index) in course">
                        <td>{{value.course_id}}</td>
                        <td>{{value.course_name}}</td>
                        <td>{{value.course_student_number}}</td>
                        <td><el-button type="primary" @click="course_delete(value.course_id)">删除</el-button></td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="msg_window" v-show="compete">
            <div id="window_header">
                单词比赛
            </div>
            <div id="add_compete" v-show="add_compete">
                <el-input placeholder="请输入新增比赛id" v-model="add_compete_id" clearable maxlength="5" show-word-limit size="medium"></el-input>
                <el-input placeholder="请输入新增比赛名称" v-model="add_compete_name" clearable></el-input>
                <el-input placeholder="请输入新增比赛积分" v-model="add_compete_point" clearable></el-input>
                <el-input placeholder="请输入新增比赛单词id" type="textarea" v-model="add_words_id" clearable autosize></el-input>
                <el-button type="primary" @click="sure_compete_add">确定</el-button>
                <el-button type="primary" @click="cancel_compete_add">取消</el-button>
            </div>
            <div id="change_compete" v-show="change_compete">
                <el-input placeholder="请输入编辑比赛id" v-model="change_compete_id" clearable maxlength="5" show-word-limit size="medium"></el-input>
                <el-input placeholder="请输入编辑比赛名称" v-model="change_compete_name" clearable></el-input>
                <el-input placeholder="请输入编辑比赛积分" v-model="change_compete_point" clearable></el-input>
                <el-input placeholder="请输入编辑比赛单词id" type="textarea" v-model="change_words_id" clearable autosize></el-input>
                <el-button type="primary" @click="sure_compete_change">确定</el-button>
                <el-button type="primary" @click="cancel_compete_change">取消</el-button>
            </div>
            <div id="table_div">
                <table id="table-a">
                    <tr>
                        <th>比赛名称</th>
                        <th>发起人</th>
                        <th>状态</th>
                        <th>范围</th>
                        <th>参加人数</th>
                        <th>操作</th>
                    </tr>
                    <tr v-for="(value,key,index) in match">
                        <td>{{value.match_name}}</td>
                        <td>{{value.teacher_name}}</td>
                        <td>{{value.status}}</td>
                        <td>{{value.scope}}</td>
                        <td>{{value.join_number}}</td>
                        <td><el-button type="text" @click="gochange_compete">排名</el-button><el-button type="text" @click="gochange_compete">编辑</el-button></td>
                    </tr>
                </table>
            </div>
            <el-button type = "primary" id="new_compete" @click="goadd_compete">新建比赛</el-button> 
        </div>
        <div id="msg_window" v-show="show_student">
            <div id="window_header">
                学生名册
            </div>
            <div id="botton_list2" class="botton_list">
                <el-button class="button2" icon="el-icon-notebook-1" @click="gobook_add">开通教材</el-button>
                <el-button class="button2" icon="el-icon-user-solid" @click="gostudent_change">添加/删除学员</el-button>
            </div>
            <div id="book_add" v-show="book_add">
                <el-input placeholder="请输入教材id" v-model="add_book_id" clearable maxlength="10" show-word-limit size="medium"></el-input>
                <el-input placeholder="请输入学生id" v-model="book_student_id" clearable maxlength="7"></el-input>
                <el-button type="primary" @click="sure_book_add">确定</el-button>
                <el-button type="primary" @click="cancel_book_add">取消</el-button>
            </div>
            <div id="students_change" v-show="students_change">
                <el-input placeholder="请输入学生id" v-model="students_change_id" clearable maxlength="7" show-word-limit size="medium"></el-input>
                <el-button type="primary" @click="student_add">添加</el-button>
                <el-button type="primary" @click="student_delete">删除</el-button>
                <el-button type="primary" @click="cancel_students_change">取消</el-button>
            </div>
            <div id="table_div">
                <table id="table-b">
                    <tr>
                        <th>姓名</th>
                        <th>邮箱</th>
                        <th>金币数量</th>
                        <th>上次登录</th>
                        <th>学生id</th>
                        <th>班级名称</th>
                        <th>注册日期</th>
                        <th>状态</th>
                    </tr>
                    <tr v-for="(value,key,index) in students">
                        <td>{{value.student_name}}</td>
                        <td>{{value.email}}</td>
                        <td>{{value.coins}}</td>
                        <td>{{value.last_login}}</td>
                        <td>{{value.student_id}}</td>
                        <td>{{value.course_name}}</td>
                        <td>{{value.register_time}}</td>
                        <td>{{value.status}}</td>
                    </tr>
                </table>
            </div>
            <!--<template>
                <el-table ref="multipleTable" :data="studentsdata" stripe align="left" max-height="900" border style="width: 100%" id="studentsdata" :header-cell-style="tableHeaderColor">
                    <el-table-column prop="student_name" label="姓名"></el-table-column>
                    <el-table-column prop="email" label="邮箱"></el-table-column>
                    <el-table-column prop="coins" label="金币数量"></el-table-column>
                    <el-table-column prop="last_login" label="上次登录"></el-table-column>
                    <el-table-column prop="student_id" label="学生id"></el-table-column>
                    <el-table-column prop="course_name" label="班级名称"></el-table-column>
                    <el-table-column prop="register_time所在组" label="所在组"></el-table-column>
                    <el-table-column prop="" label="注册日期"></el-table-column>
                    <el-table-column prop="status" label="状态"></el-table-column>
                </el-table>
            </template>-->    
        </div>
        <div id="msg_window" v-show="charts">
            <div id="window_header">
                学习统计
            </div>
            <div id="charts" style="text-align:center;">
                <h2 id="word_number">最近一周内单词学习情况图表</h2>
                <ve-histogram :data="chartData" width="1260px"></ve-histogram>
            </div>  
        </div>
    </div>
</template>

<script>

export default {
	name: 'teachermain',
    data() {
        return {
            teacher_id: 0,
            teacher_username: '',
            teacher_name: '',
            teacher_sex: '',
            teacher_age: 0,
            teacher_phone: '',
            teacher_address: '',
            old_password: '',
            new_password1: '',
            new_password2: '',
            msg:false,
            rewrite:false,
            classes:true,
            classes_add:false,
            compete:false,
            add_compete:false,
            show_student:false,
            book_add:false,
            students_change:false,
            change_compete:false,
            charts:false,
            course:{},
            match:{},
            students:{},
            add_course_id:'',
            add_course_name:'',
            add_class_book_id:'',
            delete_class_id:'',
            add_compete_id:'',
            add_compete_name:'',
            add_compete_point:'',
            add_words_id:'',
            change_compete_id:'',
            change_compete_name:'',
            change_compete_point:'',
            change_words_id:'',
            add_book_id:'',
            book_student_id:'',
            students_change_id:'',
        }
    },/*
    beforeCreate(){
		//未登录，跳转到登录界面
		if(this.$store.state.teacher_id==""){
			window.location = "login.html"
		}
	},*/
	created(){
        this.teacher_id = parseInt(this.$store.state.teacher_id)
        this.teacher_username = this.$store.state.teacher_username
        let that = this
        let param = new URLSearchParams
        param.append('teacher_id',this.teacher_id)
        this.$axios({
            method:'post',
            url:'http://localhost:8000/app/courselist',
            data:param,
        }).then(function(response){
            window.console.log(response)
            that.course = response.data
            window.console.log(that.course)
        })
        this.msg=false
        this.rewrite=false
        this.classes=true
        this.compete=false
        this.show_student=false
        this.chartData = {
            columns: ['日期', '单词数'],
            rows: [
              { '日期': '1月6日', '单词数': 1 },
              { '日期': '1月7日', '单词数': 6 },
              { '日期': '1月8日', '单词数': 10 },
              { '日期': '1月9日', '单词数': 11 },
              { '日期': '1月11日', '单词数': 12 },
              { '日期': '1月12日', '单词数': 20 },
              { '日期': '1月13日', '单词数': 40 }
            ]
        }
	},
	methods: {
        send_rewrite: function(){
            if(this.old_password=='' || this.new_password1=='' || this.new_password2==''){
                window.alert('密码不能为空，请重新输入')
                this.old_password = ''
                this.new_password1 = ''
                this.new_password2 = ''
            }else if(this.old_password==this.new_password1){
                window.alert('新密码不能和旧密码相同')
                this.old_password = ''
                this.new_password1 = ''
                this.new_password2 = ''
            }else if(this.new_password1!=this.new_password2){
                window.alert('两次输入的新密码不相同，请重新输入')
                this.old_password = ''
                this.new_password1 = ''
                this.new_password2 = ''
            }else if(this.new_password1==this.new_password2){
                let message = '确认更改密码吗？'
                if(window.confirm(message)==true){
                    let that = this
                    let param = new URLSearchParams()
                    param.append('teacher_id',this.teacher_id)
                    param.append('old_password',this.old_password)
                    param.append('new_password',this.new_password1)
                    window.console.log(this.old_password)
                    window.console.log(this.new_password1)
                    this.$axios({
                        method:'post',
                        url:'http://localhost:8000/app/teacherchangepassword',
                        data:param,
                    }).then(function(response){
                        if(response.data['change_status']=='succeed'){
                            that.rewrite_success()
                            that.old_password = ''
                            that.new_password1 = ''
                            that.new_password2 = ''
                        }
                        else if(response.data['change_status']=='failed'){
                            that.rewrite_failed()
                            that.old_password = ''
                            that.new_password1 = ''
                            that.new_password2 = ''
                        }
                    })
                }
            }
        },
        rewrite_success() {
            this.$message({
                showClose: true,
                message: '修改成功',
                type: 'success'
            });
        },
        rewrite_failed() {
            this.$message({
                showClose: true,
                message: '旧密码输入错误',
                type: 'error'
            });
        },
		logout:function() {
            this.$store.dispatch("TeacherLogout")
            this.$store.dispatch("Logout")
			window.location = "login.html"
        },
        goteacher_msg:function() {
            let that = this
            let param = new URLSearchParams
            param.append('teacher_id',this.teacher_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/teachermessage',
                data:param,
            }).then(function(response){
                that.teacher_username = response.data.teacher_username
                that.teacher_name = response.data.teacher_name
                that.teacher_sex = response.data.teacher_sex
                that.teacher_age = response.data.teacher_age
                that.teacher_phone = response.data.teacher_phone
                that.teacher_address = response.data.teacher_address
            })
            this.msg=true
            this.rewrite=false
            this.classes=false
            this.compete=false
            this.show_student=false
            this.charts=false
        },
        gorewrite_pwd:function(){
            this.msg=false
            this.rewrite=true
            this.classes=false
            this.compete=false
            this.show_student=false
        },
        goteacher_classes:function(){
            let that = this
            let param = new URLSearchParams
            param.append('teacher_id',this.teacher_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/courselist',
                data:param,
            }).then(function(response){
                window.console.log(response)
                that.course = response.data
            })
            this.msg=false
            this.rewrite=false
            this.classes=true
            this.compete=false
            this.show_student=false
            this.charts=false
        },
        goclasses_add:function() {
            this.classes_add=true
        },
        sure_classes_add() {
            if(this.add_course_id==''||this.add_course_name==''||this.add_class_book_id==''){
                window.alert('输入内容不能为空')
            }else{
                let message = '确定添加课程吗？'
                if(window.confirm(message)==true){
                    let that = this
                    let param = new URLSearchParams()
                    param.append('teacher_id',this.teacher_id)
                    param.append('course_id',this.add_course_id)
                    param.append('course_name',this.add_course_name)
                    param.append('book_id',this.add_class_book_id)
                    this.$axios({
                        method:'post',
                        url:'http://localhost:8000/app/opencourse',
                        data:param,
                    }).then(function(response){
                        window.console.log(response)
                        if(response.data['status']=='succeed'){
                            that.add_success()
                            that.classes_add=false
                            window.location = 'teacher.html'
                        }
                        else if(response.data.add_course_status=='failed'){
                            that.add_failed()
                        }
                    })
                }
            }
        },
        cancel_classes_add() {
            this.classes_add=false
        },
        add_success() {
            this.$message({
                showClose: true,
                message: '添加成功',
                type: 'success'
            });
        },
        add_failed() {
            this.$message({
                showClose: true,
                message: '添加错误',
                type: 'error'
            });
        },
        course_delete:function(courseid){
            window.console.log(courseid)
            let message = '确认删除课程吗？'
            if(window.confirm(message)==true){
                let that = this
                let param = new URLSearchParams
                param.append('course_id',courseid)
                param.append('teacher_id',this.teacher_id)
                this.$axios({
                    method:'post',
                    url:'http://localhost:8000/app/deletecourse',
                    data:param,
                }).then(function(response){
                    if(response.data['status']=='succeed'){
                        that.delete_success()
                        window.location = 'teacher.html'
                    }else{
                        that.delete_failed()
                        window.location = 'teacher.html'
                    }
                })
            }
        },
        delete_success() {
            this.$message({
                showClose: true,
                message: '删除成功',
                type: 'success'
            });
        },
        delete_failed() {
            this.$message({
                showClose: true,
                message: '服务器异常，请稍后重试',
                type: 'error'
            });
        },
        goteacher_students:function(){
            let that = this
            let param = new URLSearchParams
            param.append('teacher_id',this.teacher_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/studentlist',
            }).then(function(response){
                window.console.log(response)
                that.students = response.data
            })
            this.msg=false
            this.rewrite=false
            this.classes=false
            this.compete=false
            this.show_student=true
            this.charts=false
        },
        gobook_add(){
            this.book_add=true
        },
        sure_book_add() {
            let message = '确认开通课程吗？'
            if(window.confirm(message)==true){
                let that = this
                let param = new URLSearchParams()
                param.append('book_id',this.add_book_id)
                param.append('student_id',this.book_student_id)
                this.$axios({
                    method:'post',
                    url:'http://localhost:8000/app/openbook',
                    data:param,
                }).then(function(response){
                    window.console.log(response)
                    if(response.data.status=='succeed'){
                        that.add_success()
                        that.book_add=false
                    }
                    else {
                        that.add_failed()
                    }
                })
            }
        },
        cancel_book_add() {
            this.book_add=false
        },
        gostudent_change() {
            this.students_change=true
        },
        student_add() {
            let that = this
			let param = new URLSearchParams()
			param.append('student_id',this.students_change_id)
			this.$axios({
				method:'post',
				url:'http://localhost:8000/app/',
				data:param,
			}).then(function(response){
                window.console.log(response)
                window.console.log(typeof(response.data.teacher_id))
				if(response.data.add_student_status=='succeed'){
                    add_success()
                    this.students_change=false
                }
                else if(response.data.add_student_status=='failed'){
                    add_failed()
                }
			})
        },
        student_delete() {
            let that = this
			let param = new URLSearchParams()
			param.append('student_id',this.students_change_id)
			this.$axios({
				method:'post',
				url:'http://localhost:8000/mainpage/',
				data:param,
			}).then(function(response){
                window.console.log(response)
                window.console.log(typeof(response.data.teacher_id))
				if(response.data.delete_student_status=='succeed'){
                    delete_success()
                    this.students_change=false
                }
                else if(response.data.delete_student_status=='failed'){
                    delete_failed()
                }
			})
        },
        cancel_students_change() {
            this.students_change=false
        },
        goteacher_chart:function(){
            this.msg=false
            this.rewrite=false
            this.classes=false
            this.compete=false
            this.show_student=false
            this.charts=true
        },
        goteacher_compete:function(){
            this.msg=false
            this.rewrite=false
            this.classes=false
            this.compete=true
            this.show_student=false
            this.charts=false
            let that = this
            let param = new URLSearchParams
            param.append('teacher_id',this.teacher_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/teachermatch',
                data:param,
            }).then(function(response){
                window.console.log(response)
                that.match = response.data
            })
        },
        goadd_compete() {
            this.add_compete=true
        },
        sure_compete_add() {
            let that = this
			let param = new URLSearchParams()
            param.append('match_id',this.add_compete_id)
            param.append('match_name',this.add_compete_name)
            param.append('match_point',this.add_compete_point)
            param.append('words_id',this.add_words_id)
            param.append('teacher_id',this.teacher_id)
			this.$axios({
				method:'post',
				url:'http://localhost:8000/app/',
				data:param,
			}).then(function(response){
                window.console.log(response)
                window.console.log(typeof(response.data.teacher_id))
				if(response.data.add_match_status=='succeed'){
                    add_success()
                    this.add_compete=false
                }
                else if(response.data.add_match_status=='failed'){
                    add_failed()
                }
			})
        },
        cancel_compete_add() {
            this.add_compete=false
        },
        gochange_compete() {
            this.change_compete=true
        },
        sure_compete_change() {
            let that = this
			let param = new URLSearchParams()
            param.append('match_id',this.change_compete_id)
            param.append('match_name',this.change_compete_name)
            param.append('match_point',this.change_compete_point)
            param.append('words_id',this.change_words_id)
			this.$axios({
				method:'post',
				url:'http://localhost:8000/mainpage/',
				data:param,
			}).then(function(response){
                window.console.log(response)
                window.console.log(typeof(response.data.teacher_id))
				if(response.data.change_match_status=='succeed'){
                    rewrite_success()
                    this.change_compete=false
                }
                else if(response.data.change_match_status=='failed'){
                    rewrite_failed()
                }
			})
        },
        cancel_compete_change() {
            this.change_compete=false
        },
        tableHeaderColor({row,column,rowIndex,columnIndex}) {
            if(rowIndex===0) {
                return 'background-color: #BECBDC;color :BLACK'
            }
        },
    },
  // components: {
  //   HelloWorld
  // }
}
</script>

<style scoped>
table{
    border: 1px;
    text-align: center;
}
.table{
    font-family: 微软雅黑;
	font-size: 16px;
	font-weight: bold;
	color: #020a11;
    width: 8%;
	background-color:#e9faff;
}
#table_div{
    text-align: center;
    width: 1352px;
}
body {
    margin:0px;
    padding:0px;
 	border:0px;
    background-image:none;
    left:-8px;
    width:1647px;
    margin-left:auto;
    margin-right:auto;
    text-align:left;
}
td{
    font-size: 16px;
    width: 200px;
}
#teachermain {
    z-index:0;
    margin:0px;
    padding:0px;
    border:0px;
    height: 720px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
#header {
    margin:0px;
    width:1536px;
    height: 35px;
    background-color: #C0CDDE;
    margin-left:auto;
    margin-right:auto;
}
#menu1 {
    border: 2px solid #A1AFC2;
    margin:0px;
    width: 180px;
    height: 330px;
    background-color:#DBE2EB;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
#menu1>ul {
    margin:0px;
    padding:0px;
    float: left;
    list-style: none;
}
#menu1>ul>.menu_1 {
    width: 182px;
    height: 40px;
    float: left;
    list-style: none;
    border:none;
    border-top: 2px solid #7D8BA0;
    border-bottom: 2px solid #7D8BA0;
    background-image: linear-gradient(#CBD5E1, #8D9DBD);
    font-family: "华文细黑";
    font-size: medium;
    font-weight: bolder;
    text-align: left;
    color: #504F4E;
    text-indent: 15px;
}
#menu1>ul>.menu_1:hover>.option{
    display: block;
}
#menu1>ul>.option{
    width: 180px;
    height: 30px;
    float: left;
    list-style: none;
    display: block;
    border:none;
    font-family: "华文细黑";
    font-weight: bold;
	text-decoration: none;
    text-align: center;
    background-color: #DBE2EB;
    color: #504F4E;
}
#botton_list1 {
    padding: 0px;
    margin:0px;
    width: 1352px;
    height: 35px;
    float: left;
    position: relative;
    bottom: 334px;
    left: 184px;
    margin-left:auto;
    margin-right:auto;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    background-image: linear-gradient(#BFCCDC, #8D9DBD);
}
.button1 {
    padding: 0px;
    margin:0px;
    width: 100px;
    height: 35px;
    float: left;
    background-image: linear-gradient(#BFCCDC, #8D9DBD);
}

#botton_list2 {
    padding: 0px;
    margin:0px;
    width: 1352px;
    height: 35px;
    position: relative;
    top:60px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    background-image: linear-gradient(#BFCCDC, #8D9DBD);
}
.button2 {
    position: relative;
    bottom: 60px;
    padding: 0px;
    margin:0px;
    width: 100px;
    height: 35px;
    float: left;
    border:none;
    background-image: linear-gradient(#BFCCDC, #8D9DBD);
    color: black;
}
#msg_window {
    position: relative;
    bottom: 300px;
    left: 184px;
    width: 1352px;
    height: 680px;
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
#window_header {
    position: relative;
    bottom: 35px;
    width: 1352px;
    height: 24px;
    float: left;
    font-size: 14px;
    font-family: "华文细黑";
    line-height: 24px;
    text-indent: 5px;
    color: #565965;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    background-image: linear-gradient(#E9E9E9, #C5C5C5);
}
#msg {
    margin-left:20px;
    margin-bottom:20px; 
}
#sure {
    background-color: rgb(32, 214, 78);
    margin-top: 20px;
}
#new_compete {
    margin-left: 600px;
    margin-top: 30px;
}
.input {
    width: 310px;
    height: 38px;
    font-size: 16px;
    color: rgba(0, 0, 0, 0.447058823529412);
    box-sizing: border-box;
    background: inherit;
    background-color: rgba(255, 255, 255, 1);
    border-radius: 4px;
    border-width: 0px;
    word-wrap: break-word;
    text-transform: none;
    padding-right: 0;
    margin-left: 10px;
    border: 2px solid #C5C5C5;
}
#box1{
    margin-bottom: 20px;
}
/* Table */

#table-a
{
	font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
	font-size: 12px;
	margin: 45px;
    margin-top: 80px;
    margin-left: 400px;
	width: 480px;
	border-collapse: collapse;
	border: 1px solid #69c;
}
#table-a th
{
	padding: 12px 17px 12px 17px;
	font-weight: normal;
	font-size: 16px;
	color: #039;
	border-bottom: 1px dashed #69c;
    background: #A2C3FD;
}
#table-a td
{
	/* padding: 7px 17px 7px 17px; */
	color: #669;
}
#table-a tr:hover td
{
	color: #339;
	background: #d0dafd;
}
#table-a tr:nth-child(even) {
    background: #E4EDFD;
}
#table-b
{
	font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
	font-size: 12px;
	margin: 45px;
    margin-top: 80px;
    margin-left: 160px;
	width: 1000px;
	text-align: left;
	border-collapse: collapse;
	border: 1px solid #69c;
}
#table-b th
{
	padding: 12px 17px 12px 17px;
	font-weight: normal;
	font-size: 14px;
	color: #039;
	border-bottom: 1px dashed #69c;
    background: #A2C3FD;
}
#table-b td
{
	padding: 7px 17px 7px 17px;
    height: 30px;
	color: #669;
}
#table-b tr:hover td
{
	color: #339;
	background: #d0dafd;
}
#table-b tr:nth-child(even) {
    background: #E4EDFD;
}
#charts {
    width: 1260px;
}
</style>
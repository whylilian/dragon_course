<template>
    <div id="teachermain">
        <div id="header"></div>
        <div id="menu1" class="menu">
            <ul>
                <input type = "button" id="my_information" class="menu_1" value="我的信息">
                <input type = "button" class="option" value="个人信息" @click="goteacher_msg">
                <input type = "button" class="option" value="修改密码" @click="gorewrite_pwd">
                
                <input type = "button" id="study_management" class="menu_1" value="学习管理">
                <input type = "button" class="option" value="班级列表" @click="goteacher_classes">
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
            <input type = "button" class="button1" value="班级列表" @click="goteacher_classes">
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
            <div id="rewrite">
                <p>请输入旧密码：</p>
                <input type = "password" class = "input" id = "old_password" placeholder = "密码" v-model="old_password">
                <p>请输入新密码：</p>
                <input type = "password" class = "input" id = "new_password" placeholder = "密码" v-model="new_password">
                <div>
                    <input type = "button" class="button1" id="sure" value="确定" @click="send_rewrite">
                </div>
            </div>  
        </div>
        <div id="msg_window" v-show="classes">
            <div id="window_header">
                班级列表
            </div>
            <div id="botton_list2" class="botton_list">
                <el-button class="button2" icon="el-icon-plus" @click="goclasses_add">新增</el-button>
                <el-button class="button2" icon="el-icon-circle-close" @click="goclasses_delete">删除</el-button>
            </div>
            <div id="classes_add" v-show="classes_add">
                <el-input placeholder="请输入新增班级id" v-model="add_class_id" clearable maxlength="5" show-word-limit size="medium"></el-input>
                <el-input placeholder="请输入新增班级名称" v-model="add_class_name" clearable></el-input>
                <el-button type="primary" @click="sure_classes_add">确定</el-button>
                <el-button type="primary" @click="cancel_classes_add">取消</el-button>
            </div>
            <div id="classes_delete" v-show="classes_delete">
                <el-input placeholder="请输入删除班级id" v-model="delete_class_id" clearable maxlength="5" show-word-limit size="medium"></el-input>
                <el-button type="primary" @click="sure_classes_delete">确定</el-button>
                <el-button type="primary" @click="cancel_classes_delete">取消</el-button>
            </div>
            <template>
                <el-table ref="multipleTable" :data="classesdata" stripe align="left" max-height="900" border style="width: 100%" id="classesdata" :header-cell-style="tableHeaderColor">
                    <el-table-column prop="course_id" label="班级id"></el-table-column>
                    <el-table-column prop="course_name" label="班级名称"></el-table-column>
                    <el-table-column prop="course_student_number" label="课程人数"></el-table-column>
                    <el-table-column label="操作">
                        <template slot-scope="">
                            <el-button @click="goteacher_students">添加/删除学员</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </template>  
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
            <template>
                <el-table ref="multipleTable" :data="competedata" stripe align="left" max-height="900" border style="width: 100%" id="competedata" :header-cell-style="tableHeaderColor">
                    <el-table-column prop="match_id" label="比赛编号"></el-table-column>
                    <el-table-column prop="match_name" label="比赛名称"></el-table-column>
                    <el-table-column prop="match_point" label="比赛积分"></el-table-column>
                    <el-table-column prop="teacher_name" label="组织方"></el-table-column>
                    <el-table-column label="操作">
                        <template slot-scope="">
                            <el-button @click="gochange_compete">编辑</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </template> 
            <input type = "button" class="button1" value="新建比赛" id="new_compete" @click="goadd_compete"> 
        </div>
        <div id="msg_window" v-show="students">
            <div id="window_header">
                学生名册
            </div>
            <div id="botton_list2" class="botton_list">
                <el-button class="button2" icon="el-icon-notebook-1" @click="gobook_add">注册课程</el-button>
                <el-button class="button2" icon="el-icon-user-solid" @click="gostudent_change">添加/删除学员</el-button>
            </div>
            <div id="book_add" v-show="book_add">
                <el-input placeholder="请输入注册教材id" v-model="add_book_id" clearable maxlength="10" show-word-limit size="medium"></el-input>
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
            <template>
                <el-table ref="multipleTable" :data="studentsdata" stripe align="left" max-height="900" border style="width: 100%" id="studentsdata" :header-cell-style="tableHeaderColor">
                    <el-table-column prop="student_name" label="姓名"></el-table-column>
                    <el-table-column prop="email" label="邮箱"></el-table-column>
                    <el-table-column prop="coins" label="金币数量"></el-table-column>
                    <el-table-column prop="last_login" label="上次登录"></el-table-column>
                    <el-table-column prop="student_id" label="学生id"></el-table-column>
                    <el-table-column prop="course_name" label="班级名称"></el-table-column>
                    <el-table-column prop="所在组" label="所在组"></el-table-column>
                    <el-table-column prop="register_time" label="注册日期"></el-table-column>
                    <el-table-column prop="status" label="状态"></el-table-column>
                </el-table>
            </template>    
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
            new_password: '',
            msg:false,
            rewrite:false,
            classes:true,
            classes_add:false,
            classes_delete:false,
            compete:false,
            add_compete:false,
            students:false,
            book_add:false,
            students_change:false,
            change_compete:false,
            classesdata :[
                {course_id:'0',course_name:'',course_student_number:'0'}
            ],
            add_class_id:'',
            add_class_name:'',
            delete_class_id:'',
            competedata :[
                {match_id:'0',match_name:'',match_point:'',teacher_name:''}
            ],
            studentsdata :[
                {student_name:'',email:'',coins:'0',last_login:'',student_id:'0',course_name:'',group:'',register_time:'',status:''}
            ],
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
            students_change_id:''
        }
    },
    beforeCreate(){
		//未登录，跳转到登录界面
		if(this.$store.state.teacher_id==""){
			window.location = "teacherlogin.html"
		}
	},
	created(){
        this.teacher_id = parseInt(this.$store.state.teacher_id)
        this.teacher_username = this.$store.state.teacher_username
	},
	methods: {
        send_rewrite: function(){
			let that = this
            let param = new URLSearchParams()
            param.append('teacher_id',this.teacher_id)
			param.append('oldpassword',this.oldpassword)
			param.append('newpassword',this.newpassword)
			this.$axios({
				method:'post',
				url:'http://localhost:8000/app/teacherchange',
				data:param,
			}).then(function(response){
                window.console.log(response)
                window.console.log(typeof(response.data.teacher_id))
				if(response.data.change_status=='succeed'){
                    rewrite_success()
                    window.location = 'teacher.html'
                }
                else if(response.data.change_status=='failed'){
                    rewrite_failed()
                }
			})
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
                message: '修改错误',
                type: 'error'
            });
        },
		logout:function() {
            this.$store.dispatch("TeacherLogout")
			window.location = "teacherlogin.html"
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
            this.students=false
        },
        gorewrite_pwd:function(){
            this.msg=false
            this.rewrite=true
            this.classes=false
            this.compete=false
            this.students=false
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
                that.course_id = response.data.course_id
                that.course_name = response.data.course_name
                that.course_student_number = response.data.course_student_number
            })
            this.msg=false
            this.rewrite=false
            this.classes=true
            this.compete=false
            this.students=false
        },
        goclasses_add:function() {
            this.classes_add=true
        },
        // 待做
        // 
        // 
        sure_classes_add() {
            let that = this
			let param = new URLSearchParams()
			param.append('course_id',this.add_class_id)
			param.append('course_name',this.add_class_name)
			this.$axios({
				method:'post',
				url:'http://localhost:8000/mainpage/',
				data:param,
			}).then(function(response){
                window.console.log(response)
                window.console.log(typeof(response.data.teacher_id))
				if(response.data.add_course_status=='succeed'){
                    add_success()
                    this.classes_add=false
                    window.location = 'teacher.html'
                }
                else if(response.data.add_course_status=='failed'){
                    add_failed()
                }
			})
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
        goclasses_delete:function() {
            this.classes_delete=true
        },
        // 待做
        // 
        // 
        sure_classes_delete() {
            let that = this
			let param = new URLSearchParams()
			param.append('course_id',this.delete_class_id)
			this.$axios({
				method:'post',
				url:'http://localhost:8000/mainpage/',
				data:param,
			}).then(function(response){
                window.console.log(response)
                window.console.log(typeof(response.data.teacher_id))
				if(response.data.delete_course_status=='succeed'){
                    delete_success()
                    this.classes_delete=false
                    window.location = 'teacher.html'
                }
                else if(response.data.delete_course_status=='failed'){
                    delete_failed()
                }
			})
        },
        cancel_classes_delete() {
            this.classes_delete=false
        },
        delete_success() {
            this.$message({
                showClose: true,
                message: '添加成功',
                type: 'success'
            });
        },
        delete_failed() {
            this.$message({
                showClose: true,
                message: '添加错误',
                type: 'error'
            });
        },
        goteacher_students:function(){
            let that = this
            let param = new URLSearchParams
            param.append('course_id',this.course_id)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/studentlist',
            }).then(function(response){
                that.student_name = response.data.student_name
                that.email = response.data.email
                that.coins = response.data.coins
                that.last_login = response.data.last_login
                that.student_id = response.data.student_id
                that.course_name = response.data.course_name
                that.group = response.data.group
                that.register_time = response.data.register_time
                that.status = response.data.status
            })
            this.msg=false
            this.rewrite=false
            this.classes=false
            this.compete=false
            this.students=true
        },
        gobook_add(){
            this.book_add=true
        },
        sure_book_add() {
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
                window.console.log(typeof(response.data.teacher_id))
				if(response.data.status=='succeed'){
                    add_success()
                    this.book_add=false
                }
                else {
                    add_failed()
                }
			})
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
            this.students=false
        },
        goteacher_compete:function(){
            this.msg=false
            this.rewrite=false
            this.classes=false
            this.compete=true
            this.students=false
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
        logout:function(){
            this.$store.dispatch("Logout")
			window.location = "teacherlogin.html"
        }
    },
  // components: {
  //   HelloWorld
  // }
}
</script>

<style scoped>
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
#teachermain {
    z-index:0;
    margin:0px;
    padding:0px;
    border:0px;
    border-right: 2px solid #7D8BA0;
}
#header {
    margin:0px;
    width:1647px;
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
    width: 1463px;
    height: 35px;
    float: left;
    position: relative;
    bottom: 334px;
    left: 184px;
    margin-left:auto;
    margin-right:auto;
    border-right: 2px solid #7D8BA0;
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
    width: 1463px;
    height: 35px;
    position: relative;
    top:60px;
    border-right: 2px solid #7D8BA0;
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
    width: 1463px;
    height: 960px;
    background-color: #ffffff;
    border-right: 2px solid #7D8BA0;
}
#window_header {
    position: relative;
    bottom: 35px;
    width: 1463px;
    height: 24px;
    float: left;
    font-size: 14px;
    font-family: "华文细黑";
    line-height: 24px;
    text-indent: 5px;
    color: #565965;
    border-right: 2px solid #C5C5C5;
    background-image: linear-gradient(#E9E9E9, #C5C5C5);
}
#msg {
    margin-left:20px;
    margin-bottom:20px; 
}
#sure {
    margin-left:120px;
    margin-top:20px; 
}
#new_compete {
    margin-left: 500px;
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
</style>
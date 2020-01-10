<template>
    <div id="match">
        <navigation></navigation>
        <div id = "main1">
	    	<!--头部框-->
	    	<div id = "head-box">
	    	</div>
	    	<!--头像框-->
	    	<div class = "head-picture" id = "head-picture1">
	    	</div>
	    	<div class = "head-picture" id = "head-picture2">
	    	</div>
	    	<!--名称框-->
	    	<p id = "name1">曹勇</p>
	    	<p id = "name2">{{student_name}}</p>
	    	<!--积分框-->
	    	<div class = "integral" id = "integral1">
	    	</div>
	    	<div class = "integral" id = "integral2">
                <p id="false_time">答错次数：{{false_count}}</p>
                <p id="get_grade">分数：{{grade}}</p>
	    	</div>
	    	<!--计时框-->
	    	<div id = "time2">
	    		<img src = "../assets/5.png" id = "time-picture">
	    		<span id = "time-countdown">{{time}}s</span>
	    	</div>
	    	<!--题目-->
	    	<div id = "topic">
	    		<span id = "topic-word" v-for="(value,key,index) in match_word" v-if="key==word_index">{{value.example}}</span>
                <br>
                <span id = "topic-word" v-for="(value,key,index) in match_word" v-if="key==word_index">{{value.example_means}}</span>
	    	</div>
	    	<!--选项-->
	    	<div id = "choic" v-for="(value,key,index) in match_word" v-if="key==word_index">
	    		<input type = "button" :class = "{choic_button:!style_a_no,choic_correct:style_a_yes,choic_false:style_a_no}" :disabled="dead" :value = "value.A" @click="word_select('A')">
	    		<input type = "button" :class = "{choic_button:!style_b_no,choic_correct:style_b_yes,choic_false:style_b_no}" :disabled="dead" :value = "value.B" @click="word_select('B')">
	    		<input type = "button" :class = "{choic_button:!style_c_no,choic_correct:style_c_yes,choic_false:style_c_no}" :disabled="dead" :value = "value.C" @click="word_select('C')">
	    		<input type = "button" :class = "{choic_button:!style_d_no,choic_correct:style_d_yes,choic_false:style_d_no}" :disabled="dead" :value = "value.D" @click="word_select('D')">
	    	</div>
        </div>
        <input type="button" value="退出" id="out" @click="outmatch">
    </div>    
</template>

<script>
import Navigation from "../components/Navigation.vue"
export default {
    name:'match',
    data:function(){
        return{
            student_id:0,
            student_name:'',
            match_id:0,
            select:'',
            match_word:{},
            word_index:1,
            false_count:0,//错误的次数，达到3则比赛结束
            grade:0,//答对一题加10分
            style_a_yes:false,
            style_b_yes:false,
            style_c_yes:false,
            style_d_yes:false,
            style_a_no:false,
            style_b_no:false,
            style_c_no:false,
            style_d_no:false,
            dead:false,
            time:15,
            time_id:0,
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
        this.match_id = parseInt(this.$store.state.match_id)
		window.console.log(this.student_id)
        window.console.log(this.student_name)
        let that = this
        let param = new URLSearchParams
        param.append('match_id',this.match_id)
        this.$axios({
            method:'post',
            url:'http://localhost:8000/app/wordpk',
            data:param,
        }).then(function(response){
            window.console.log(response)
            that.match_word = response.data
            that.time_id = setInterval(that.clock,1000)//启动计时
        })
	},
    methods:{
        word_select:function(id){
            let index = this.word_index
            this.select = id
            window.console.log(this.select)
            window.console.log(this.match_word[index].correct)
            this.style_a_yes = false
            this.style_b_yes = false
            this.style_c_yes = false
            this.style_d_yes = false
            this.style_a_no = false
            this.style_b_no = false
            this.style_c_no = false
            this.style_d_no = false
            if(this.select == this.match_word[index].correct){
                this.grade += 10
                switch(id){
                    case 'A':{
                        this.style_a_yes = true
                        break
                    }
                    case 'B':{
                        this.style_b_yes = true
                        break
                    }
                    case 'C':{
                        this.style_c_yes = true
                        break
                    }
                    case 'D':{
                        this.style_d_yes = true
                        break
                    }
                }
            }else{
                this.false_count += 1
                switch(id){
                    case 'A':{
                        this.style_a_no = true
                        switch(this.match_word[index].correct){
                            case 'B':{
                                this.style_b_yes = true
                                break
                            }
                            case 'C':{
                                this.style_c_yes = true
                                break
                            }
                            case 'D':{
                                this.style_d_yes = true
                                break
                            }
                        }
                        break
                    }
                    case 'B':{
                        this.style_b_no = true
                        switch(this.match_word[index].correct){
                            case 'A':{
                                this.style_a_yes = true
                                break
                            }
                            case 'C':{
                                this.style_c_yes = true
                                break
                            }
                            case 'D':{
                                this.style_d_yes = true
                                break
                            }
                        }
                        break
                    }
                    case 'C':{
                        this.style_c_no = true
                        switch(this.match_word[index].correct){
                            case 'A':{
                                this.style_a_yes = true
                                break
                            }
                            case 'B':{
                                this.style_b_yes = true
                                break
                            }
                            case 'D':{
                                this.style_d_yes = true
                                break
                            }
                        }
                        break
                    }
                    case 'D':{
                        this.style_d_no = true
                        switch(this.match_word[index].correct){
                            case 'A':{
                                this.style_a_yes = true
                                break
                            }
                            case 'B':{
                                this.style_b_yes = true
                                break
                            }
                            case 'C':{
                                this.style_c_yes = true
                                break
                            }
                        }
                        break
                    }
                }
                if(this.false_count == 3){
                    let that = this
                    window.alert('比赛结束！')
                    let param = new URLSearchParams
                    param.append('student_id',this.student_id)
                    param.append('match_id',this.match_id)
                    param.append('match_grade',this.grade)
                    this.$axios({
                        method:'post',
                        url:'http://localhost:8000/app/inputmatch',
                        data:param,
                    }).then(function(response){
                        window.console.log(response)
                        window.location = 'main.html'
                    })
                }
            }
            setTimeout(this.stop,3000)
        },
        clock:function(){
            if(this.time>0){
                this.time -= 1
            }else{
                clearInterval(this.time_id)
                this.time_id = 0
                this.time = 15
            }
        },
        stop:function(){
            this.style_a_yes = false
            this.style_b_yes = false
            this.style_c_yes = false
            this.style_d_yes = false
            this.style_a_no = false
            this.style_b_no = false
            this.style_c_no = false
            this.style_d_no = false
            this.word_index += 1
            clearInterval(this.time_id)
            this.time_id = 0
            this.time = 15
            this.time_id = setInterval(this.clock,1000)
        },
        outmatch:function(){
            clearInterval(this.time_id)
            window.location = 'main.html'
        }
    },
    components:{
        Navigation
    }
}
</script>

<style scoped>

#main1 {
    width: 1000px;
    height: 600px;
    margin: auto;
    margin-top: 150px;
    background-color: whitesmoke;
    position: relative;
}
/* 头部部分 */
#head-box {
    width: 100%;
    height: 100px;
    background-color: rgb(34, 112, 157);
}
/* 头像部分 */
.head-picture {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background-color: slateblue;
}
#head-picture1 {
    position: absolute;
    top: 50px;
    left: 100px;
}
#head-picture2 {
    position: absolute;
    top: 50px;
    right: 100px;
}
/* 名字 */
#name1 {
    font-size: 18px;
    position: absolute;
    top: 150px;
    left: 130px;
}
#name2 {
    font-size: 18px;
    position: absolute;
    top: 150px;
    right: 130px;
}
/* 积分框 */
.integral {
    width: 150px;
    height: 300px;
}
#integral1 {
    position: absolute;
    top: 230px;
    left: 70px;
}
#integral2 {
    position: absolute;
    top: 230px;
    right: 70px;
}
/* 计时框*/
#time2 {
    width: 130px;
    height: 50px;
    border-radius: 30px;
    background-color: rgb(34, 112, 157);
    border: 4px solid rgb(0, 195, 255);
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
    position: absolute;
    top: 75px;
    left: 425px;
    display: flex;
}
/* 计时框中的小闪电*/
#time-picture {
    width: 40px;
    height: 40px;
    padding-top: 5px;
    padding-left: 15px;
}
/* 计时框中的倒计时*/
#time-countdown {
    font-size: 20px;
    font-weight: bold;
    color: white;
    padding-top: 9px;
    padding-left: 15px;
}
/* 题目框 */
#topic {
    width: 400px;
    height: 120px;
    position: absolute;
    left: 300px;
    top: 200px;
}
/* 题目 */
#topic-word {
    font-size: 20px;
    font-weight: 400;
}
/* 选项框 */
#choic {
    width: 450px;
    height: 200px;
    position: absolute;
    left: 275px;
    top: 350px;
}
/* 选项 */
.choic_button {
    width: 400px;
    height: 40px;
    margin-top: 10px;
    text-align: center;
    margin-left: 25px;
    border-width: 1px;
    border-style: solid;
    border-color: black;
    border-radius: 30px;
    background: inherit;
    background-color: white;
    outline: none;
}
.choic_correct {
    width: 400px;
    height: 40px;
    margin-top: 10px;
    text-align: center;
    margin-left: 25px;
    border-width: 1px;
    border-style: solid;
    border-radius: 30px;
    border: none;
    background: inherit;
    background-color: green;
    outline: none;
    color:white;
}
.choic_false {
    width: 400px;
    height: 40px;
    margin-top: 10px;
    text-align: center;
    margin-left: 25px;
    border-width: 1px;
    border-style: solid;
    border-radius: 30px;
    border: none;
    background: inherit;
    background-color:red;
    outline: none;
    color:white;
}
#out{
    width: 150px;
    height: 40px;
    font-size: 14px;
    color: white;
    border-style: solid;
    border-radius: 4px;
    border: none;
    background: inherit;
    background-color: rgb(26, 219, 36);
    position: relative;
    top: 30px;
    left: 1200px;
}
#false_time{
    color:red;
}
#get_grade{
    color:green;
}
</style>
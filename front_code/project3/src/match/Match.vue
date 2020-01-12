<template>
    <div id="match">
        <navigation></navigation>
        <div id = "main1" v-show="show_match1">
	    	<!--头部框-->
	    	<div id = "head-box">
	    	</div>
	    	<img src="../assets/tubiao.png" style="background-size:100%;width:100px;position:absolute;left:800px;top:40px;">
	    	<!--名称框-->
	    	<p id = "name1"></p>
	    	<p id = "name2">{{student_name}}</p>
	    	<!--积分框-->
	    	<div class = "integral" id = "integral1">
                <p id="daoju">道具</p>
                <img src="../assets/daoju1.png" @click="usedaoju1">
                <p id="daoju1">错误次数-1</p>
                <img src="../assets/daoju2.png" @click="usedaoju2">
                <p id="daoju2">答题时间+2s</p>
	    	</div>
	    	<div class = "integral" id = "integral2">
                <p id="false_time">答错次数：{{false_count}}</p>
                <p id="get_grade">分数：{{grade}}</p>
	    	</div>
	    	<!--计时框-->
	    	<div id = "time2">
	    		<img src = "../assets/5.png" id = "time-picture">
	    		<span id = "time-countdown">{{time1}}s</span>
	    	</div>
	    	<!--题目-->
	    	<div id = "topic">
	    		<span id = "topic-word" v-for="(value,key,index) in match_word" v-if="key==word_index">{{value.example}}</span>
                <br>
                <span id = "topic-word" v-for="(value,key,index) in match_word" v-if="key==word_index">{{value.example_means}}</span>
	    	</div>
	    	<!--选项-->
	    	<div id = "choic" v-for="(value,key,index) in match_word" v-if="key==word_index">
	    		<input type = "button" :class = "{choic_button:!style_a_no,choic_correct:style_a_yes,choic_false:style_a_no}" :disabled="dead" :value = "value.A" @click="match1_select('A')">
	    		<input type = "button" :class = "{choic_button:!style_b_no,choic_correct:style_b_yes,choic_false:style_b_no}" :disabled="dead" :value = "value.B" @click="match1_select('B')">
	    		<input type = "button" :class = "{choic_button:!style_c_no,choic_correct:style_c_yes,choic_false:style_c_no}" :disabled="dead" :value = "value.C" @click="match1_select('C')">
	    		<input type = "button" :class = "{choic_button:!style_d_no,choic_correct:style_d_yes,choic_false:style_d_no}" :disabled="dead" :value = "value.D" @click="match1_select('D')">
	    	</div>
            <img src="../assets/zhengque.png" id='img1'v-if="style_a_yes">
            <img src="../assets/cuowu.png" id='img1'v-if="style_a_no">
            <img src="../assets/zhengque.png" id='img2'v-if="style_b_yes">
            <img src="../assets/cuowu.png" id='img2'v-if="style_b_no">
            <img src="../assets/zhengque.png" id='img3'v-if="style_c_yes">
            <img src="../assets/cuowu.png" id='img3'v-if="style_c_no">
            <img src="../assets/zhengque.png" id='img4'v-if="style_d_yes">
            <img src="../assets/cuowu.png" id='img4'v-if="style_d_no">
        </div>
        <div id = "main1" v-show="show_match2">
	    	<!--头部框-->
	    	<div id = "head-box">
	    	</div>
            <img src="../assets/gongjuren.png" style="background-size:100%;width:100px;position:absolute;left:100px;top:40px;">
            <img src="../assets/tubiao.png" style="background-size:100%;width:100px;position:absolute;left:800px;top:40px;">
	    	<!--名称框-->
	    	<p id = "name1">工具人</p>
	    	<p id = "name2">{{student_name}}</p>
	    	<!--积分框-->
	    	<div class = "integral" id = "integral1">
                <p id="get_grade">分数：{{grade}}</p>
	    	</div>
	    	<div class = "integral" id = "integral2">
                <p id="get_grade">分数：{{grade}}</p>
	    	</div>
	    	<!--计时框-->
	    	<div id = "time2">
	    		<img src = "../assets/5.png" id = "time-picture">
	    		<span id = "time-countdown">{{time2}}s</span>
	    	</div>
	    	<!--题目-->
	    	<div id = "topic">
	    		<span id = "topic-word" v-for="(value,key,index) in match_word" v-if="key==word_index">{{value.example}}</span>
                <br>
                <span id = "topic-word" v-for="(value,key,index) in match_word" v-if="key==word_index">{{value.example_means}}</span>
	    	</div>
	    	<!--选项-->
	    	<div id = "choic" v-for="(value,key,index) in match_word" v-if="key==word_index">
	    		<input type = "button" :class = "{choic_button:!style_a_no,choic_correct:style_a_yes,choic_false:style_a_no}" :disabled="dead" :value = "value.A" @click="match2_select('A')">
	    		<input type = "button" :class = "{choic_button:!style_b_no,choic_correct:style_b_yes,choic_false:style_b_no}" :disabled="dead" :value = "value.B" @click="match2_select('B')">
	    		<input type = "button" :class = "{choic_button:!style_c_no,choic_correct:style_c_yes,choic_false:style_c_no}" :disabled="dead" :value = "value.C" @click="match2_select('C')">
	    		<input type = "button" :class = "{choic_button:!style_d_no,choic_correct:style_d_yes,choic_false:style_d_no}" :disabled="dead" :value = "value.D" @click="match2_select('D')">
	    	</div>
            <img src="../assets/zhengque.png" id='img1'v-if="style_a_yes">
            <img src="../assets/cuowu.png" id='img1'v-if="style_a_no">
            <img src="../assets/zhengque.png" id='img2'v-if="style_b_yes">
            <img src="../assets/cuowu.png" id='img2'v-if="style_b_no">
            <img src="../assets/zhengque.png" id='img3'v-if="style_c_yes">
            <img src="../assets/cuowu.png" id='img3'v-if="style_c_no">
            <img src="../assets/zhengque.png" id='img4'v-if="style_d_yes">
            <img src="../assets/cuowu.png" id='img4'v-if="style_d_no">
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
            match_name:'',
            word_length:0,
            select:'',
            match_word:{},
            word_index:1,
            false_count:0,//错误的次数，达到3则比赛结束
            false_count1:0,//工具人错误的次数
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
            time1:60,//一站到底
            time2:12,
            time1_id:0,
            time2_id:0,
            do_select:false,
            daoju1:3,
            daoju2:3,
            show_match1:false,//一站到底
            show_match2:false,
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
        this.match_name = this.$store.state.match_name
        window.console.log(this.match_name)
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
            that.word_length = Object.keys(that.match_word).length
            window.console.log(that.word_length)
            if(that.match_name=='一站到底'){
                that.show_match1 = true
                that.show_match2 = false
                that.time1_id = setInterval(that.clock1,1000)
            }else if(that.match_name=='擂台pk'){
                that.show_match1 = false
                that.show_match2 = true
                that.time2_id = setInterval(that.clock2,1000)//启动计时
            }
        })
	},
    methods:{
        match1_select:function(id){
            this.dead = true
            let index = this.word_index
            this.select = id
            this.style_a_yes = false
            this.style_b_yes = false
            this.style_c_yes = false
            this.style_d_yes = false
            this.style_a_no = false
            this.style_b_no = false
            this.style_c_no = false
            this.style_d_no = false
            if(this.select == this.match_word[index].correct){
                this.grade += 20
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
                    let param = new URLSearchParams
                    param.append('student_id',this.student_id)
                    param.append('match_id',this.match_id)
                    param.append('match_grade',this.grade)
                    this.$axios({
                        method:'post',
                        url:'http://localhost:8000/app/inputmatch',
                        data:param,
                    }).then(function(response){
                        clearInterval(that.time_id)
                        window.alert('比赛结束，你的分数为：'+that.grade)
                        window.location = 'main.html'
                    })
                }
            }
            setTimeout(this.stop1,2000)
        },
        match2_select:function(id){
            this.dead = true
            this.do_select = true
            let index = this.word_index
            this.select = id
            this.style_a_yes = false
            this.style_b_yes = false
            this.style_c_yes = false
            this.style_d_yes = false
            this.style_a_no = false
            this.style_b_no = false
            this.style_c_no = false
            this.style_d_no = false
            if(this.select == this.match_word[index].correct){
                //使用小算法判断分数
                let temp = 12-this.time2
                if(this.word_index==7){
                    this.grade = this.grade+40-temp
                }else{
                    this.grade = this.grade+20-temp
                }
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
                    let param = new URLSearchParams
                    param.append('student_id',this.student_id)
                    param.append('match_id',this.match_id)
                    param.append('match_grade',this.grade)
                    this.$axios({
                        method:'post',
                        url:'http://localhost:8000/app/inputmatch',
                        data:param,
                    }).then(function(response){
                        clearInterval(that.time_id)
                        window.alert('比赛结束，你的分数为：'+that.grade)
                        window.location = 'main.html'
                    })
                }
            }
            clearInterval(this.time2_id)
            setTimeout(this.stop2,2000)
        },
        clock1:function(){
            if(this.time1>0){
                this.time1 -= 1
            }else{
                clearInterval(this.time1_id)
                this.time1_id = 0
                this.time1 = 60
            }
        },
        clock2:function(){
            if(this.time2>0){
                this.time2 -= 1
            }else{
                if(this.do_select==false){
                    this.word_index += 1
                    this.time2 = 12
                    this.time2_id = setInterval(this.clock2,1000)
                }else{
                    clearInterval(this.time_id)
                    this.time2 = 12
                    this.time2_id = setInterval(this.clock2,1000)
                }
            }
        },
        stop1:function(){
            this.style_a_yes = false
            this.style_b_yes = false
            this.style_c_yes = false
            this.style_d_yes = false
            this.style_a_no = false
            this.style_b_no = false
            this.style_c_no = false
            this.style_d_no = false
            this.word_index += 1
            if(this.word_index>this.word_length){
                let param = new URLSearchParams
                let that = this
                param.append('student_id',this.student_id)
                param.append('match_id',this.match_id)
                param.append('match_grade',this.grade)
                this.$axios({
                    method:'post',
                    url:'http://localhost:8000/app/inputmatch',
                    data:param,
                }).then(function(response){
                    clearInterval(that.time_id)
                    window.alert('比赛结束，你的分数为：'+that.grade)
                    window.location = 'main.html'
                })
            }
            this.dead = false
        },
        stop2:function(){
            this.style_a_yes = false
            this.style_b_yes = false
            this.style_c_yes = false
            this.style_d_yes = false
            this.style_a_no = false
            this.style_b_no = false
            this.style_c_no = false
            this.style_d_no = false
            this.word_index += 1
            if(this.word_index>this.word_length){
                let param = new URLSearchParams
                let that = this
                param.append('student_id',this.student_id)
                param.append('match_id',this.match_id)
                param.append('match_grade',this.grade)
                this.$axios({
                    method:'post',
                    url:'http://localhost:8000/app/inputmatch',
                    data:param,
                }).then(function(response){
                    clearInterval(that.time_id)
                    window.alert('比赛结束，你的分数为：'+that.grade)
                    window.location = 'main.html'
                })
            }
            this.dead = false
            this.time2 = 12
            this.time2_id = setInterval(this.clock2,1000)
        },
        outmatch:function(){
            clearInterval(this.time_id)
            window.location = 'main.html'
        },
        usedaoju1:function(){
            if(this.daoju1==0){
                window.alert('该道具已用完')
            }
            if(this.false_count!=0&&this.daoju1!=0){
                this.daoju1 -= 1
                this.false_count -= 1
            }
        },
        usedaoju2:function(){
            if(this.daoju2==0){
                window.alert('该道具已用完')
            }else{
                this.time1 += 2
                this.daoju2 -= 1
            }
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
    background-color: white;
    position: relative;
}
/* 头部部分 */
#head-box {
    width: 100%;
    height: 100px;
    background-color: rgb(34, 112, 157);
}
/* 头像部分 */

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
    text-align: center;
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
#daoju{
    color: rgb(28, 149, 219);
}
#daoju1{
    color:rgb(29, 221, 221);
}
#daoju2{
    color: rgb(212, 36, 36);
}
#img1{
    position: absolute;
    top: 360px;
    left: 700px;
}
#img2{
    position: absolute;
    top: 410px;
    left: 700px;
}
#img3{
    position: absolute;
    top: 460px;
    left: 700px;
}
#img4{
    position: absolute;
    top: 510px;
    left: 700px;
}
</style>
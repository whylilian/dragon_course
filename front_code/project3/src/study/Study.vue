<template>
    <div id="study">
        <!--最上方-->
        <div id = "top-box1">
            <p id = "new-word">当前单元已熟练单词数：{{10-word_length}}</p>
            <p id = "recall">回想次数：{{recall_count}}</p>
            <span>单元：{{study_unit}}</span>
            <img src = "../assets/1.png" id = "picture">
            <span id = "time">{{show_time}}</span>
        </div>
        <div id = "main_box">
            <!--单词-->
            <div id="card1" v-if="show_card1">
                <p id = "english_word">{{study_word[index].spell}}</p>
                <div class = "familiarity" id = "familiarity1">
                    <div class = "little-box">
                        <p class = "number">1</p>
                    </div>
                    <input type = "button" class = "button" value = "认识" @click="word_know">
                </div>
                <div class = "familiarity" id = "familiarity2">
                    <div class = "little-box">
                        <p class = "number">2</p>
                    </div>
                    <input type = "button" class = "button" value = "不认识" @click="word_dont_know">
                </div>
                <div class = "familiarity" id = "familiarity3">
                    <div class = "little-box">
                        <p class = "number">3</p>
                    </div>
                    <input type = "button" class = "button" value = "Kill it（烂熟）" @click="kill">
                </div>
            </div>
            <div id="card2" v-if="show_card2">
                <p id = "english_word">{{study_word[index].spell}}</p>
                <div class = "familiarity" id = "example-sentence">
                    {{study_word[index].example}}
                </div>
                <div class = "familiarity" id = "familiarity1">
                    <div class = "little-box">
                        <p class = "number">1</p>
                    </div>
                    <input type = "button" class = "button" value = "想起来了" @click="think">
                </div>
                <div class = "familiarity" id = "familiarity2">
                    <div class = "little-box">
                        <p class = "number">2</p>
                    </div>
                    <input type = "button" class = "button" value = "没想起来" @click="dont_think">
                </div>
            </div>
            <div id="card3" v-if="show_card3">
                <p id = "english_word">{{study_word[index].spell}}</p>
                <div id = "main_box1">
                    <!--中间盒子-->
                    <div id = "middle_box">
                        <p id = "translate">单词解释</p>

                        <!--单词解释-->
                        <div id = "translate_box">
                            {{study_word[index].mean}}
                        </div>
                    </div>
                </div>
                <div id = "main_box2">
                    <!--下方盒子-->
                    <div id = "buttom-box">
                        <p id = "sentence">例句</p>
                        <!--例句框-->
                        <div id = "sentence_box">
                            <p>{{study_word[index].example}}</p>
                            <p>{{study_word[index].example_mean}}</p>
                        </div>
                    </div>
                </div>
                <input type = "button" class = "recall-button" id = "recall_right" value = "回想正确" v-if="!show_next" @click="recall_correct">
                <input type = "button" class = "recall-button" id = "recall_wrong" value = "回想错误" v-if="!show_next" @click="recall_false">
                <input type = "button" id = "next-part" value = "Next" v-if="show_next" @click="gonext">
            </div>
        </div>
    </div>    
</template>

<script>
export default {
    name:'studycard',
    data:function(){
        return{
            student_id:0,
            student_name:'',
            study_word:{},
            show_card1:false,
            show_card2:false,
            show_card3:false,
            show_card4:false,
            show_next:false,
            study_unit:0,//学习的单元
            book_id:0,
            time_id:0,
            show_time:180,
            word_length:0,//待学习单词数
            index:1,
            recall_count:0,//回想次数
        }
    },
    beforeCreate(){
		//未登录，跳转到登录界面
		if(this.$store.state.student_id==""){
			window.location = "login.html"
		}
	},
	created(){
        //进入学习页面，启动番茄时钟
        this.time_id = setInterval(this.clock,1000)
        this.study_unit = parseInt(this.$store.state.study_unit)
		this.student_id = parseInt(this.$store.state.student_id)
        this.student_name = this.$store.state.student_name
        this.book_id = parseInt(this.$store.state.book_id)
        let that = this
        let param = new URLSearchParams
        param.append('student_id',this.student_id)
        param.append('book_id',this.book_id)
        param.append('unit_number',this.study_unit)
        this.$axios({
            method:'post',
            url:'http://localhost:8000/app/unitlearn',
            data:param,
        }).then(function(response){
            window.console.log(response)
            that.study_word = response.data
            that.word_length = Object.keys(that.study_word).length
            that.show_card1 = true
        })
    },
    methods:{
        clock:function(){
            if(this.show_time>0){
                this.show_time -= 1
            }else{
                clearInterval(this.time_id)
                this.time_id = 0
                this.show_time = 180
                window.alert('连续学习了这么久，休息一下吧！')
            }
        },
        word_know:function(){
            this.show_card1 = false
            this.show_card2 = false
            this.show_card3 = true
            this.show_next = false
        },
        word_dont_know:function(){
            this.show_card1 = false
            this.show_card2 = true
            this.show_card3 = false
            this.show_next = false
        },
        recall_correct:function(){
            let that = this
            let param = new URLSearchParams
            let count = this.index
            this.recall_count += 1
            param.append('student_id',this.student_id)
            param.append('word_id',this.study_word[count].word_id)
            param.append('recall_num',2)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/recall_word',
                data:param,
            }).then(function(response){
                window.console.log(response)
            })
            let param1 = new URLSearchParams
            param1.append('student_id',this.student_id)
            param1.append('book_id',this.book_id)
            param1.append('unit_number',this.study_unit)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/unitlearn',
                data:param1,
            }).then(function(response){
                window.console.log(response)
                that.study_word = response.data
                that.word_length = Object.keys(that.study_word).length
                if(that.word_length==0){
                    window.alert('本单元的学习你已完成！')
                    clearInterval(that.time_id)
                    window.location = 'main.html'
                }
                that.show_card1 = false
                that.show_card2 = false
                that.show_card3 = true
                that.show_next = true
            })
        },
        recall_false:function(){
            let that = this
            let param = new URLSearchParams
            let count = this.index
            this.recall_count += 1
            param.append('student_id',this.student_id)
            param.append('word_id',this.study_word[count].word_id)
            param.append('recall_num',1)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/recall_word',
                data:param,
            }).then(function(response){
                window.console.log(response)
            })
            let param1 = new URLSearchParams
            param1.append('student_id',this.student_id)
            param1.append('book_id',this.book_id)
            param1.append('unit_number',this.study_unit)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/unitlearn',
                data:param1,
            }).then(function(response){
                window.console.log(response)
                that.study_word = response.data
                that.word_length = Object.keys(that.study_word).length
                if(that.word_length==0){
                    window.alert('本单元的学习你已完成！')
                    clearInterval(that.time_id)
                    window.location = 'main.html'
                }
                that.index += 1
                if(that.index>that.word_length){
                    that.index = 1
                }
                that.show_card1 = true
                that.show_card2 = false
                that.show_card3 = false
                that.show_next = false
            })
        },
        gonext:function(){
            this.index += 1
            if(this.index>this.word_length){
                this.index = 1
            }
            this.show_card1 = true
            this.show_card2 = false
            this.show_card3 = false
            this.show_next = false
        },
        kill:function(){
            //单词熟练度加满，不再出现
            let that = this
            let param = new URLSearchParams
            let count = this.index
            param.append('student_id',this.student_id)
            param.append('word_id',this.study_word[count].word_id)
            param.append('recall_num',3)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/recall_word',
                data:param,
            }).then(function(response){
                window.console.log(response)
            })
            let param1 = new URLSearchParams
            param1.append('student_id',this.student_id)
            param1.append('book_id',this.book_id)
            param1.append('unit_number',this.study_unit)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/unitlearn',
                data:param1,
            }).then(function(response){
                window.console.log(response)
                that.study_word = response.data
                that.word_length = Object.keys(that.study_word).length
                if(that.word_length==0){
                    window.alert('本单元的学习你已完成！')
                    clearInterval(that.time_id)
                    window.location = 'main.html'
                }
                that.index += 1
                if(that.index>that.word_length){
                    that.index = 1
                }
                that.show_card1 = true
                that.show_card2 = false
                that.show_card3 = false
                that.show_next = false
            })
        },
        think:function(){
            this.show_card1 = false
            this.show_card2 = false
            this.show_card3 = true
            this.show_next = false
            this.recall_count += 1
        },
        dont_think:function(){
            let that = this
            let param = new URLSearchParams
            let count = this.index
            this.recall_count += 1
            param.append('student_id',this.student_id)
            param.append('word_id',this.study_word[count].word_id)
            param.append('recall_num',1)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/recall_word',
                data:param,
            }).then(function(response){
                window.console.log(response)
            })
            let param1 = new URLSearchParams
            param1.append('student_id',this.student_id)
            param1.append('book_id',this.book_id)
            param1.append('unit_number',this.study_unit)
            this.$axios({
                method:'post',
                url:'http://localhost:8000/app/unitlearn',
                data:param1,
            }).then(function(response){
                window.console.log(response)
                that.study_word = response.data
                that.word_length = Object.keys(that.study_word).length
                if(that.word_length==0){
                    window.alert('本单元的学习你已完成！')
                    clearInterval(that.time_id)
                    window.location = 'main.html'
                }
                that.show_card1 = false
                that.show_card2 = false
                that.show_card3 = true
                that.show_next = true
            })
        }
    }
}
</script>

<style scoped>
#study{
    width: 1120px;
    height: 968px;
    background-color: white;
    position: relative;
    left: 400px;
}
/* 最上方 */
#top-box1 {
    width: 100%;
    height: 70px;
    display: flex;
}

#new-word {
    margin: 0;
    padding-left: 200px;
    padding-top: 30px;
}

#recall {
    margin: 0;
    padding-left: 30px;
    padding-top: 30px;
}

#picture {
    width: 100px;
    height: 70px;
    margin-left: 350px;
}

#time {
    padding-left: 50px;
    padding-top: 30px;
}

#main_box {
    width: 700px;
    height: 400px;
    margin: auto;
}
#main_box1{
    width: 600px;
    height: 200px;
    margin: auto;
}
#main_box2 {
    width: 600px;
    height: 200px;
    margin: 80px auto 0;
}
#middle_box {
    width: 100%;
    height: 110px;
    display: flex;
}

#english_word {
    font-size: 30px;
    font-weight: bold;
    text-align: center;
    padding-top: 50px;
}

.familiarity {
    width: 600px;
    height: 60px;
    margin: auto;
    border: 1px solid hsla(0, 0%, 0%, 0.227450980392157);
    display: flex;
}

#familiarity1 {
    border-bottom: none;
}

#familiarity2 {
    border-bottom: none;
}

.little-box {
    width: 60px;
    height: 60px;
    border-right: 1px solid hsla(0, 0%, 0%, 0.227450980392157);
}

.number {
    margin: 0;
    padding-top: 22px;
    text-align: center;
}

.button {
    width: 540px;
    height: 58px;
    background: inherit;
    border: none;
    text-align: left;
    font-size: 16px;
}
#translate {
    font-size: 16px;
    font-weight: bold;
    margin: 0;
    padding-top: 20px;
    padding-left: 60px;

}

#translate_box {
    width: 400px;
    height: 110px;
    margin-left: 20px;
    background-color: whitesmoke;
}
#example-sentence {
    margin-top: 30px;
    margin-bottom: 30px;
    background-color: whitesmoke;
}

#buttom-box {
    width: 100%;
    height: 150px;
    display: flex;
}

#sentence {
    font-size: 16px;
    font-weight: bold;
    margin: 0;
    padding-left: 94px;
    padding-top: 30px;
}

#sentence_box {
    width: 400px;
    height: 150px;
    background-color: whitesmoke;
    margin-left: 20px;
    margin-top: 30px;
}

.recall-button {
    width: 150px;
    height: 40px;
    font-size: 14px;
    color: black;
    border-width: 1px;
    border-style: solid;
    border-color: black;
    border-radius: 4px;
    background: inherit;
    margin-top: 50px;
}

#recall_right {
    margin-left: 320px;
}

#recall_wrong {
    margin-left: 30px;
}

#next-part {
    width: 150px;
    height: 40px;
    font-size: 14px;
    color: black;
    border-color: black;
    border-width: 1px;
    border-style: solid;
    border-radius: 4px;
    background: inherit;
    margin-top: 50px;
    margin-left: 500px;
}
</style>
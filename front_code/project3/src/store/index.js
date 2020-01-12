import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);


const store = new Vuex.Store({
    state:{
        student_id:window.localStorage.getItem("student_id") || "",
        student_name:window.localStorage.getItem("student_name") || "",
        coins:window.localStorage.getItem("coins") || "0",
        daka_num:window.localStorage.getItem("daka_num") || "0",
        enable_daka:window.localStorage.getItem("enable_daka") || "0",
        study_unit:window.localStorage.getItem("study_unit") || "0",
        book_id:window.localStorage.getItem("book_id") || "0",
        match_id:window.localStorage.getItem("match_id") || "0",
        match_name:window.localStorage.getItem("match_name") || "",
        teacher_id:window.localStorage.getItem("teacher_id") || "",
        teacher_name:window.localStorage.getItem("teacher_name") || "",
    },
    mutations:{
        login_save:function(state,data){
            window.localStorage.student_id = data.student_id
            window.localStorage.student_name = data.student_name
            window.localStorage.coins = data.coins
            window.localStorage.daka_num = data.daka_num
            window.localStorage.enable_daka = data.enable_daka
        },
        logout_save:function(state){
            window.localStorage.removeItem("student_id")
            window.localStorage.removeItem("student_name")
            window.localStorage.removeItem("coins")
            window.localStorage.removeItem("daka_num")
            window.localStorage.removeItem("enable_daka")
            window.localStorage.removeItem("study_unit")
            window.localStorage.removeItem("book_id")
            window.localStorage.removeItem("match_id")
            window.localStorage.removeItem("match_name")
        },
        daka_save:function(state,data){
            window.localStorage.coins = data.coins
            window.localStorage.daka_num = data.daka_num
            window.localStorage.enable_daka = data.enable_daka
        },
        unit_save:function(state,data){
            window.localStorage.study_unit = data.study_unit
            window.localStorage.book_id = data.book_id
        },
        match_save:function(state,data){
            window.localStorage.match_id = data.match_id
            window.localStorage.match_name = data.match_name
        },
        teacher_login_save:function(state,data){
            window.localStorage.teacher_id = data.teacher_id
            window.localStorage.teacher_name = data.teacher_name
        },
        teacher_logout_save:function(state){
            window.localStorage.removeItem("teacher_id")
            window.localStorage.removeItem("teacher_name")
        }
    },
    actions:{
        Login:function(context,data){
            context.commit('login_save',data)
        },
        Logout:function(context){
            context.commit('logout_save')
        },
        daka:function(context,data){
            context.commit('daka_save',data)
        },
        unit:function(context,data){
            context.commit('unit_save',data)
        },
        match:function(context,data){
            context.commit('match_save',data)
        },
        TeacherLogin:function(context,data){
            context.commit('teacher_login_save',data)
        },
        TeacherLogout:function(context){
            context.commit('teacher_logout_save')
        }
    }
})

export default store
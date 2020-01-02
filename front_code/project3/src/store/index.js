import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);


const store = new Vuex.Store({
    state:{
        student_id:window.localStorage.getItem("student_id") || "",
        student_name:window.localStorage.getItem("student_name") || "",
        coins:window.localStorage.getItem("coins") || "0",
    },
    mutations:{
        login_save:function(state,data){
            window.localStorage.student_id = data.student_id
            window.localStorage.student_name = data.student_name
            window.localStorage.coins = data.coins
        },
        logout_save:function(state){
            window.localStorage.removeItem("student_id")
            window.localStorage.removeItem("student_name")
            window.localStorage.removeItem("coins")
        }
    },
    actions:{
        Login:function(context,data){
            context.commit('login_save',data)
        },
        Logout:function(context){
            context.commit('logout_save')
        }
    }
})

export default store
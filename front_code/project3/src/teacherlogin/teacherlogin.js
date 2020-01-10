import Vue from 'vue'
import TeacherLogin from './TeacherLogin.vue'
import axios from 'axios'
import router from '../router'
import store from '../store'

Vue.config.productionTip = false

Vue.prototype.$axios = axios;

new Vue({
  el: '#teacherlogin',
  router,
  store,
  render: h => h(TeacherLogin),
})

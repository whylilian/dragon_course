import Vue from 'vue'
import User from './User.vue'
import router from '../router'
import axios from 'axios'
import store from '../store'


Vue.config.productionTip = false
Vue.prototype.$axios = axios;

new Vue({
  el: '#user',
  router,
  store,
  render: h => h(User),
})

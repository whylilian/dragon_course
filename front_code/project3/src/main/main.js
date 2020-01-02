import Vue from 'vue'
import Main from './Main.vue'
import axios from 'axios'
import router from '../router'
import store from '../store'

Vue.config.productionTip = false

Vue.prototype.$axios = axios;

new Vue({
  el: '#mainpage',
  router,
  store,
  render: h => h(Main),
})

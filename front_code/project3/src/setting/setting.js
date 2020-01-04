import Vue from 'vue'
import Setting from './Setting.vue'
import axios from 'axios'
import router from '../router'
import store from '../store'

Vue.config.productionTip = false

Vue.prototype.$axios = axios;

new Vue({
  el: '#setting',
  router,
  store,
  render: h => h(Setting),
})

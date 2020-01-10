import Vue from 'vue'
import Match from './Match.vue'
import axios from 'axios'
import router from '../router'
import store from '../store'

Vue.config.productionTip = false

Vue.prototype.$axios = axios;

new Vue({
  el: '#match',
  router,
  store,
  render: h => h(Match),
})

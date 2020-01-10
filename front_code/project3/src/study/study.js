import Vue from 'vue'
import Study from './Study.vue'
import axios from 'axios'
import router from '../router'
import store from '../store'

Vue.config.productionTip = false

Vue.prototype.$axios = axios;

new Vue({
  el: '#study',
  router,
  store,
  render: h => h(Study),
})

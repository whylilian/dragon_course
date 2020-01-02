import Vue from 'vue'
import Chart from './Chart.vue'
import axios from 'axios'
import router from '../router'
import store from '../store'

Vue.config.productionTip = false

Vue.prototype.$axios = axios;

new Vue({
  el: '#chart',
  router,
  store,
  render: h => h(Chart),
})

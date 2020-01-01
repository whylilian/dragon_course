import Vue from 'vue'
import App from './App.vue'
import axios from 'axios'
import router from '../router'

Vue.config.productionTip = false

Vue.prototype.$axios = axios;

new Vue({
  el: '#app',
  router,
  render: h => h(App),
})

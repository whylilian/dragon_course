import Vue from 'vue'
import Navigation from './Navigation.vue'
import axios from 'axios'
import router from '../router'
import store from '../store'

Vue.config.productionTip = false

Vue.prototype.$axios = axios;

new Vue({
  el: '#navigation',
  router,
  store,
  render: h => h(Navigation),
})

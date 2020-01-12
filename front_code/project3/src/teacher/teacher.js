import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import Vue from 'vue'
import Teacher from './Teacher.vue'
import axios from 'axios'
import router from '../router'
import store from '../store'
import VCharts from 'v-charts'

Vue.use(ElementUI)
Vue.use(VCharts)
Vue.config.productionTip = false

Vue.prototype.$axios = axios;

new Vue({
  el: '#teachermain',
  router,
  store,
  render: h => h(Teacher),
})

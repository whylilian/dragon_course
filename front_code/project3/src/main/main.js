import Vue from 'vue'
import Main from './Main.vue'
import axios from 'axios'
import router from '../router'
import store from '../store'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import VCharts from 'v-charts'

Vue.config.productionTip = false
Vue.use(ElementUI);
Vue.use(VCharts)

Vue.prototype.$axios = axios;

new Vue({
  el: '#mainpage',
  router,
  store,
  render: h => h(Main),
})

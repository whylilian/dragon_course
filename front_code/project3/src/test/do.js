import Vue from 'vue'
import User from './User.vue'
import router from '../router'


Vue.config.productionTip = false

new Vue({
  el: '#user',
  router,
  render: h => h(User),
})

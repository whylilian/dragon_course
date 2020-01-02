import Vue from 'vue'
import Router from 'vue-router'
import User from '../test/User'
import App from '../login/App.vue'
import Main from '../main/Main.vue'
import Chart from '../chart/Chart.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/login',
      name: 'login',
      component: App
    },
    {
      path: '/test',
      name: 'test',
      component: User
    },
    {
      path: '/main',
      name: 'main',
      component: Main
    },
    {
      path: '/chart',
      name: 'chart',
      component: Chart
    },
  ]
})

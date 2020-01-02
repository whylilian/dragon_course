import Vue from 'vue'
import Router from 'vue-router'
import User from '../test/User'
import App from '../login/App'
import Main from '../main/Main.vue'

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
  ]
})

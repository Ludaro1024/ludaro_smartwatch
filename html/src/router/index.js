import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),

  routes: [
    {
      path: '/',
      name: 'Home',
      component: () => import('../components/smartwatchsites/Home.vue')
    },
    {
        path: "/Info",
        name: "Info",
        component: () => import("../components/smartwatchsites/Info.vue")
    },
    // { 
    //   path: '/Settings',
    //   name: 'Settings',
    //   component: () => import('../components/smartwatchsites/Settings.vue')
    // }
  ]
})

export default router
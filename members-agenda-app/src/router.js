import { createRouter, createWebHistory } from 'vue-router'

import SlotsView from './views/SlotsView.vue'
import MembersView from './views/MembersView.vue'

const routes = [
  { path: '/slots/:day', name: 'slots', component: SlotsView },
  { path: '/members/79', name: 'members', component: MembersView },
//   { path: '/', name: 'home', redirect: '/slots/2024-06-27' },
]

export const router = createRouter({
  history: createWebHistory(),
  routes,
})

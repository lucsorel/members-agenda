import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import { router } from './router'

const membersAgendaApp = createApp(App)

membersAgendaApp.use(router)

membersAgendaApp.mount('#app')

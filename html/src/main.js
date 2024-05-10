import './assets/base.css'
import { createApp } from 'vue'
import App from './App.vue'
import router from "./router"

// import { OhVueIcon, addIcons } from "oh-vue-icons";
// import { GiUnicorn } from "oh-vue-icons/icons";
// addIcons(GiUnicorn)
const app = createApp(App);
//app.component("v-icon", OhVueIcon);
app.use(router)
app.mount('#app')






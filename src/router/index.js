import Vue from 'vue'
import VueRouter from 'vue-router'
import BotView from "@/views/BotView";
import TicTacToe from "@/components/TicTacToe";

Vue.use(VueRouter)

const routes = [
    {path: '/computer', component: BotView},
    {path: '/players', component: TicTacToe, alias: ['/', '']},
]

const router = new VueRouter({
    routes
})

export default router

import Vue from 'vue';
import Router from 'vue-router';
import rutas from './rutas';
import { getUser } from '../bd/api';

Vue.use(Router);

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: rutas
});

router.beforeEach((to, from, next) => {
  let user = getUser();
  if (to.matched.some(record => record.meta.auth)) {
    if (user) next();
    else next('/login');
  } else {
    if (user) {
      if (user.tipo == 'E') next('/egresado');
      else next('/personal');
    } else next();
  }
});

export default router;

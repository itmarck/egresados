import Vue from 'vue';
import Router from 'vue-router';
import Login from './views/Login.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/login',
      name: 'login',
      component: Login
    },
    {
      path: '/personal',
      component: () => import('./views/Personal/View.vue'),
      children: [
        {
          path: '',
          redirect: 'inicio'
        },
        {
          path: 'inicio',
          component: () => import('./views/Personal/Inicio.vue')
        },
        {
          path: 'mantenimiento',
          component: () => import('./views/Personal/Mantenimiento.vue')
        },
        {
          path: 'egresados',
          component: () => import('./views/Personal/Egresados.vue')
        },
        {
          path: 'reportes',
          component: () => import('./views/Personal/Reportes.vue')
        },
        {
          path: 'admin',
          component: () => import('./views/Personal/Admin.vue')
        },
        {
          path: 'perfil',
          component: () => import('./views/Perfil.vue')
        },
        {
          path: 'seguridad',
          component: () => import('./views/Seguridad.vue')
        }
      ]
    },
    {
      path: '/egresado',
      component: () => import('./views/Egresado/View.vue'),
      children: [
        {
          path: '',
          redirect: 'inicio'
        },
        {
          path: 'inicio',
          component: () => import('./views/Egresado/Inicio.vue')
        },
        {
          path: 'pregrado',
          component: () => import('./views/Egresado/Pregrado.vue')
        },
        {
          path: 'postgrado',
          component: () => import('./views/Egresado/Postgrado.vue')
        },
        {
          path: 'experiencia',
          component: () => import('./views/Egresado/Experiencia.vue')
        },
        {
          path: 'curriculum',
          component: () => import('./views/Egresado/Curriculum.vue')
        },
        {
          path: 'perfil',
          component: () => import('./views/Perfil.vue')
        },
        {
          path: 'seguridad',
          component: () => import('./views/Seguridad.vue')
        }
      ]
    }
  ]
});

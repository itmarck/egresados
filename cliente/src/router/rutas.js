import Login from '../views/Login.vue';
import { getUser } from '../bd/api';

export default [
  {
    path: '*',
    redirect: 'login'
  },
  {
    path: '/login',
    name: 'login',
    component: Login
  },
  {
    path: '/registro',
    name: 'registro',
    component: () => import('../views/Registro.vue')
  },
  {
    path: '/personal',
    component: () => import('../views/Personal/View.vue'),
    beforeEnter: (to, from, next) => {
      if (['A', 'P'].includes(getUser().tipo)) next();
      else next('/');
    },
    children: [
      {
        path: '',
        redirect: 'inicio'
      },
      {
        path: 'inicio',
        component: () => import('../views/Personal/Inicio.vue')
      },
      {
        path: 'mantenimiento',
        component: () => import('../views/Personal/Mantenimiento.vue')
      },
      {
        path: 'egresados',
        component: () => import('../views/Personal/Egresados.vue')
      },
      {
        path: 'reportes',
        component: () => import('../views/Personal/Reportes.vue')
      },
      {
        path: 'admin',
        component: () => import('../views/Personal/Admin.vue'),
        beforeEnter: (to, from, next) => {
          if (getUser().tipo == 'A') next();
          else next(false);
        }
      },
      {
        path: 'perfil',
        component: () => import('../views/Perfil.vue')
      },
      {
        path: 'seguridad',
        component: () => import('../views/Seguridad.vue')
      }
    ],
    meta: { auth: true }
  },
  {
    path: '/egresado',
    component: () => import('../views/Egresado/View.vue'),
    beforeEnter: (to, from, next) => {
      if (getUser().tipo == 'E') next();
      else next('/');
    },
    children: [
      {
        path: '',
        redirect: 'inicio'
      },
      {
        path: 'inicio',
        component: () => import('../views/Egresado/Inicio.vue')
      },
      {
        path: 'carreras',
        component: () => import('../views/Egresado/Carreras.vue')
      },
      {
        path: 'postgrado',
        component: () => import('../views/Egresado/Postgrado.vue')
      },
      {
        path: 'experiencia',
        component: () => import('../views/Egresado/Experiencia.vue')
      },
      {
        path: 'curriculum',
        component: () => import('../views/Egresado/Curriculum.vue')
      },
      {
        path: 'perfil',
        component: () => import('../views/Perfil.vue')
      },
      {
        path: 'seguridad',
        component: () => import('../views/Seguridad.vue')
      }
    ],
    meta: { auth: true }
  }
];

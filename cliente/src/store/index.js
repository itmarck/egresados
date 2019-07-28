import Vue from 'vue';
import Vuex from 'vuex';
import { getUser } from '../bd/api';
import mantenimiento from './mantenimiento';
import reportes from './reportes';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user: getUser(),
    mensaje: '',
    snack: false
  },
  mutations: {
    updateUser(state) {
      state.user = getUser();
    },
    snackbar(state, payload) {
      state.mensaje = payload;
      state.snack = true;
    },
    hideSnack(state) {
      state.snack = false;
    }
  },
  modules: {
    mantenimiento,
    reportes
  }
});

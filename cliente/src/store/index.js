import Vue from 'vue';
import Vuex from 'vuex';
import { getUser } from '../bd/api';
import mantenimiento from './mantenimiento';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user: getUser()
  },
  mutations: {
    updateUser(state) {
      state.user = getUser();
    }
  },
  modules: {
    mantenimiento
  }
});

import Vue from 'vue';
import Vuex from 'vuex';
import { getUser } from '../bd/api';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user: getUser()
  },
  mutations: {
    updateUser(state) {
      state.user = getUser();
    }
  }
});

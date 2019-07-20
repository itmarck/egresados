export default {
  namespaced: true,
  state: {
    tabla: 'universidad'
  },
  mutations: {
    update(state, payload) {
      state.tabla = payload;
    }
  }
};

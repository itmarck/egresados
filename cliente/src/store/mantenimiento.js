export default {
  namespaced: true,
  state: {
    tabla: 'Universidades'
  },
  mutations: {
    update(state, payload) {
      state.tabla = payload;
    }
  }
};

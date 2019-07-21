export default {
  namespaced: true,
  state: {
    tabla: 'Escuelas'
  },
  mutations: {
    update(state, payload) {
      state.tabla = payload;
    }
  }
};

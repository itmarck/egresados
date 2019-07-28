export default {
  namespaced: true,
  state: {
    reporte: 'Egresados por Admisión'
  },
  mutations: {
    update(state, payload) {
      state.reporte = payload;
    }
  }
};

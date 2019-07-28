<template>
  <v-select
    :items="reportes"
    v-model="reporte"
    hide-details
    solo
    placeholder="Seleccione reporte"
  >
    <template slot="prepend-inner">
      <v-icon left>web</v-icon>
    </template>
  </v-select>
</template>

<script>
import { mapState } from "vuex";
export default {
  data: () => ({
    reportes: [
      "Egresados por Admisión",
      "Egresados por DNI",
      "Egresados por Distrito",
      "Egresados por Actividad Económica"
    ]
  }),
  computed: {
    reporte: {
      get() {
        return this.$store.state.reportes.reporte;
      },
      set(value) {
        this.$store.commit("reportes/update", value);
      }
    }
  }
};
</script>
<template>
  <v-select :items="tablas" v-model="tabla" hide-details solo>
    <template slot="prepend-inner">
      <v-icon left>web</v-icon>
    </template>
  </v-select>
</template>

<script>
import { mapState } from "vuex";
export default {
  data: () => ({
    tablas: [
      "Universidades",
      "Escuelas",
      "Facultades",
      "Centros de Estudio",
      "Centros Laborales",
      "Actividades Económicas",
      "Distritos"
    ]
  }),
  computed: {
    tabla: {
      get() {
        return this.$store.state.mantenimiento.tabla;
      },
      set(value) {
        this.$store.commit("mantenimiento/update", value);
      }
    }
  }
};
</script>

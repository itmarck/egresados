<template>
  <v-select
    :items="tablas"
    v-model="tabla"
    item-text="texto"
    item-value="nombre"
    hide-details
    solo
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
    tablas: [
      { texto: "Universidades", nombre: "universidad" },
      { texto: "Escuelas", nombre: "escuela" }
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

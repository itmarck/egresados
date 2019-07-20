<template>
  <v-container grid-list-lg>
    <mant-universidades v-if="tabla == 'Universidades'" />
    <mant-escuelas v-else-if="tabla == 'Escuelas'" />
  </v-container>
</template>

<script>
import { mapState } from "vuex";
export default {
  components: {
    MantUniversidades: () => import("../../components/MantUniversidades"),
    MantEscuelas: () => import("../../components/MantEscuelas")
  },
  computed: {
    ...mapState("mantenimiento", ["tabla"])
  }
};
</script>

<template>
  <v-container grid-list-lg>
    <mant-universidades v-if="tabla == 'Universidades'" />
    <mant-escuelas v-else-if="tabla == 'Escuelas'" />
    <mant-facultades v-else-if="tabla == 'Facultades'" />
    <mant-estudios v-else-if="tabla == 'Centros de Estudio'" />
    <mant-laborales v-else-if="tabla == 'Centros Laborales'" />
    <mant-actividades v-else-if="tabla == 'Actividades Económicas'" />
    <mant-distritos v-else-if="tabla == 'Distritos'" />
  </v-container>
</template>

<script>
import { mapState } from "vuex";
export default {
  components: {
    MantActividades: () => import("../../components/MantActividades"),
    MantDistritos: () => import("../../components/MantDistritos"),
    MantEscuelas: () => import("../../components/MantEscuelas"),
    MantEstudios: () => import("../../components/MantEstudios"),
    MantFacultades: () => import("../../components/MantFacultades"),
    MantLaborales: () => import("../../components/MantLaborales"),
    MantUniversidades: () => import("../../components/MantUniversidades")
  },
  computed: {
    ...mapState("mantenimiento", ["tabla"])
  }
};
</script>

<template>
  <v-container grid-list-lg>
    <reporte-actividad v-if="reporte == 'Egresados por Actividad Económica'" />
    <reporte-admision v-else-if="reporte == 'Egresados por Admisión'" />
    <reporte-distrito v-else-if="reporte == 'Egresados por Distrito'" />
    <reporte-dni v-else-if="reporte == 'Egresados por DNI'" />
  </v-container>
</template>

<script>
import { mapState } from "vuex";
export default {
  components: {
    ReporteActividad: () => import("../../components/ReporteActividad"),
    ReporteAdmision: () => import("../../components/ReporteAdmision"),
    ReporteDistrito: () => import("../../components/ReporteDistrito"),
    ReporteDni: () => import("../../components/ReporteDni")
  },
  computed: {
    ...mapState("reportes", ["reporte"])
  }
};
</script>

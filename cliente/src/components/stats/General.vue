<template>
  <v-card v-if="cargado">
    <v-card-text></v-card-text>
    <div
      primary-title
      class="text-xs-center display-1 font-weight-light text-uppercase"
    >
      Resumen del {{ new Date().getFullYear() }}
    </div>
    <div class="text-xs-center body-1 font-weight-light">
      Resumen por mes de las universidades con más egresados
    </div>
    <apex-chart
      width="100%"
      type="area"
      :options="options"
      :series="series"
    ></apex-chart>
  </v-card>
</template>

<script>
import { get } from "../../bd/api";
import ApexChart from "vue-apexcharts";
export default {
  components: { ApexChart },
  data: () => ({
    cargado: false,

    options: {
      chart: {
        id: "vuechart-example",
        toolbar: {
          show: false
        }
      },
      plotOptions: {
        distributed: true,
        barHeight: "50%"
      },
      xaxis: {
        categories: [
          "Ene",
          "Feb",
          "Mar",
          "Abr",
          "May",
          "Jun",
          "Jul",
          "Ago",
          "Set",
          "Oct",
          "Nov",
          "Dic"
        ]
      },
      yaxis: {
        tickAmount: 5,
        axisTicks: {
          show: false
        }
      }
    },
    series: []
  }),
  created() {
    get("estadisticas/general").then(res => {
      this.series = res.data;
      this.cargado = true;
    });
  }
};
</script>

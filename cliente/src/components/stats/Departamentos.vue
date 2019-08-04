<template>
  <v-card v-if="cargado">
    <v-container fluid>
      <v-layout column mt-2>
        <div
          primary-title
          class="text-xs-center title font-weight-light text-uppercase"
        >
          Demanda laboral
        </div>
        <div class="text-xs-center body-1 font-weight-light">
          Resumen por año de los departamentos donde se han registrado más
          contratos
        </div>
      </v-layout>
    </v-container>
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
  props: {
    color: Boolean
  },
  data: () => ({
    cargado: false,

    options: {
      chart: {
        id: "vuechart-example",
        toolbar: {
          show: false
        }
      },
      theme: {
        monochrome: {
          enabled: true,
          color: "#0D47A1"
        }
      },
      plotOptions: {
        distributed: true,
        barHeight: "50%"
      },
      xaxis: {
        categories: []
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
  computed: {
    lastYears() {
      let years = [];
      let year = parseInt(new Date().getFullYear());
      for (let i = 5; i >= 0; i--) {
        years.push(year - i);
      }
      return years;
    }
  },
  created() {
    if (this.color)
      this.options = {
        ...this.options,
        theme: {
          monochrome: {
            enabled: false
          }
        }
      };
    get("estadisticas/departamentos/5").then(res => {
      this.options.xaxis.categories = this.lastYears;
      this.series = res.data;
      this.cargado = true;
    });
  }
};
</script>

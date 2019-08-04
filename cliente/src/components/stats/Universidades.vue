<template>
  <v-card v-if="cargado">
    <v-container fluid>
      <v-layout column mt-2>
        <div
          primary-title
          class="text-xs-center title font-weight-light text-uppercase"
        >
          Universidades más populares
        </div>
      </v-layout>
    </v-container>
    <apex-chart
      v-if="cargado"
      width="100%"
      type="bar"
      :options="options"
      :series="series"
    ></apex-chart>
    <v-card-actions>
      <v-spacer></v-spacer>
      <div class="text-xs-right caption font-weight-light">
        {{ options.xaxis.categories[0] }} es la universidad con la mayor
        cantidad de egresados en el sistema
      </div>
    </v-card-actions>
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
      fill: {
        colors: ["#0D47A1"]
      },
      plotOptions: {
        bar: {
          columnWidth: "50%",
          dataLabels: {
            position: "top" // top, center, bottom
          }
        }
      },
      dataLabels: {
        enabled: true,
        formatter: function(val) {
          return val + "%";
        },
        offsetY: -20,
        style: {
          fontSize: "12px",
          colors: ["#181818"]
        }
      },
      xaxis: {
        categories: [],
        axisBorder: {
          show: false
        },
        axisTicks: {
          show: false
        }
      },
      yaxis: {
        axisBorder: {
          show: false
        },
        axisTicks: {
          show: false
        },
        labels: {
          show: false,
          formatter: function(val) {
            return val + "%";
          }
        }
      }
    },
    series: [
      {
        name: "Concurrencia",
        data: []
      }
    ]
  }),
  beforeCreate() {
    get("estadisticas/universidades").then(res => {
      this.options = {
        ...this.options,
        xaxis: {
          ...this.options.xaxis,
          categories: res.data.categories
        }
      };
      this.series[0].data = res.data.data;
      this.cargado = true;
    });
  }
};
</script>

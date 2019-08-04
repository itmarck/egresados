<template>
  <v-card v-if="cargado">
    <v-container fluid>
      <v-layout column mt-2>
        <div
          primary-title
          class="text-xs-center title font-weight-light text-uppercase"
        >
          Actividades más pedidas
        </div>
      </v-layout>
    </v-container>
    <apex-chart
      v-if="cargado"
      width="100%"
      type="pie"
      :options="options"
      :series="series"
    ></apex-chart>
    <v-card-actions> </v-card-actions>
  </v-card>
</template>

<script>
import { get } from "../../bd/api";
import ApexChart from "vue-apexcharts";
export default {
  components: { ApexChart },
  data: () => ({
    cargado: false,

    series: [3, 1, 5, 1],
    options: {
      labels: ["Mineria", "Pesca de peces", "askdjh", "asdw"],
      chart: {
        id: "vuechart-example",
        toolbar: {
          show: false
        }
      },
      legend: {
        position: "bottom"
      },
      theme: {
        monochrome: {
          enabled: true,
          color: "#0D47A1"
        }
      }
    }
  }),
  beforeCreate() {
    get("estadisticas/universidades").then(res => {
      this.cargado = true;
    });
  }
};
</script>

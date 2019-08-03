<template>
  <v-container grid-list-lg>
    <v-layout row wrap>
      <v-flex xs12>
        <v-layout row wrap>
          <v-flex xs4 v-for="(item, i) of totales" :key="i">
            <v-card height="100%">
              <v-card-text>
                <div class="caption font-weight-light text-uppercase">
                  {{ item.texto }}
                </div>
                <div>
                  <span class="headline">{{ item.valor }}</span>
                </div>
              </v-card-text>
            </v-card>
          </v-flex>
        </v-layout>
      </v-flex>
      <v-flex xs12 md6>
        <v-card>
          <v-card-text>
            Más estadisticas
          </v-card-text>
        </v-card>
      </v-flex>
      <v-flex xs12 md6>
        <v-card>
          <v-card-text>
            <apex-chart
              width="100%"
              type="area"
              :options="options"
              :series="series"
            ></apex-chart>
          </v-card-text>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import ApexChart from "vue-apexcharts";
import { get } from "../../bd/api";
export default {
  components: { ApexChart },
  data: () => ({
    totales: [],

    options: {
      chart: {
        id: "vuechart-example"
      },
      xaxis: {
        type: "datetime"
      }
    },
    series: [
      {
        name: "series",
        data: [
          [1486684900000, 34],
          [1486771200000, 43],
          [1486857600000, 31],
          [1486944000000, 43],
          [1487030400000, 33],
          [1487116800000, 52]
        ]
      }
    ]
  }),
  methods: {
    cargarTotales() {
      get("estadisticas/total").then(res => (this.totales = res.data));
    },
    cargarTodo() {
      this.cargarTotales();
    }
  },
  created() {
    this.cargarTodo();
  }
};
</script>



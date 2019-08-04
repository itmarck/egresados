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
      <v-flex xs12 md8>
        <v-layout row wrap>
          <v-flex xs12>
            <est-general />
          </v-flex>
          <v-flex xs12>
            <est-departamentos />
          </v-flex>
        </v-layout>
      </v-flex>
      <v-flex xs12 md4>
        <v-layout row wrap>
          <v-flex xs12> <est-universidades /> </v-flex>
          <v-flex xs12> <est-actividades /> </v-flex>
        </v-layout>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { get } from "../../bd/api";
export default {
  components: {
    EstGeneral: () => import("../../components/stats/General.vue"),
    EstActividades: () => import("../../components/stats/Actividades.vue"),
    EstDepartamentos: () => import("../../components/stats/Departamentos.vue"),
    EstUniversidades: () => import("../../components/stats/Universidades.vue")
  },
  data: () => ({
    totales: []
  }),
  created() {
    get("estadisticas/total").then(res => (this.totales = res.data));
  }
};
</script>



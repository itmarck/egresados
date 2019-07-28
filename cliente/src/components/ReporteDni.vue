<template>
  <v-layout row wrap>
    <!-- Selects -->
    <v-flex xs12 md6>
      <v-form @submit.prevent="aceptar">
        <v-layout row wrap>
          <v-flex xs12>
            <reporte-select></reporte-select>
          </v-flex>
          <v-flex xs12>
            <v-card>
              <v-card-text>
                <v-text-field
                  v-model="dni"
                  label="Ingrese DNI"
                  placeholder="75643824"
                  hint="Debe tener 8 caracteres exactos"
                  persistent-hint
                ></v-text-field>
              </v-card-text>
            </v-card>
          </v-flex>
          <v-flex xs12>
            <v-btn block type="submit" v-if="dni.length == 8">
              Aceptar
            </v-btn>
          </v-flex>
        </v-layout>
      </v-form>
    </v-flex>
    <!-- Lista -->
    <v-flex xs12 md6>
      <v-card v-if="lista.length != 0">
        <v-list three-line>
          <v-list-tile>
            <v-list-tile-content>
              <v-list-tile-title></v-list-tile-title>
              <v-list-tile-sub-title></v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
import { get } from "../bd/api";
import { mapMutations } from "vuex";
export default {
  components: {
    ReporteSelect: () => import("./ReporteSelect")
  },
  data: () => ({
    dni: "",

    lista: []
  }),
  methods: {
    ...mapMutations(["snackbar"]),
    aceptar() {
      get("reporte/dni/" + this.dni).then(res => {
        this.snackbar(res.mensaje);
      });
    }
  }
};
</script>


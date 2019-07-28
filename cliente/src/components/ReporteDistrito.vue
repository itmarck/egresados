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
                <v-select
                  v-model="departamento"
                  :items="departamentos"
                  item-value="codigo"
                  item-text="nombre"
                  label="Seleccione departamento"
                  placeholder="Departamento"
                  @change="cargarProvincias"
                ></v-select>
                <v-select
                  v-model="provincia"
                  :items="provincias"
                  item-value="codigo"
                  item-text="nombre"
                  label="Seleccione provincia"
                  placeholder="Provincia"
                  @change="cargarDistritos"
                  :disabled="departamento == ''"
                ></v-select>
                <v-select
                  v-model="distrito"
                  :items="distritos"
                  item-value="codigo"
                  item-text="nombre"
                  label="Seleccione distrito"
                  placeholder="Distrito"
                  :disabled="provincia == ''"
                ></v-select>
              </v-card-text>
            </v-card>
          </v-flex>
          <v-flex xs12>
            <v-btn block type="submit" v-if="distrito != ''">
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
    departamentos: [],
    departamento: "",
    provincias: [],
    provincia: "",
    distritos: [],
    distrito: "",

    lista: []
  }),
  methods: {
    ...mapMutations(["snackbar"]),
    aceptar() {
      get("reporte/distrito/" + this.distrito).then(res => {
        this.snackbar(res.mensaje);
      });
    },
    cargarDepartamentos() {
      get("departamentos").then(res => (this.departamentos = res.data));
    },
    cargarProvincias(departamento) {
      this.provincia = "";
      this.distrito = "";
      this.provincias = [];
      get("provincias/" + departamento).then(
        res => (this.provincias = res.data)
      );
    },
    cargarDistritos(provincia) {
      this.distrito = "";
      this.distritos = [];
      get("distritos/" + provincia).then(res => (this.distritos = res.data));
    },
    cargarTodo() {
      this.cargarDepartamentos();
    }
  },
  created() {
    this.cargarTodo();
  }
};
</script>


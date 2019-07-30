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
                  :items="universidades"
                  v-model="universidad"
                  label="Seleccione Universidad"
                  placeholder="Universidad"
                  @change="cargarEscuelas(universidad)"
                ></v-select>
                <v-select
                  v-model="escuela"
                  label="Seleccione escuela"
                  :items="escuelas"
                  item-text="nombre"
                  item-value="codigo"
                  placeholder="Escuela"
                  no-data-text="No hay escuelas registradas"
                  @change="cargarAdmisiones(escuela)"
                  :disabled="universidad == ''"
                ></v-select>
                <v-select
                  :items="admisiones"
                  v-model="admision"
                  item-value="codigo"
                  label="Admisión"
                  no-data-text="No hay admisiones registradas"
                  placeholder="Seleccione admisión"
                  @change="lista = []"
                  :disabled="escuela == ''"
                >
                  <template slot="item" slot-scope="data">
                    {{ data.item.ciclo }}
                    {{ data.item.modalidad }}
                    {{
                      "(" +
                        new Date(
                          data.item.fechaAdmision.replace(/-/g, "\/")
                        ).toLocaleDateString("es-ES", {
                          month: "long",
                          day: "numeric",
                          timeZone: "America/New_York"
                        }) +
                        ")"
                    }}
                  </template>
                  <template slot="selection" slot-scope="data">
                    {{ data.item.ciclo }}
                    {{ data.item.modalidad }}
                    {{
                      "(" +
                        new Date(
                          data.item.fechaAdmision.replace(/-/g, "\/")
                        ).toLocaleDateString("es-ES", {
                          month: "long",
                          day: "numeric",
                          timeZone: "America/New_York"
                        }) +
                        ")"
                    }}
                  </template>
                </v-select>
              </v-card-text>
            </v-card>
          </v-flex>
          <v-flex xs12>
            <v-btn block type="submit" v-if="admision != ''">Aceptar</v-btn>
          </v-flex>
        </v-layout>
      </v-form>
    </v-flex>
    <!-- Lista -->
    <v-flex xs12 md6>
      <v-card v-if="lista.length != 0">
        <v-list three-line>
          <v-list-tile v-for="(item, i) of lista" :key="i">
            <v-list-tile-content>
              <v-list-tile-title>
                {{ item.nombre }}
                <span class="body-1"> ({{ item.termino }}) </span>
              </v-list-tile-title>
              <v-list-tile-sub-title class="caption">
                {{
                  item.titulacion
                    ? "Titulado el " +
                      new Date(
                        item.titulacion.replace(/-/g, "\/")
                      ).toLocaleDateString("es-ES", {
                        month: "long",
                        day: "numeric",
                        year: "numeric",
                        timeZone: "America/New_York"
                      }) +
                      " como " +
                      item.modalidadTitulacion
                    : "No tiene título"
                }}
              </v-list-tile-sub-title>
              <v-list-tile-sub-title class="caption">
                {{
                  item.colegiatura
                    ? "Colegiado el " +
                      new Date(
                        item.fechaColegiatura.replace(/-/g, "\/")
                      ).toLocaleDateString("es-ES", {
                        month: "long",
                        day: "numeric",
                        year: "numeric",
                        timeZone: "America/New_York"
                      }) +
                      " con código " +
                      item.colegiatura
                    : "No tiene colegiatura"
                }}
              </v-list-tile-sub-title>
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
    universidades: [],
    universidad: "",
    escuelas: [],
    escuela: "",
    admisiones: [],
    admision: "",

    lista: []
  }),
  methods: {
    ...mapMutations(["snackbar"]),
    aceptar() {
      get("reporte/admision/" + this.admision).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) this.lista = res.data;
      });
    },
    cargarUniversidades() {
      get("universidades").then(res => (this.universidades = res.data));
    },
    cargarEscuelas(universidad) {
      this.escuela = "";
      this.escuelas = [];
      this.lista = [];
      if (universidad) {
        get("escuelasProfesionales/uni/" + universidad).then(res => {
          if (res.estado) this.escuelas = res.data;
          else this.escuelas = [];
        });
      }
    },
    cargarAdmisiones(escuela) {
      this.admision = "";
      this.admisiones = [];
      this.lista = [];
      if (escuela) {
        get("admisiones/" + escuela + "/" + this.universidad).then(res => {
          if (res.estado) this.admisiones = res.data;
          else {
            this.admisiones = [];
          }
        });
      }
    },
    cargarTodo() {
      this.cargarUniversidades();
    }
  },
  created() {
    this.cargarTodo();
  }
};
</script>


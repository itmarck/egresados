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
                  v-model="actividad"
                  :items="actividades"
                  item-value="codigo"
                  item-text="nombre"
                  label="Seleccione actividad económica"
                  placeholder="Tecnología"
                  :hint="actividad.descripcion"
                  persistent-hint
                  return-object
                  @change="lista = []"
                ></v-select>
              </v-card-text>
            </v-card>
          </v-flex>
          <v-flex xs12>
            <v-btn block type="submit" v-if="actividad != ''">
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
          <v-list-tile
            v-for="(item, i) of lista"
            :key="i"
            @click="item.toggle = !item.toggle"
          >
            <v-list-tile-content>
              <v-list-tile-title v-html="item.Nombre" />
              <div v-if="item.toggle">
                <v-list-tile-sub-title>
                  <v-icon small>phone</v-icon> {{ item.celular }}
                </v-list-tile-sub-title>
                <v-list-tile-sub-title class="caption">
                  {{ item.correo }}
                </v-list-tile-sub-title>
              </div>
              <div v-else>
                <v-list-tile-sub-title>
                  <span class="text--primary">{{ item.cargo }}</span> en
                  <span class="text--primary">{{ item.razonsocial }}</span>
                </v-list-tile-sub-title>
                <v-list-tile-sub-title class="caption">
                  {{ item.detalleFunciones }}
                </v-list-tile-sub-title>
              </div>
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
    actividades: [],
    actividad: "",

    lista: []
  }),
  methods: {
    ...mapMutations(["snackbar"]),
    aceptar() {
      get("reporte/actividad/" + this.actividad.codigo).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.lista = res.data.map(e => ({
            ...e,
            toggle: parseInt(e.toggle)
          }));
        }
      });
    },
    cargarActividades() {
      get("actividades-objeto").then(res => (this.actividades = res.data));
    },
    cargarTodo() {
      this.cargarActividades();
    }
  },
  created() {
    this.cargarTodo();
  }
};
</script>


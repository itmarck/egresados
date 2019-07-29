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
                  placeholder="Ej. 12345678"
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
    <!-- Persona -->
    <v-flex xs12 md6>
      <v-layout column v-if="persona">
        <!-- Datos -->
        <v-flex xs12>
          <v-card class="elevation-6">
            <v-card-title class="headline font-weight-bold" primary-title>
              {{ persona.egresado[0].Nombre.toUpperCase() }}
            </v-card-title>
            <v-card-text class="text-xs-right">
              <div class="font-weight-light">
                {{ persona.egresado[0].correo }}
              </div>
              <div class="subheading font-weight-light">
                <v-icon small>phone</v-icon>
                {{ persona.egresado[0].celular }}
              </div>
            </v-card-text>
          </v-card>
        </v-flex>
        <v-flex xs12>
          <!-- Carreras -->
          <v-card v-if="persona.carreras.length != 0">
            <v-list three-line>
              <v-subheader class="body-1">CARRERAS</v-subheader>
              <v-list-tile v-for="(item, i) of persona.carreras" :key="i">
                <v-list-tile-content>
                  <v-list-tile-title v-html="item.nombre" />
                  <v-list-tile-sub-title class="text--primary">
                    {{ item.admision }}
                  </v-list-tile-sub-title>
                  <v-list-tile-sub-title>
                    {{ item.colegiatura }}
                  </v-list-tile-sub-title>
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </v-card>
        </v-flex>
        <!-- Postgrado -->
        <v-flex xs12>
          <v-card v-if="persona.estudiosPost.length != 0">
            <v-list two-line>
              <v-subheader class="body-1">ESTUDIOS DE POSTGRADO</v-subheader>
              <v-list-tile v-for="(item, i) of persona.estudiosPost" :key="i">
                <v-list-tile-content>
                  <v-list-tile-title v-html="item.nombre" />
                  <v-list-tile-sub-title>
                    <span class="text--primary">Finalizado</span>
                    {{ item.fechaTermino }}
                  </v-list-tile-sub-title>
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </v-card>
        </v-flex>
      </v-layout>
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
    dni: "73860228",

    persona: null
  }),
  methods: {
    ...mapMutations(["snackbar"]),
    aceptar() {
      get("reporte/dni/" + this.dni).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.persona = res.data;
          this.dni = "";
        }
      });
    }
  }
};
</script>


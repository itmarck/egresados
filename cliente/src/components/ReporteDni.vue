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
          <v-card class="elevation-4">
            <v-card-title class="headline font-weight-regular" primary-title>
              <v-layout justify-space-between>
                <v-flex>
                  <span> {{ persona.egresado.Nombre.toUpperCase() }} </span>
                </v-flex>
                <v-flex>
                  <v-avatar size="50" color="red">
                    <img :src="urlFoto" alt="Foto de perfil" />
                  </v-avatar>
                </v-flex>
              </v-layout>
            </v-card-title>
            <v-card-text class="text-xs-right">
              <div class="font-weight-light">
                {{ persona.egresado.correo }}
              </div>
              <div class="subheading font-weight-light">
                <v-icon small>phone</v-icon>
                {{ persona.egresado.celular }}
              </div>
            </v-card-text>
          </v-card>
        </v-flex>
        <!-- Carreras -->
        <v-flex xs12>
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
                    <span class="text--primary">Finalizado el</span>
                    {{
                      new Date(
                        item.fechaTermino.replace(/-/g, "\/")
                      ).toLocaleDateString("es-ES", {
                        month: "long",
                        day: "numeric",
                        year: "numeric",
                        timeZone: "America/New_York"
                      })
                    }}
                  </v-list-tile-sub-title>
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </v-card>
        </v-flex>
        <!-- Trabajo actual -->
        <v-flex xs12>
          <v-card v-if="persona.laboral.length != 0">
            <v-list three-line>
              <v-subheader class="body-1">TRABAJO ACTUAL</v-subheader>
              <v-list-tile v-for="(item, i) of persona.laboral" :key="i">
                <v-list-tile-content>
                  <v-list-tile-title v-html="item.nombre" />
                  <v-list-tile-sub-title
                    class="text--primary"
                    v-html="item.cargo"
                  />
                  <v-list-tile-sub-title v-html="item.descripcion" />
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
import { urlImage } from "../bd/config";
export default {
  components: {
    ReporteSelect: () => import("./ReporteSelect")
  },
  data: () => ({
    dni: "74813707",

    persona: null
  }),
  computed: {
    urlFoto() {
      return urlImage + this.persona.egresado.urlFoto;
    }
  },
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


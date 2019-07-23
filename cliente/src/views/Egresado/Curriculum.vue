<template>
  <v-container grid-list-lg>
    <v-form @submit.prevent="generar">
      <v-layout row wrap>
        <v-flex xs12>
          <v-card>
            <v-list three-line subheader>
              <v-subheader>Datos adicionales</v-subheader>
              <v-container grid-list-lg>
                <v-layout row wrap>
                  <v-flex xs12 md6>
                    <v-text-field
                      v-model="titulo"
                      label="Ingrese título profesional"
                      placeholder="Ingeniero en Computación en Informática"
                    ></v-text-field>
                  </v-flex>
                  <v-flex xs12 md6>
                    <v-text-field
                      v-model="direccion"
                      label="Ingrese dirección"
                      placeholder="Dirección completa"
                    ></v-text-field>
                  </v-flex>
                </v-layout>
              </v-container>
            </v-list>
          </v-card>
        </v-flex>
        <!-- Postgrados -->
        <v-flex xs12 md6>
          <v-card>
            <v-list three-line subheader>
              <v-subheader>Postgrados</v-subheader>
              <v-list-tile
                v-for="postgrado of postgrados"
                :key="postgrado.codigo"
              >
                <v-list-tile-action>
                  <v-checkbox
                    color="primary"
                    v-model="postgrado.select"
                  ></v-checkbox>
                </v-list-tile-action>
                <v-list-tile-content>
                  <v-list-tile-title v-html="postgrado.nombre" />
                  <v-list-tile-sub-title>
                    <span v-if="postgrado.lugar == 'U'">
                      {{ postgrado.universidad }}
                    </span>
                    <span else>{{ postgrado.razonSocial }}</span>
                    {{
                      `(${postgrado.fechaInicio.substring(0, 4)} - 
                    ${postgrado.fechaTermino.substring(0, 4)})`
                    }}
                  </v-list-tile-sub-title>
                  <v-list-tile-sub-title v-html="postgrado.tipo" />
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </v-card>
        </v-flex>
        <!-- Contratos -->
        <v-flex xs12 md6>
          <v-card>
            <v-list three-line subheader>
              <v-subheader>Experiencia</v-subheader>
              <v-list-tile v-for="contrato of contratos" :key="contrato.codigo">
                <v-list-tile-action>
                  <v-checkbox
                    color="primary"
                    v-model="contrato.select"
                  ></v-checkbox>
                </v-list-tile-action>
                <v-list-tile-content>
                  <v-list-tile-title v-html="contrato.centroLaboral" />
                  <v-list-tile-sub-title v-html="contrato.cargo" />
                  <v-list-tile-sub-title>
                    {{ contrato.fechaInicio.toString().substring(0, 4) }}
                    ({{ contrato.tiempo }} {{ contrato.unidad }})
                  </v-list-tile-sub-title>
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </v-card>
        </v-flex>
        <v-flex xs12>
          <v-btn block color="primary" type="submit">Generar Curriculum</v-btn>
        </v-flex>
      </v-layout>
    </v-form>
  </v-container>
</template>

<script>
import { get } from "../../bd/api";
import { mapState } from "vuex";
import { generarPDF } from "../../pdf/index";
export default {
  data: () => ({
    contratos: [],
    postgrados: [],
    persona: {},
    titulo: "",
    direccion: ""
  }),
  computed: {
    ...mapState(["user"]),
    contratosSeleccionados() {
      return this.contratos.filter(e => e.select);
    },
    postgradosSeleccionados() {
      return this.postgrados.filter(e => e.select);
    }
  },
  methods: {
    getYear(string) {
      return string.substring(0, 4);
    },
    generar() {
      let datos = {
        nombre: this.persona.nombres + " " + this.persona.apellidoPaterno,
        titulo: this.titulo,
        contacto: [this.persona.correo, this.persona.celular, this.direccion],
        experiencia: this.contratosSeleccionados.map(e => {
          return {
            fecha:
              this.getYear(e.fechaInicio) +
              " - " +
              this.getYear(e.fechaTermino),
            centro: e.centroLaboral,
            cargo: e.cargo,
            descripcion: e.detalleFunciones,
            tiempo: "(" + e.tiempo + " " + e.unidad + ")"
          };
        }),
        contratos: this.contratosSeleccionados,
        postgrados: this.postgradosSeleccionados,
        persona: this.persona
      };
      console.log(datos);
      generarPDF(datos, 0);
    },
    cargarPersona() {
      get("personas/" + this.user.dni).then(res => (this.persona = res.data));
    },
    cargarContratos() {
      get("contratos/" + this.user.dni).then(
        res => (this.contratos = res.data)
      );
    },
    cargarPostgrados() {
      get("estudiosPostgrado/" + this.user.dni).then(
        res => (this.postgrados = res.data)
      );
    }
  },
  created() {
    this.cargarContratos();
    this.cargarPostgrados();
    this.cargarPersona();
  }
};
</script>


<template>
  <v-container grid-list-lg>
    <v-form @submit.prevent="generar">
      <v-layout row wrap>
        <!-- Datos adicionales -->
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
          <v-card v-if="postgrados.length != 0">
            <v-list three-line subheader>
              <v-subheader>Postgrados</v-subheader>
              <v-list-tile
                v-for="postgrado of postgrados"
                :key="postgrado.codigo"
                @click="postgrado.select = !postgrado.select"
              >
                <v-list-tile-action>
                  <v-icon v-if="postgrado.select" color="primary">
                    check_box
                  </v-icon>
                  <v-icon v-else> check_box_outline_blank </v-icon>
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
          <v-card v-if="contratos.length != 0">
            <v-list three-line subheader>
              <v-subheader>Experiencia</v-subheader>
              <v-list-tile
                v-for="contrato of contratos"
                :key="contrato.codigo"
                @click="contrato.select = !contrato.select"
              >
                <v-list-tile-action>
                  <v-icon v-if="contrato.select" color="primary">
                    check_box
                  </v-icon>
                  <v-icon v-else> check_box_outline_blank </v-icon>
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
        <!-- Seleccion de opciones -->
        <v-flex xs12>
          <v-card>
            <v-card-text>
              <v-select
                :items="plantillas"
                v-model="plantilla"
                label="Seleccione plantilla"
                item-text="texto"
                item-value="valor"
              ></v-select>
              <v-select
                :items="colores"
                v-model="color"
                label="Seleccione color de énfasis"
                item-text="texto"
                item-value="valor"
              ></v-select>
              <v-btn block color="primary" type="submit">
                Generar Curriculum
              </v-btn>
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>
    </v-form>
  </v-container>
</template>

<script>
import { get } from "../../bd/api";
import { mapState, mapMutations } from "vuex";
import { generarPDF } from "../../pdf/index";
export default {
  data: () => ({
    plantillas: [
      { texto: "Básica simple", valor: 1 },
      { texto: "Básica con barra lateral", valor: 0 }
    ],
    plantilla: 1,
    colores: [
      { texto: "Gris", valor: "#424242" },
      { texto: "Plata", valor: "#708090" },
      { texto: "Verde oscuro", valor: "#2F4F4F" },
      { texto: "Negro", valor: "#181818" }
    ],
    color: "#424242",
    contratos: [],
    postgrados: [],
    carreras: [],
    persona: {},
    titulo: "",
    direccion: ""
  }),
  computed: {
    ...mapState(["user"]),
    contratosSeleccionados() {
      if (this.contratos) return this.contratos.filter(e => e.select);
    },
    postgradosSeleccionados() {
      if (this.postgrados) return this.postgrados.filter(e => e.select);
    }
  },
  methods: {
    ...mapMutations(["snackbar"]),
    validar() {
      if (this.titulo == "") {
        this.snackbar(
          "Ingrese el título profesional que se mostrará en el Curriculum"
        );
        return false;
      }
      if (this.direccion == "") {
        this.snackbar("La dirección también se mostrará en el Curriculum");
        return false;
      }
      return true;
    },
    getYear(string) {
      return string.substring(0, 4);
    },
    getEdad(nace) {
      return parseInt(new Date().getFullYear()) - parseInt(this.getYear(nace));
    },
    obtenerEducacion() {
      let educacion = null;
      if (this.postgradosSeleccionados) {
        educacion = this.postgradosSeleccionados.map(e => ({
          fecha:
            this.getYear(e.fechaInicio) + " - " + this.getYear(e.fechaTermino),
          nombre: e.nombre,
          tipo: e.tipo,
          anio: e.anioCertificacion ? "Certificada " + e.anioCertificacion : "",
          lugar: e.lugar == "U" ? e.universidad : e.razonSocial
        }));
      }
      if (!this.carreras) return educacion;
      educacion.push(
        ...this.carreras.map(e => ({
          fecha:
            this.getYear(e.fechaInicio) + " - " + this.getYear(e.fechaTermino),
          nombre: e.nombreEscuela,
          tipo: e.modalidadTitulacion
            ? "Titulada el " + e.fechaTitulacion
            : "No titulada",
          anio: "",
          lugar: e.universidad
        }))
      );
      return educacion;
    },
    obtenerExperiencia() {
      if (!this.contratosSeleccionados) return null;
      return this.contratosSeleccionados.map(e => ({
        fecha:
          e.fechaTermino == null
            ? this.getYear(e.fechaInicio) + " - Ahora"
            : this.getYear(e.fechaInicio) +
              " - " +
              this.getYear(e.fechaTermino),
        centro: e.centroLaboral,
        cargo: e.cargo,
        tiempo: "(" + e.tiempo + " " + e.unidad + ")",
        descripcion: e.detalleFunciones
      }));
    },
    generar() {
      if (!this.validar()) return;
      this.snackbar("Descargando... Por favor espere");
      let datos = {
        nombre: this.persona.nombres + " " + this.persona.apellidoPaterno,
        titulo: this.titulo,
        contacto: [this.persona.correo, this.persona.celular, this.direccion],
        personales: [
          "DNI " + this.persona.dni,
          this.getEdad(this.persona.fechaNacimiento) + " años"
        ],
        experiencia: this.obtenerExperiencia(),
        educacion: this.obtenerEducacion(),
        foto: this.user.urlFoto
      };
      generarPDF(datos, this.plantilla, this.color);
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
    },
    cargarCarreras() {
      get("carreras/" + this.user.dni).then(res => (this.carreras = res.data));
    }
  },
  created() {
    this.cargarContratos();
    this.cargarPostgrados();
    this.cargarPersona();
    this.cargarCarreras();
  }
};
</script>


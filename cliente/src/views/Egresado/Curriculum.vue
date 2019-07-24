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
          <v-select
            :items="plantillas"
            v-model="plantilla"
            item-text="texto"
            item-value="valor"
            solo
          ></v-select>
          <v-select
            :items="colores"
            v-model="color"
            item-text="texto"
            item-value="valor"
            placeholder="Color de énfasis"
            solo
          ></v-select>
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
    plantillas: [{ texto: "Plantilla Básica", valor: 0 }],
    plantilla: 0,
    colores: [
      { texto: "Negro", valor: "#181818" },
      { texto: "Gris", valor: "#424242" },
      { texto: "Azul", valor: "#0D47A1" },
      { texto: "Verde", valor: "#004D3B" },
      { texto: "Rojo", valor: "#742129" }
    ],
    color: "#181818",
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
          this.getYear(e.fechaInicio) + " - " + this.getYear(e.fechaTermino),
        centro: e.centroLaboral,
        cargo: e.cargo,
        tiempo: "(" + e.tiempo + " " + e.unidad + ")",
        descripcion: e.detalleFunciones
      }));
    },
    generar() {
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


<template>
  <v-container grid-list-lg>
    <v-layout row wrap>
      <!-- Registro -->
      <v-flex xs12 md6>
        <v-layout row wrap>
          <v-flex xs12>
            <v-card>
              <v-card-title class="title font-weight-light" primary-title>
                Datos de carrera
              </v-card-title>
              <v-card-text>
                <v-form>
                  <v-select
                    :items="carreras"
                    v-model="carrera"
                    item-text="nombreEscuela"
                    item-value="codigo"
                    placeholder="Seleccione carrera"
                    label="Nombre de la escuela de la carrera"
                  ></v-select>
                  <!-- Centro laboral -->
                  <v-select
                    :items="centros"
                    v-model="centro"
                    item-text="razonSocial"
                    item-value="codigo"
                    placeholder="Seleccione centro laboral"
                    label="Nombre del centro laboral"
                    v-if="!addCentro"
                  ></v-select>
                  <v-checkbox
                    label="Agregar centro laboral manualmente"
                    color="primary"
                    v-model="addCentro"
                  />
                  <!-- Agregar nuevo centro laboral -->
                  <v-card v-if="addCentro" style="margin-bottom: 2.5em">
                    <v-card-text>
                      <v-form>
                        <v-combobox
                          v-model="actividad"
                          :items="actividades"
                          label="Escriba la actividad económica"
                          placeholder="Actividad economica"
                        ></v-combobox>
                        <v-combobox
                          v-model="departamento"
                          :items="departamentos"
                          label="Seleccione departamento"
                          placeholder="Departamento"
                        ></v-combobox>
                        <v-combobox
                          v-model="provincia"
                          :items="provincias"
                          label="Seleccione provincia"
                          placeholder="Provincia"
                        ></v-combobox>
                        <v-combobox
                          v-model="distrito"
                          :items="distritos"
                          label="Seleccione distritos"
                          placeholder="Distrito"
                        ></v-combobox>
                        <v-text-field
                          v-model="ruc"
                          label="RUC"
                          prepend-icon="location_city"
                        ></v-text-field>
                        <v-text-field
                          v-model="razonSocial"
                          label="Razón social"
                          prepend-icon="poll"
                        ></v-text-field>
                      </v-form>
                    </v-card-text>
                  </v-card>
                  <v-text-field
                    v-model="cargo"
                    label="Cargo dentro del centro laboral"
                    placeholder="Seleccione cargo"
                    prepend-icon="domain"
                  ></v-text-field>
                  <!-- Fechas -->
                  <v-layout row wrap>
                    <v-flex xs6>
                      <v-menu
                        v-model="inicio"
                        lazy
                        offset-y
                        full-width
                        min-width="280px"
                        :close-on-content-click="false"
                      >
                        <template v-slot:activator="{ on }">
                          <v-text-field
                            v-model="fechaInicio"
                            label="Fecha de inicio"
                            prepend-icon="event"
                            readonly
                            v-on="on"
                          ></v-text-field>
                        </template>
                        <v-date-picker
                          v-model="fechaInicio"
                          @input="inicio = false"
                        ></v-date-picker>
                      </v-menu>
                    </v-flex>
                    <v-flex xs6>
                      <v-menu
                        v-model="termino"
                        lazy
                        offset-y
                        full-width
                        min-width="280px"
                        :close-on-content-click="false"
                      >
                        <template v-slot:activator="{ on }">
                          <v-text-field
                            v-model="fechaTermino"
                            label="Fecha de término"
                            prepend-icon="event"
                            readonly
                            v-on="on"
                          ></v-text-field>
                        </template>
                        <v-date-picker
                          v-model="fechaTermino"
                          @input="termino = false"
                        ></v-date-picker>
                      </v-menu>
                    </v-flex>
                  </v-layout>
                  <v-textarea
                    solo
                    hint="Detalle de las funciones"
                    persistent-hint
                    v-model="detalles"
                  ></v-textarea>
                </v-form>
              </v-card-text>
            </v-card>
          </v-flex>

          <v-btn color="primary" v-if="isEdit" @click="editar">Editar</v-btn>
          <v-btn color="primary" v-else @click="agregar">Agregar</v-btn>
          <v-btn color="primary" outline @click="nuevo">Limpiar</v-btn>
        </v-layout>
      </v-flex>

      <!-- Lista -->
      <v-flex xs12 md6>
        <v-card>
          <v-list three-line>
            <v-list-tile
              v-for="contrato of contratos"
              :key="contrato.codigo"
              @click="copiarDatos(contrato)"
            >
              <v-list-tile-content>
                <v-list-tile-title v-html="contrato.Centrolaboral" />
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
    </v-layout>
  </v-container>
</template>
<script>
import { url } from "../../bd/config";
export default {
  data: () => ({
    isEdit: false,
    contratos: [],
    contrato: "",
    carreras: [],
    carrera: "",
    centros: [],
    centro: "",
    cargo: "",
    fechaInicio: new Date().toISOString().substring(0, 10),
    inicio: false,
    fechaTermino: new Date().toISOString().substring(0, 10),
    termino: false,
    detalles: "",
    addCentro: false,
    actividades: [],
    actividad: "",
    departamentos: [],
    departamento: "",
    provincias: [],
    provincia: "",
    distritos: [],
    distrito: "",
    ruc: "",
    razonSocial: ""
  }),
  computed: {},
  methods: {
    copiarDatos(carrera) {
      this.isEdit = true;
      this.addCentro = false;
      this.carrera = carrera.codigoCarrera;
      this.centro = carrera.codigoCentroLaboral;
      this.fechaInicio = carrera.fechaInicio;
      this.fechaTermino = carrera.fechaTermino;
      this.cargo = carrera.cargo;
      this.detalles = carrera.detalleFunciones;
    },
    editar() {},
    agregar() {},
    nuevo() {
      this.isEdit = false;
      this.addCentro = false;
      this.universidad = "";
      this.escuela = "";
      this.fechaInicio = new Date().toISOString().substring(0, 10);
      this.fechaTermino = new Date().toISOString().substring(0, 10);
      this.fechaAdmision = new Date().toISOString().substring(0, 10);
      this.ciclo = "";
      this.modalidad = null;
    },
    cargarCarreras() {
      fetch(url + "carreras/73860228")
        .then(res => res.json())
        .then(res => (this.carreras = res.data));
    },
    cargarContratos() {
      fetch(url + "contratos/73860228")
        .then(res => res.json())
        .then(res => (this.contratos = res.data));
    },
    cargarCentros() {
      fetch(url + "centroLaboral")
        .then(res => res.json())
        .then(res => (this.centros = res.data));
    }
  },
  created() {
    this.cargarCarreras();
    this.cargarContratos();
    this.cargarCentros();
  }
};
</script>

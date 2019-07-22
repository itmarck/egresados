<template>
  <v-container grid-list-lg>
    <v-form @submit.prevent="">
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
                  <section>
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
                        <section>
                          <v-text-field
                            v-model="ruc"
                            label="RUC"
                            append-icon="location_city"
                          ></v-text-field>
                          <v-text-field
                            v-model="razonSocial"
                            label="Razón social"
                            append-icon="poll"
                          ></v-text-field>
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
                        </section>
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
                  </section>
                </v-card-text>
              </v-card>
            </v-flex>

            <v-btn color="primary" v-if="isEdit" @click="editar" type="submit">
              Editar
            </v-btn>
            <v-btn color="primary" v-else @click="agregar" type="submit">
              Agregar
            </v-btn>
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
      </v-layout>
      <!-- Snackbar -->
      <v-snackbar v-model="snack" bottom left :timeout="6000" color="secondary">
        {{ respuesta }}
        <v-btn color="bright" flat @click="snack = false">Cerrar</v-btn>
      </v-snackbar>
    </v-form>
  </v-container>
</template>
<script>
import { get, post, put } from "../../bd/api";
import { mapState } from "vuex";
export default {
  data: () => ({
    isEdit: false,
    codigo: "",
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
    razonSocial: "",
    respuesta: "",
    snack: false
  }),
  computed: {
    ...mapState(["user"])
  },
  methods: {
    copiarDatos(contrato) {
      this.isEdit = true;
      this.addCentro = false;
      this.codigo = contrato.codigo;
      this.carrera = contrato.codigoEgresado;
      this.centro = contrato.codigoCentroLaboral;
      this.fechaInicio = contrato.fechaInicio;
      this.fechaTermino = contrato.fechaTermino;
      this.cargo = contrato.cargo;
      this.detalles = contrato.detalleFunciones;
    },
    editar() {
      let datos = {
        codigoEgresado: this.carrera,
        carrera: this.carrera,
        cargo: this.cargo,
        inicio: this.fechaInicio,
        termino: this.fechaTermino,
        descripcion: this.detalles
      };
      if (this.addCentro) {
        datos = {
          ...datos,
          actividadEconomica: this.actividadEconomica,
          distrito: this.codigo,
          ruc: this.ruc,
          razonSocial: this.razonSocial
        };
      } else datos = { ...datos, centro: this.centro };
      put("contratos/" + this.codigo, datos).then(res => {
        this.respuesta = res.mensaje;
        this.snack = true;
        if (res.estado == true) {
          this.cargarTodo();
        }
      });
    },
    agregar() {
      let datos = {
        codigoEgresado: this.carrera,
        carrera: this.carrera,
        cargo: this.cargo,
        inicio: this.fechaInicio,
        termino: this.fechaTermino,
        descripcion: this.detalles
      };
      if (this.addCentro) {
        datos = {
          ...datos,
          actividadEconomica: this.actividadEconomica,
          distrito: this.codigo,
          ruc: this.ruc,
          razonSocial: this.razonSocial
        };
      } else datos = { ...datos, centro: this.centro };
      console.log(datos);

      post("contratos", datos).then(res => {
        this.respuesta = res.mensaje;
        this.snack = true;
        if (res.estado == true) {
          this.cargarTodo();
          this.nuevo();
        }
      });
    },
    nuevo() {
      this.isEdit = false;
      this.addCentro = false;
      this.codigo = "";
      this.carrera = "";
      this.centro = "";
      this.fechaInicio = new Date().toISOString().substring(0, 10);
      this.fechaTermino = new Date().toISOString().substring(0, 10);
      this.cargo = "";
      this.detalles = "";
    },
    cargarTodo() {
      this.cargarContratos();
      this.cargarCentros();
    },
    cargarCarreras() {
      get("carreras/" + this.user.dni).then(res => (this.carreras = res.data));
    },
    cargarContratos() {
      get("contratos/" + this.user.dni).then(
        res => (this.contratos = res.data)
      );
    },
    cargarCentros() {
      get("centroLaboral").then(res => (this.centros = res.data));
    }
  },
  created() {
    this.cargarTodo();
    this.cargarCarreras();
  }
};
</script>

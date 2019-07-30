<template>
  <v-container grid-list-lg>
    <v-layout row wrap>
      <!-- Registro -->
      <v-flex xs12 md6>
        <v-form @submit.prevent="">
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
                      item-text="nombre"
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
                            v-if="!actual"
                            v-model="fechaTermino"
                            @input="termino = false"
                          >
                          </v-date-picker>
                          <v-card>
                            <v-card-text>
                              <v-switch
                                hide-details
                                label="Centro laboral actual"
                                v-model="actual"
                                @change="switchActual"
                              ></v-switch>
                            </v-card-text>
                          </v-card>
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
        </v-form>
      </v-flex>
      <!-- Lista -->
      <v-flex xs12 md6>
        <v-card v-if="contratos.length != 0">
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
  </v-container>
</template>

<script>
import { get, post, put } from "../../bd/api";
import { mapState, mapMutations } from "vuex";
export default {
  data: () => ({
    isEdit: false,
    actual: true,
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
    fechaTermino: "Actualidad",
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
  computed: {
    ...mapState(["user"])
  },
  methods: {
    ...mapMutations(["snackbar"]),
    switchActual() {
      if (this.actual) {
        this.fechaTermino = "Actualidad";
      } else this.fechaTermino = new Date().toISOString().substring(0, 10);
    },
    validar() {
      if (this.carrera == "") {
        this.snackbar("Ingrese nombre de la Carrera");
        return false;
      }
      if (this.centro == "") {
        this.snackbar("Seleccione su Centro laboral");
        return false;
      }
      if (this.addCentro) {
        if (this.razonSocial == "") {
          this.snackbar("Ingrese el nombre del Centro laboral");
          return false;
        }
        if (this.actividad == "") {
          this.snackbar("Ingresa la actividad económica del Centro laboral");
          return false;
        }
        if (this.distrito == "") {
          this.snackbar("¿Dónde está ubicado tu Centro laboral?");
          return false;
        }
      }
      if (this.cargo == "") {
        this.snackbar("Ingrese cargo dentro de la empresa");
        return false;
      }
      if (this.detalles == "") {
        let centro = this.centros.filter(e => e.codigo == this.centro)[0]
          .nombre;
        if (this.addCentro) centro = this.razonSocial;
        this.snackbar("Cuéntanos un poco sobre tu trabajo en " + centro);
        return false;
      }
      return true;
    },
    copiarDatos(contrato) {
      this.isEdit = true;
      this.addCentro = false;
      this.codigo = contrato.codigo;
      this.carrera = contrato.codigoEgresado;
      this.centro = contrato.codigoCentroLaboral;
      this.fechaInicio = contrato.fechaInicio;
      this.actual = false;
      if (contrato.fechaTermino == null) {
        this.actual = true;
        this.fechaTermino = "Actualidad";
      } else this.fechaTermino = contrato.fechaTermino;
      this.cargo = contrato.cargo;
      this.detalles = contrato.detalleFunciones;
    },
    editar() {
      if (!this.validar()) return;
      let datos = {
        codigoEgresado: this.carrera,
        carrera: this.carrera,
        cargo: this.cargo,
        inicio: this.fechaInicio,
        termino: this.actual ? null : this.fechaTermino,
        descripcion: this.detalles
      };
      if (this.addCentro) {
        datos = {
          ...datos,
          actividadEconomica: this.actividadEconomica,
          distrito: this.distrito,
          ruc: this.ruc,
          razonSocial: this.razonSocial
        };
      } else datos = { ...datos, centro: this.centro };
      put("contratos/" + this.codigo, datos).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
        }
      });
    },
    agregar() {
      if (!this.validar()) return;
      let datos = {
        codigoEgresado: this.carrera,
        carrera: this.carrera,
        cargo: this.cargo,
        inicio: this.fechaInicio,
        termino: this.actual ? null : this.fechaTermino,
        descripcion: this.detalles
      };
      if (this.addCentro) {
        datos = {
          ...datos,
          actividadEconomica: this.actividad,
          distrito: this.distrito,
          ruc: this.ruc,
          razonSocial: this.razonSocial
        };
      } else datos = { ...datos, centro: this.centro };
      post("contratos", datos).then(res => {
        this.snackbar(res.mensaje);
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
      this.cargo = "";
      this.fechaInicio = new Date().toISOString().substring(0, 10);
      this.fechaTermino = "Actualidad";
      this.actual = true;
      this.detalles = "";
      this.ruc = "";
      this.razonSocial = "";
      this.actividad = "";
      this.departamento = "";
      this.provincia = "";
      this.distrito = "";
    },
    cargarTodo() {
      this.cargarContratos();
      this.cargarCentros();
      this.cargarActividades();
      this.cargarDepartamentos();
    },
    cargarActividades() {
      get("actividadesEconomica").then(res => (this.actividades = res.data));
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
    }
  },
  created() {
    this.cargarTodo();
    this.cargarCarreras();
  }
};
</script>

<style scoped>
.v-input--selection-controls {
  margin-top: 0;
}
</style>

<template>
  <v-layout row wrap>
    <!-- Registro -->
    <v-flex xs12>
      <v-form @submit.prevent="">
        <v-layout row wrap>
          <v-flex xs12>
            <v-card>
              <div>
                <v-card-title class="title font-weight-light">
                  Datos de carrera
                </v-card-title>
                <v-card-text>
                  <v-combobox
                    v-model="universidad"
                    label="Seleccione universidad"
                    :items="universidades"
                    placeholder="Universidad"
                    @change="cargarEscuelas(universidad)"
                  ></v-combobox>
                  <v-combobox
                    v-model="escuela"
                    label="Seleccione escuela"
                    :items="escuelas"
                    item-text="nombre"
                    item-value="codigo"
                    placeholder="Escuela"
                    @change="cargarAdmisiones(escuela)"
                  ></v-combobox>
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
                </v-card-text>
              </div>
              <!-- Admision card -->
              <div v-if="universidad != '' && escuela != ''">
                <v-card-title class="title font-weight-light">
                  Datos de admisión
                </v-card-title>
                <v-card-text>
                  <v-select
                    :items="admisiones"
                    v-model="admision"
                    item-value="codigo"
                    label="Admisión"
                    placeholder="Seleccione admisión"
                    v-if="!addAdmision"
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
                  <v-checkbox
                    label="Usar otros datos de admisión"
                    v-model="addAdmision"
                  />
                  <section v-if="addAdmision">
                    <v-menu
                      v-model="fAdmision"
                      lazy
                      offset-y
                      full-width
                      min-width="280px"
                      :close-on-content-click="false"
                    >
                      <template v-slot:activator="{ on }">
                        <v-text-field
                          v-model="fechaAdmision"
                          label="Fecha de admisión"
                          prepend-icon="developer_board"
                          readonly
                          v-on="on"
                        ></v-text-field>
                      </template>
                      <v-date-picker
                        v-model="fechaAdmision"
                        @input="fAdmision = false"
                      ></v-date-picker>
                    </v-menu>
                    <v-select
                      v-model="ciclo"
                      :items="['I', 'II', 'III']"
                      prepend-icon="date_range"
                      label="Seleccione ciclo"
                      placeholder="Número de ciclo"
                    ></v-select>
                    <v-select
                      v-model="modalidad"
                      :items="modalidades"
                      item-text="nombre"
                      item-value="codigo"
                      label="Seleccione modalidad de admisión"
                      placeholder="Modalidad"
                      prepend-icon="laptop"
                      persistent-hint
                      :hint="descripcion"
                    ></v-select>
                  </section>
                </v-card-text>
              </div>
              <!-- Titulacion card -->
              <div v-if="titulacion.modalidadTitulacion">
                <v-card-title class="title font-weight-light">
                  Datos de titulación
                </v-card-title>
                <v-card-text>
                  <p>
                    Carrera titulada el
                    <span class="font-weight-medium">
                      {{
                        new Date(
                          titulacion.fechaTitulacion.replace(/-/g, "\/")
                        ).toLocaleDateString("es-ES", {
                          year: "numeric",
                          month: "long",
                          day: "numeric"
                        })
                      }}
                    </span>
                    por la modalidad
                    <span class="font-weight-medium">
                      {{ nombreModalidad }}
                    </span>
                  </p>
                  <p v-if="titulacion.codigoColegiado">
                    Colegiada el
                    <span class="font-weight-medium">
                      {{
                        new Date(
                          titulacion.fechaColegiatura.replace(/-/g, "\/")
                        ).toLocaleDateString("es-ES", {
                          year: "numeric",
                          month: "long",
                          day: "numeric"
                        })
                      }}
                    </span>
                    con el código
                    <span class="font-weight-medium">
                      {{ titulacion.codigoColegiado }}
                    </span>
                  </p>
                </v-card-text>
              </div>
            </v-card>
          </v-flex>
          <!-- Botones -->
          <v-btn v-if="isEdit" @click="editar" type="submit">
            Editar
          </v-btn>
          <v-btn v-else @click="agregar" type="submit">
            Agregar
          </v-btn>
          <v-btn v-if="isEdit" @click="dialog = true">
            <v-icon v-if="modalidadTitulacion" small left>create</v-icon>
            <v-icon v-else left>add</v-icon>
            Titulacion
          </v-btn>
          <v-btn outline @click="nuevo">Limpiar</v-btn>
        </v-layout>
      </v-form>
    </v-flex>
    <!-- Lista card -->
    <v-flex xs12>
      <v-card v-if="listaCarreras.length != 0">
        <v-list two-line>
          <v-list-tile
            v-for="carrera of listaCarreras"
            :key="carrera.codigo"
            @click="copiarDatos(carrera)"
          >
            <v-list-tile-content>
              <v-list-tile-title v-html="carrera.nombreEscuela" />
              <v-list-tile-sub-title>
                {{
                  `${carrera.universidad} 
                    (${carrera.fechaInicio.substring(0, 4)} - 
                    ${carrera.fechaTermino.substring(0, 4)})`
                }}
              </v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-card>
    </v-flex>
    <!-- Dialog para titulación -->
    <v-dialog v-model="dialog" persistent max-width="400">
      <v-card>
        <v-card-title class="title font-weight-light" primary-title>
          Datos de titulación
        </v-card-title>
        <v-card-text>
          <v-select
            :items="modalidadesTitulacion"
            v-model="modalidadTitulacion"
            item-text="nombre"
            item-value="codigo"
            label="Modalidad de titulación"
            :hint="descripcionTitulacion"
            prepend-icon="school"
          ></v-select>

          <v-menu
            v-model="fTitulacion"
            lazy
            offset-y
            full-width
            min-width="280px"
            :close-on-content-click="false"
          >
            <template v-slot:activator="{ on }">
              <v-text-field
                v-model="fechaTitulacion"
                label="Fecha de titulación"
                prepend-icon="event"
                readonly
                v-on="on"
              ></v-text-field>
            </template>
            <v-date-picker
              v-model="fechaTitulacion"
              @input="fTitulacion = false"
            ></v-date-picker>
          </v-menu>
          <v-checkbox label="Agregar colegiatura" v-model="addColegiatura" />
          <v-card v-if="addColegiatura">
            <v-card-text>
              <v-text-field
                v-model="codigoColegiado"
                label="Ingrese código de colegiado"
                placeholder="Código de colegiado"
              ></v-text-field>
              <v-menu
                v-model="colegiatura"
                lazy
                offset-y
                full-width
                min-width="280px"
                :close-on-content-click="false"
              >
                <template v-slot:activator="{ on }">
                  <v-text-field
                    v-model="fechaColegiatura"
                    label="Fecha de colegiatura"
                    prepend-icon="event"
                    readonly
                    v-on="on"
                  ></v-text-field>
                </template>
                <v-date-picker
                  v-model="fechaColegiatura"
                  @input="colegiatura = false"
                ></v-date-picker>
              </v-menu>
            </v-card-text>
          </v-card>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn flat @click="cerrarDialog">Cerrar</v-btn>
          <v-btn
            v-if="titulacion.modalidadTitulacion"
            flat
            @click="editarTitulacion"
          >
            Editar
          </v-btn>
          <v-btn v-else flat @click="agregarTitulacion">Agregar</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
import { get, post, put } from "../bd/api";
import { mapMutations } from "vuex";
export default {
  props: ["dni", "codigoPersona"],
  data: () => ({
    isEdit: false,
    dialog: false,

    codigo: "",
    universidades: [],
    universidad: "",
    escuelas: [],
    escuela: "",
    fechaInicio: new Date().toISOString().substring(0, 10),
    inicio: false,
    fechaTermino: new Date().toISOString().substring(0, 10),
    termino: false,
    fechaAdmision: new Date().toISOString().substring(0, 10),
    fAdmision: false,
    fechaTitulacion: new Date().toISOString().substring(0, 10),
    fTitulacion: false,
    ciclo: "",
    titulacion: {},
    modalidadesTitulacion: [],
    modalidadTitulacion: null,
    modalidades: [],
    modalidad: null,
    listaCarreras: [],
    addAdmision: false,
    admisiones: [],
    admision: "",
    addColegiatura: false,
    codigoColegiado: null,
    fechaColegiatura: new Date().toISOString().substring(0, 10),
    colegiatura: false
  }),
  computed: {
    nombreAdmision() {
      return this.fechaAdmision.substr(0, 4) + "-" + this.ciclo;
    },
    descripcion() {
      if (this.modalidad) {
        return this.modalidades[this.modalidad - 1].descripcion;
      }
    },
    descripcionTitulacion() {
      if (this.modalidadTitulacion) {
        return this.modalidadesTitulacion[this.modalidadTitulacion - 1]
          .descripcion;
      }
    },
    nombreModalidad() {
      if (this.titulacion.modalidadTitulacion) {
        return this.modalidadesTitulacion[
          this.titulacion.modalidadTitulacion - 1
        ].nombre;
      }
    }
  },
  methods: {
    ...mapMutations(["snackbar"]),
    validar() {
      if (this.universidad == "") {
        this.snackbar("Ingrese nombre de Universidad");
        return false;
      }
      if (this.escuela == "") {
        this.snackbar("Ingrese nombre de Escuela");
        return false;
      }
      if (this.admision == "" && !this.addAdmision) {
        this.snackbar("Seleccione admisión");
        return false;
      }
      if (this.addAdmision) {
        if (this.ciclo == "" || this.modalidad == null) {
          this.snackbar("Complete todos los datos de admisión");
          return false;
        }
      }
      return true;
    },
    nuevo() {
      this.addAdmision = false;
      this.addColegiatura = false;
      this.dialog = false;
      this.isEdit = false;
      this.codigo = "";
      this.universidad = "";
      this.escuela = "";
      this.fechaInicio = new Date().toISOString().substring(0, 10);
      this.fechaTermino = new Date().toISOString().substring(0, 10);
      this.fechaAdmision = new Date().toISOString().substring(0, 10);
      this.admision = "";
      this.ciclo = "";
      this.modalidad = "";
      this.modalidadTitulacion = "";
      this.fechaTitulacion = new Date().toISOString().substring(0, 10);
      this.codigoColegiado = "";
      this.fechaColegiatura = new Date().toISOString().substring(0, 10);
      this.titulacion = {};
    },
    copiarDatos(carrera) {
      get("escuelasProfesionales/uni/" + carrera.universidad).then(res => {
        if (res.estado) {
          this.addAdmision = false;
          get(
            "admisiones/" + carrera.nombreEscuela + "/" + carrera.universidad
          ).then(res => {
            this.addAdmision = false;
            this.isEdit = true;
            this.codigo = carrera.codigo;
            this.universidad = carrera.universidad;
            this.escuela = carrera.nombreEscuela;
            this.fechaInicio = carrera.fechaInicio;
            this.fechaTermino = carrera.fechaTermino;
            this.admision = carrera.codigoAdmision;
            this.fechaAdmision = new Date().toISOString().substring(0, 10);
            this.ciclo = "";
            this.modalidad = "";
            this.fechaTitulacion = carrera.fechaTitulacion;
            this.fechaColegiatura = carrera.fechaColegiatura;
            this.codigoColegiado = carrera.codigoColegiatura;
            this.modalidadTitulacion = carrera.modalidadTitulacion;
            if (carrera.fechaColegiatura == null)
              this.fechaColegiatura = new Date().toISOString().substring(0, 10);
            if (carrera.fechaTitulacion == null)
              this.fechaTitulacion = new Date().toISOString().substring(0, 10);
            if (this.codigoColegiado) this.addColegiatura = true;
            else this.addColegiatura = false;
            if (res.estado) this.admisiones = res.data;
            else {
              this.admisiones = [];
              this.addAdmision = true;
            }
            this.titulacion = {
              fechaTitulacion: this.fechaTitulacion,
              fechaColegiatura: this.fechaColegiatura,
              codigoColegiado: this.codigoColegiado,
              modalidadTitulacion: this.modalidadTitulacion
            };
          });
          this.escuelas = res.data;
        } else this.escuelas = [];
      });
    },
    editar() {
      if (!this.validar()) return;
      let datos = {
        nombreUniversidad: this.universidad,
        nombreEscuela: this.escuela,
        codigoPersona: this.codigoPersona,
        fechaInicio: this.fechaInicio,
        fechaTermino: this.fechaTermino
      };
      if (this.addAdmision) {
        datos = {
          ...datos,
          fechaAdmision: this.fechaAdmision,
          nombreAdmision: this.nombreAdmision,
          codigoModalidad: this.modalidad
        };
      } else datos = { ...datos, codigoAdmision: this.admision };
      put("carreras/" + this.codigo, datos).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
          this.nuevo();
        }
      });
    },
    agregar() {
      if (!this.validar()) return;
      let datos = {
        nombreUniversidad: this.universidad,
        nombreEscuela: this.escuela,
        codigoPersona: this.codigoPersona,
        fechaInicio: this.fechaInicio,
        fechaTermino: this.fechaTermino
      };
      if (this.addAdmision) {
        datos = {
          ...datos,
          fechaAdmision: this.fechaAdmision,
          nombreAdmision: this.nombreAdmision,
          codigoModalidad: this.modalidad
        };
      } else datos = { ...datos, codigoAdmision: this.admision };
      post("carreras/add", datos).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
          this.nuevo();
        }
      });
    },
    validarTitulacion() {
      if (this.modalidadTitulacion == null) {
        this.snackbar("Seleccione Modalidad de la titulación");
        return false;
      }
      if (this.addColegiatura) {
        if (this.codigoColegiado == null) {
          this.snackbar("Ingrese el código de colegiado");
          return false;
        }
      }
      return true;
    },
    editarTitulacion() {
      if (!this.validarTitulacion()) return;
      let datos = {
        codigoEgresado: this.codigo,
        codigoModalidad: this.modalidadTitulacion,
        fecha: this.fechaTitulacion
      };
      if (this.addColegiatura) {
        datos = {
          ...datos,
          codigoColegiado: this.codigoColegiado,
          fechaColegiatura: this.fechaColegiatura
        };
      }
      put("titulaciones/" + this.codigo, datos).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
          this.nuevo();
        }
      });
    },
    agregarTitulacion() {
      if (!this.validarTitulacion()) return;
      let datos = {
        codigoEgresado: this.codigo,
        codigoModalidad: this.modalidadTitulacion,
        fecha: this.fechaTitulacion
      };
      if (this.addColegiatura) {
        datos = {
          ...datos,
          codigoColegiado: this.codigoColegiado,
          fechaColegiatura: this.fechaColegiatura
        };
      }
      post("titulaciones", datos).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
          this.nuevo();
        }
      });
    },
    cerrarDialog() {
      if (this.titulacion.modalidadTitulacion) {
        this.modalidadTitulacion = this.titulacion.modalidadTitulacion;
        this.fechaTitulacion = this.titulacion.fechaTitulacion;
        this.fechaColegiatura = this.titulacion.fechaColegiatura;
        this.codigoColegiado = this.titulacion.codigoColegiatura;
      }
      this.dialog = false;
    },
    cargarTodo() {
      this.cargarUniversidades();
      this.cargarLista();
      this.cargarModalidadesTitulacion();
    },
    cargarModalidades() {
      get("modalidadesAdmision").then(res => (this.modalidades = res.data));
    },
    cargarLista() {
      get("carreras/" + this.dni).then(res => {
        if (res.estado == true) this.listaCarreras = res.data;
      });
    },
    cargarUniversidades() {
      get("universidades").then(res => (this.universidades = res.data));
    },
    cargarEscuelas(universidad) {
      this.escuela = "";
      this.escuelas = [];
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
      this.addAdmision = false;
      if (escuela) {
        get("admisiones/" + escuela + "/" + this.universidad).then(res => {
          if (res.estado) this.admisiones = res.data;
          else {
            this.admisiones = [];
            this.addAdmision = true;
          }
        });
      }
    },
    cargarModalidadesTitulacion() {
      get("modalidadesTitulacion").then(
        res => (this.modalidadesTitulacion = res.data)
      );
    }
  },
  created() {
    this.cargarTodo();
    this.cargarModalidades();
  }
};
</script>


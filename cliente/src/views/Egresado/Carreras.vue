<template>
  <v-container grid-list-lg>
    <v-layout row wrap>
      <!-- Registro -->
      <v-flex xs12 md6>
        <v-layout row wrap>
          <!-- Carrera card -->
          <v-flex xs12>
            <v-card>
              <v-card-title class="title font-weight-light" primary-title>
                Datos de carrera
              </v-card-title>
              <v-card-text>
                <v-form>
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
                </v-form>
              </v-card-text>
            </v-card>
          </v-flex>

          <!-- Admision card -->
          <v-flex xs12>
            <v-card>
              <v-card-title class="title font-weight-light" primary-title>
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
                          year: "numeric",
                          timeZone: "America/New_York"
                        }) +
                        ")"
                    }}
                  </template>
                  <template slot="selection" slot-scope="data">
                    {{ data.item.nombre }}
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
                  color="primary"
                  v-model="addAdmision"
                />
                <v-form v-if="addAdmision">
                  <v-menu
                    v-model="admision"
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
                      @input="admision = false"
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
                </v-form>
              </v-card-text>
            </v-card>
          </v-flex>
          <v-btn color="primary" v-if="isEdit" @click="editar">Editar</v-btn>
          <v-btn color="primary" v-else @click="agregar">Agregar</v-btn>
          <v-btn color="primary" outline @click="nuevo">Limpiar</v-btn>
        </v-layout>
      </v-flex>

      <!-- Lista card -->
      <v-flex xs12 md6>
        <v-card>
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
    </v-layout>
  </v-container>
</template>

<script>
import { get } from "../../bd/api";
import { mapState } from "vuex";
export default {
  data: () => ({
    universidades: [],
    universidad: "",
    escuelas: [],
    escuela: "",
    fechaInicio: new Date().toISOString().substring(0, 10),
    inicio: false,
    fechaTermino: new Date().toISOString().substring(0, 10),
    termino: false,
    fechaAdmision: new Date().toISOString().substring(0, 10),
    admision: false,
    ciclo: "",
    modalidades: [],
    modalidad: null,
    listaCarreras: [],
    addAdmision: false,
    admisiones: [],
    admision: "",
    isEdit: false
  }),
  computed: {
    ...mapState(["user"]),
    nombreAdmision() {
      return this.fechaAdmision.substr(0, 4) + "-" + this.ciclo;
    },
    descripcion() {
      if (this.modalidad) {
        return this.modalidades[this.modalidad - 1].descripcion;
      }
    }
  },
  methods: {
    nuevo() {
      this.addAdmision = false;
      this.isEdit = false;
      this.universidad = "";
      this.escuela = "";
      this.fechaInicio = new Date().toISOString().substring(0, 10);
      this.fechaTermino = new Date().toISOString().substring(0, 10);
      this.admision = "";
    },
    copiarDatos(carrera) {
      this.addAdmision = false;
      this.isEdit = true;
      this.universidad = carrera.universidad;
      this.escuela = carrera.nombreEscuela;
      this.fechaInicio = carrera.fechaInicio;
      this.fechaTermino = carrera.fechaTermino;
      this.admision = carrera.codigoAdmision;
    },
    editar() {},
    agregar() {
      let datos = {
        nombreUniversidad: this.universidad,
        nombreEscuela: this.escuela,
        codigoPersona: this.user.codigo,
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
        if (res.estado == true) alert("Todo good");
        this.cargarTodo();
        this.nuevo();
      });
    },
    cargarTodo() {
      this.cargarUniversidades();
      this.cargarLista();
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
    cargarModalidades() {
      get("modalidadesAdmision").then(res => (this.modalidades = res.data));
    },
    cargarUniversidades() {
      get("universidades").then(res => (this.universidades = res.data));
    },
    cargarLista() {
      get("carreras/" + this.user.dni).then(
        res => (this.listaCarreras = res.data)
      );
    },
    cargarAdmisiones(escuela) {
      this.admision = "";
      this.admisiones = [];
      if (escuela) {
        get("admisiones/" + escuela).then(res => {
          if (res.estado) this.admisiones = res.data;
          else {
            this.admisiones = [];
            this.addAdmision = true;
          }
        });
      }
    }
  },
  created() {
    this.cargarTodo();
    this.cargarModalidades();
  }
};
</script>


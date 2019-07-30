<template>
  <v-container grid-list-lg>
    <v-layout row wrap>
      <!-- Selects -->
      <v-flex xs12 md6>
        <v-layout row wrap>
          <v-flex xs12>
            <v-autocomplete
              v-model="egresado"
              :items="egresados"
              placeholder="Seleccione Egresado"
              item-value="dni"
              item-text="nombre"
              hide-details
              return-object
              solo
              @change="seleccionarEgresado"
            >
              <template slot="prepend-inner">
                <v-icon left>person</v-icon>
              </template>
              <template v-slot:selection="data">
                {{ data.item.nombre }}
              </template>
              <template v-slot:item="data">
                <template three-line>
                  <v-list-tile-content>
                    <v-list-tile-title v-html="data.item.nombre" />
                    <v-list-tile-sub-title>
                      <span class="font-weight-light caption">
                        DNI {{ data.item.dni }}
                      </span>
                    </v-list-tile-sub-title>
                  </v-list-tile-content>
                </template>
              </template>
            </v-autocomplete>
          </v-flex>
          <v-flex>
            <v-layout row wrap>
              <v-flex xs12>
                <v-card>
                  <v-card-title class="title font-weight-light" primary-title>
                    Datos de egresado
                  </v-card-title>
                  <v-card-text>
                    <section v-if="vigencia == true">
                      <v-text-field
                        v-model="dni"
                        append-icon="featured_video"
                        label="Ingrese el DNI"
                        placeholder="DNI"
                        type="text"
                      />
                      <v-text-field
                        v-model="correo"
                        append-icon="email"
                        label="Ingrese correo institucional"
                        placeholder="Correo"
                        type="text"
                      />
                      <v-card>
                        <v-card-text>
                          <v-text-field
                            v-model="nombres"
                            label="Ingrese nombres"
                            placeholder="Nombres"
                            type="text"
                          />
                          <v-text-field
                            v-model="paterno"
                            label="Ingrese apellido paterno"
                            placeholder="Apellido paterno"
                            type="text"
                          />
                          <v-text-field
                            v-model="materno"
                            label="Ingrese apellido materno"
                            placeholder="Apellido materno"
                            type="text"
                          />
                        </v-card-text>
                      </v-card>
                      <v-radio-group
                        v-model="genero"
                        row
                        label="Genero "
                        prepend-icon="person"
                      >
                        <v-radio label="Masculino" value="1"></v-radio>
                        <v-radio label="Femenino" value="0"></v-radio>
                      </v-radio-group>
                      <v-menu
                        v-model="fecha"
                        lazy
                        offset-y
                        full-width
                        min-width="280px"
                        :close-on-content-click="false"
                      >
                        <template v-slot:activator="{ on }">
                          <v-text-field
                            v-model="fechaNacimiento"
                            label="Fecha de nacimiento"
                            prepend-icon="event"
                            readonly
                            v-on="on"
                          ></v-text-field>
                        </template>
                        <v-date-picker
                          v-model="fechaNacimiento"
                          @input="fecha = false"
                        ></v-date-picker>
                      </v-menu>
                      <v-text-field
                        v-model="celular"
                        prepend-icon="phone_android"
                        label="Ingrese número de celular"
                        placeholder="Número de celular"
                        type="text"
                      />
                      <v-select
                        v-model="estadoCivil"
                        prepend-icon="people_outline"
                        :items="estados"
                        item-value="codigo"
                        item-text="texto"
                        label="Seleccione estado civil"
                        placeholder="Estado civil"
                      ></v-select>
                    </section>
                    <section v-else>
                      <p>
                        La cuenta de
                        <span class="font-weight-medium">
                          {{ nombres }} {{ paterno }}
                        </span>
                        está inhabilitada y no puede acceder a sus datos.
                      </p>
                      <v-btn flat block @click="recuperar">
                        Recuperar Egresado
                      </v-btn>
                    </section>
                  </v-card-text>
                </v-card>
              </v-flex>
              <v-btn v-if="isEdit && vigencia == true" @click="editar">
                Editar
              </v-btn>
              <v-btn v-else-if="vigencia == true" @click="agregar">
                Agregar
              </v-btn>
              <v-btn v-if="isEdit && vigencia == true" @click="dialog = true">
                Eliminar
              </v-btn>
              <v-btn outline @click="nuevo">Limpiar</v-btn>
            </v-layout>
          </v-flex>
        </v-layout>
      </v-flex>
      <!-- Datos -->
      <v-flex xs12 md6>
        <egresados-carreras
          :dni="egresado.dni"
          :codigoPersona="egresado.codigo"
          v-if="isEdit && vigencia == true"
        />
      </v-flex>
      <!-- Dialog para eliminar -->
      <v-dialog v-model="dialog" persistent max-width="360">
        <v-card>
          <v-card-title class="title" primary-title>
            ¿Seguro que desea eliminar?
          </v-card-title>
          <v-card-text>
            <span class="font-weight-medium">
              {{ nombres }} {{ paterno }}
            </span>
            no podrá acceder a su cuenta.
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn flat @click="dialog = false">Cancelar</v-btn>
            <v-btn flat @click="eliminar">Aceptar</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-layout>
  </v-container>
</template>

<script>
import { get, post, put, patch } from "../../bd/api";
import { mapMutations } from "vuex";
export default {
  components: {
    EgresadosCarreras: () => import("../../components/EgreCarreras")
  },
  data: () => ({
    isEdit: false,
    dialog: false,
    dialogSelect: 0,

    egresado: undefined,
    egresados: [],
    vigencia: 1,
    codigo: "",
    dni: "",
    correo: "",
    nombres: "",
    paterno: "",
    materno: "",
    genero: "1",
    fechaNacimiento: new Date().toISOString().substring(0, 10),
    fecha: false,
    celular: "",
    estados: [
      { codigo: "S", texto: "Soltero" },
      { codigo: "C", texto: "Casado" },
      { codigo: "N", texto: "Conviviente" },
      { codigo: "D", texto: "Divorciado" },
      { codigo: "P", texto: "Separado" },
      { codigo: "V", texto: "Viudo" }
    ],
    estadoCivil: ""
  }),
  computed: {
    dialogSelects() {
      if (!this.universidad) return;
      let universidades = this.universidades.filter(
        e => e.vigencia && e.codigo != this.universidad.codigo
      );
      universidades.unshift({ nombre: "Ninguna", codigo: 0 });
      return universidades;
    },
    nombreUniversidad() {
      if (this.universidad) return this.universidad.nombre;
      else return "";
    }
  },
  methods: {
    ...mapMutations(["snackbar"]),
    copiarDatos() {
      if (this.egresado) {
        get("personas/" + this.egresado.dni).then(res => {
          if (res.estado == true) {
            let data = res.data;
            this.isEdit = true;
            this.vigencia = parseInt(data.vigencia);
            this.codigo = data.codigo;
            this.dni = data.dni;
            this.correo = data.correo;
            this.nombres = data.nombres;
            this.paterno = data.apellidoPaterno;
            this.materno = data.apellidoMaterno;
            this.genero = data.genero;
            this.fechaNacimiento = data.fechaNacimiento;
            this.celular = data.celular;
            this.estadoCivil = data.estadoCivil;
          }
        });
      } else this.nuevo();
    },
    seleccionarEgresado() {
      this.isEdit = false;
      setTimeout(() => {
        this.copiarDatos();
        this.isEdit = true;
      }, 10);
    },
    validar() {
      if (this.dni == "") {
        this.snackbar("Ingrese el DNI");
        return false;
      }
      if (this.nombres == "" || this.paterno == "" || this.materno == "") {
        this.snackbar("Ingrese los nombres completos");
        return false;
      }
      if (this.correo == "") {
        this.snackbar("Ingrese correo");
        return false;
      }
      return true;
    },
    agregar() {
      if (!this.validar()) return;
      post("personas", {
        dni: this.dni,
        correo: this.correo,
        usuario: this.correo.split("@")[0],
        nombres: this.nombres,
        paterno: this.paterno,
        materno: this.materno,
        genero: this.genero,
        fecha: this.fechaNacimiento,
        celular: this.celular,
        estado: this.estadoCivil
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
          this.nuevo();
        }
      });
    },
    editar() {
      if (!this.validar()) return;
      put("personas/" + this.codigo, {
        dni: this.dni,
        correo: this.correo,
        nombres: this.nombres,
        paterno: this.paterno,
        materno: this.materno,
        genero: this.genero,
        fecha: this.fechaNacimiento,
        celular: this.celular,
        estado: this.estadoCivil
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
        }
      });
    },
    nuevo() {
      this.isEdit = false;
      this.vigencia = 1;
      this.codigo = "";
      this.dni = "";
      this.correo = "";
      this.nombres = "";
      this.paterno = "";
      this.materno = "";
      this.genero = "1";
      this.fechaNacimiento = new Date().toISOString().substring(0, 10);
      this.celular = "";
      this.estadoCivil = "";
      this.egresado = undefined;
    },
    eliminar() {
      patch("personas/" + this.codigo, { vigencia: true }).then(res => {
        this.snackbar(res.mensaje);
        this.dialog = false;
        if (res.estado == true) {
          this.vigencia = false;
          this.cargarTodo();
        }
      });
    },
    recuperar() {
      patch("personas/" + this.codigo, { vigencia: false }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.vigencia = true;
          this.cargarTodo();
        }
      });
    },
    cargarTodo() {
      this.cargarEgresados();
    },
    cargarEgresados() {
      get("personas").then(res => (this.egresados = res.data));
    }
  },
  created() {
    if (this.$route.params.dni) {
      this.egresado = {
        dni: this.$route.params.dni
      };
    }
    this.cargarTodo();
    this.copiarDatos();
  }
};
</script>

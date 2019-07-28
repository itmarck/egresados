<template>
  <v-container grid-list-lg>
    <v-layout row wrap>
      <!-- Gestion de personal -->
      <v-flex xs12 md6>
        <v-layout row wrap>
          <!-- Select -->
          <v-flex>
            <v-autocomplete
              v-model="personal"
              :items="personales"
              placeholder="Seleccione Personal"
              item-value="codigo"
              item-text="nombre"
              hide-details
              return-object
              solo
              @change="seleccionarPersonal"
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
                        DNI {{ data.item.dni }} {{ data.item.correo }}
                      </span>
                    </v-list-tile-sub-title>
                  </v-list-tile-content>
                </template>
              </template>
            </v-autocomplete>
          </v-flex>
          <!-- Formulario mas botones -->
          <v-flex>
            <v-form @submit.prevent="registrar">
              <v-layout row wrap>
                <v-flex xs12>
                  <v-card>
                    <v-card-title class="title font-weight-light" primary-title>
                      <div>Datos de personal</div>
                      <v-spacer></v-spacer>
                      <div v-if="isSelect">
                        <v-icon v-if="vigencia == 0">remove_circle</v-icon>
                        <v-icon v-else color="primary">check_circle</v-icon>
                      </div>
                    </v-card-title>
                    <v-card-text v-if="!isSelect">
                      <v-text-field
                        v-model="dni"
                        label="Ingrese DNI"
                        placeholder="87654321"
                      ></v-text-field>
                      <v-text-field
                        v-model="correo"
                        label="Ingrese correo a registrar"
                        placeholder="personal@unprg.edu.pe"
                      ></v-text-field>
                      <v-text-field
                        v-model="nombres"
                        label="Ingrese nombres del personal"
                        placeholder="Nombres"
                      ></v-text-field>
                      <v-text-field
                        v-model="paterno"
                        label="Ingrese apellido paterno"
                        placeholder="Apellido paterno"
                      ></v-text-field>
                      <v-text-field
                        v-model="materno"
                        label="Ingrese apellido materno"
                        placeholder="Apellido materno"
                      ></v-text-field>
                      <v-radio-group
                        v-model="genero"
                        row
                        label="Genero "
                        prepend-icon="person"
                      >
                        <v-radio label="Masculino" value="1"></v-radio>
                        <v-radio label="Femenino" value="0"></v-radio>
                      </v-radio-group>
                      <p class="body-1 font-weight-light">
                        El usuario podrá agregar o modifcar sus datos personales
                        al iniciar sesión
                      </p>
                      <p class="body-1 font-weight-light">
                        La contraseña por defecto para las cuentas recien
                        creadas es
                        <span class="body-1 font-weight-black">
                          3P1CI*2019
                        </span>
                      </p>
                    </v-card-text>
                    <v-card-text v-else>
                      <section v-if="vigencia == true">
                        <p class="font-weight-medium">
                          {{ personal.correo }}
                        </p>
                        <p class="body-1 font-weight-light">
                          Ésta cuenta está habilitada y puede realizar cambios
                          en la base de datos
                        </p>
                      </section>
                      <section v-else>
                        <p class="font-weight-medium">
                          {{ personal.correo }}
                        </p>
                        <p class="body-1 font-weight-light">
                          Ésta cuenta está inhabilitada y no puede acceder a su
                          información ni realizar cambios en la base da tos.
                        </p>
                        <p class="body-1 font-weight-light">
                          Se puede eliminar permanentemente la cuenta en el
                          panel lateral.
                        </p>
                        <v-btn flat block @click="recuperar">
                          Recuperar Personal
                        </v-btn>
                      </section>
                    </v-card-text>
                  </v-card>
                </v-flex>
                <v-btn v-if="!isSelect" @click="registrar" type="submit">
                  Registrar personal
                </v-btn>
                <v-btn v-else-if="vigencia" @click="dialogPersonal = true">
                  Inhabilitar
                </v-btn>
                <v-btn outline @click="limpiar">Limpiar</v-btn>
              </v-layout>
            </v-form>
          </v-flex>
        </v-layout>
      </v-flex>
      <!-- Gestion de tablas -->
      <v-flex xs12 md6>
        <v-layout row wrap>
          <!-- Select para tablas -->
          <v-flex xs12>
            <v-select
              :items="tablas"
              v-model="tabla"
              item-text="nombre"
              item-value="api"
              hide-details
              solo
              placeholder="Eliminar datos innecesarios"
              @change="cargarTablas"
            >
              <template slot="prepend-inner">
                <v-icon left>web</v-icon>
              </template>
            </v-select>
          </v-flex>
          <!-- Lista -->
          <v-flex>
            <v-card v-if="lista.length != 0">
              <v-list two-line>
                <v-list-tile
                  v-for="item of lista"
                  :key="item.codigo"
                  @click="seleccionarTabla(item)"
                >
                  <v-list-tile-content>
                    <v-list-tile-title v-html="item.nombre" />
                    <v-list-tile-sub-title v-html="item.descripcion" />
                  </v-list-tile-content>
                </v-list-tile>
              </v-list>
            </v-card>
          </v-flex>
        </v-layout>
      </v-flex>
      <!-- Dialog para deshabilitar personal -->
      <v-dialog v-model="dialogPersonal" persistent max-width="360">
        <v-card>
          <v-card-title class="title" primary-title>
            ¿Seguro que desea inhabilitar?
          </v-card-title>
          <v-card-text>
            <span class="font-weight-medium">
              {{ personal.nombre }}
            </span>
            no podrá acceder a su cuenta.
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn flat @click="dialogPersonal = false">Cancelar</v-btn>
            <v-btn flat @click="quitarPersonal">Aceptar</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
      <!-- Dialog para eliminar datos -->
      <v-dialog v-model="dialogTablas" persistent max-width="360">
        <v-card>
          <v-card-title class="title" primary-title>
            ¿Seguro que desea eliminar?
          </v-card-title>
          <v-card-text>
            Estos cambios son irreversibles.
            <span class="font-weight-medium"> {{ nombre }} </span>
            será removida de la base de datos y no se podrá recuperar.
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn flat @click="dialogTablas = false">Cancelar</v-btn>
            <v-btn flat @click="eliminar">Aceptar</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-layout>
  </v-container>
</template>

<script>
import { get, post, del, patch } from "../../bd/api";
import { mapMutations } from "vuex";
export default {
  data: () => ({
    isSelect: false,
    personales: [],
    personal: {},
    dni: "",
    nombres: "",
    paterno: "",
    materno: "",
    correo: "",
    genero: "1",
    vigencia: true,
    dialogPersonal: false,

    tablas: [
      { nombre: "Egresados", api: "personas-objeto-disabled" },
      { nombre: "Personales", api: "personal-objeto-disabled" },
      { nombre: "Universidades", api: "universidades-objeto-disabled" },
      { nombre: "Escuelas", api: "escuelas-objeto-disabled" },
      { nombre: "Facultades", api: "facultades-objeto-disabled" },
      { nombre: "Centro de Estudios", api: "centroEstudios-objeto-disabled" },
      { nombre: "Centros Laborales", api: "centroLaborales-objeto-disabled" },
      { nombre: "Actividades Económicas", api: "actividades-objeto-disabled" },
      { nombre: "Distritos", api: "distritos-objeto-disabled" }
    ],
    tabla: "",
    codigo: "",
    nombre: "",
    lista: [],
    dialogTablas: false
  }),
  methods: {
    ...mapMutations(["snackbar"]),
    seleccionarPersonal() {
      this.isSelect = true;
      this.vigencia = parseInt(this.personal.vigencia);
    },
    limpiar() {
      this.isSelect = false;
      this.dialogPersonal = false;
      this.dialogTablas = false;
      this.personal = {};
      this.dni = "";
      this.correo = "";
      this.nombres = "";
      this.paterno = "";
      this.materno = "";
    },
    validar() {
      if (this.dni == "" || this.dni.length != 8) {
        this.snackbar("Necesitamos el DNI para registrar el personal");
        return false;
      }
      if (this.correo == "") {
        this.snackbar("Para iniciar sesión necesitará el correo");
        return false;
      }
      if (this.nombres == "" || this.paterno == "" || this.materno == "") {
        this.snackbar("El usuario podrá cambiar sus datos luego");
        return false;
      }
      return true;
    },
    registrar() {
      if (!this.validar()) return;
      post("personal", {
        dni: this.dni,
        correo: this.correo,
        nombres: this.nombres,
        paterno: this.paterno,
        materno: this.materno,
        genero: this.genero
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.limpiar();
        }
      });
    },
    recuperar() {
      patch("personal/" + this.personal.codigo, { vigencia: false }).then(
        res => {
          this.snackbar(res.mensaje);
          if (res.estado == true) {
            this.cargarTodo();
            this.vigencia = true;
            this.dialogPersonal = false;
          }
        }
      );
    },
    quitarPersonal() {
      patch("personal/" + this.personal.codigo, { vigencia: true }).then(
        res => {
          this.snackbar(res.mensaje);
          if (res.estado == true) {
            this.cargarTodo();
            this.vigencia = false;
            this.dialogPersonal = false;
          }
        }
      );
    },
    cargarPersonal() {
      get("personal").then(res => (this.personales = res.data));
    },
    cargarTodo() {
      this.cargarPersonal();
    },
    cargarTablas() {
      this.lista = [];
      get(this.tabla).then(res => (this.lista = res.data));
    },
    seleccionarTabla(item) {
      this.codigo = item.codigo;
      this.nombre = item.nombre;
      this.dialogTablas = true;
    },
    eliminar() {
      del(this.tabla, { codigo: this.codigo }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTablas();
          this.dialogTablas = false;
        }
      });
    }
  },
  created() {
    this.cargarTodo();
  }
};
</script>


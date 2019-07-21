<template>
  <v-layout row wrap>
    <!-- Selects -->
    <v-flex xs12 md6>
      <v-layout row wrap>
        <v-flex xs12>
          <mant-select></mant-select>
        </v-flex>
        <v-flex xs12>
          <v-autocomplete
            v-model="escuela"
            :items="escuelas"
            placeholder="Seleccione Escuela"
            item-value="codigo"
            item-text="nombre"
            hide-details
            return-object
            clearable
            solo
            @change="copiarDatos"
          >
            <template slot="prepend-inner">
              <v-icon left>school</v-icon>
            </template>
            <template v-slot:selection="data">
              {{ data.item.nombre }}
            </template>
            <template v-slot:item="data">
              <template>
                <v-list-tile-content
                  :style="data.item.vigencia ? '' : 'opacity: .3'"
                >
                  <v-list-tile-title v-html="data.item.nombre" />
                  <v-list-tile-sub-title v-html="data.item.universidad" />
                </v-list-tile-content>
              </template>
            </template>
          </v-autocomplete>
        </v-flex>
      </v-layout>
    </v-flex>
    <!-- Datos -->
    <v-flex xs12 md6>
      <v-form @submit.prevent="">
        <v-layout row wrap>
          <v-flex xs12>
            <v-card>
              <v-card-title class="title font-weight-light" primary-title>
                Datos de escuela
              </v-card-title>
              <v-card-text>
                <section v-if="vigencia == true">
                  <v-autocomplete
                    v-model="universidad"
                    :items="universidades"
                    label="Nombre de la universidad"
                    :readonly="isEdit"
                  ></v-autocomplete>
                  <v-combobox
                    v-if="
                      universidad == 'Universidad Nacional Pedro Ruiz Gallo'
                    "
                    :items="facultades"
                    v-model="facultad"
                    label="Nombre de la facultad"
                    placeholder="Facultad"
                  ></v-combobox>
                  <v-text-field
                    v-model="nombre"
                    label="Nombre de la escuela"
                    placeholder="Escuela"
                  ></v-text-field>
                  <v-text-field
                    v-model="siglas"
                    label="Siglas de la escuela"
                    placeholder="Siglas"
                  ></v-text-field>
                  <v-select
                    :items="estados"
                    v-model="estado"
                    item-text="texto"
                    item-value="valor"
                    label="Estado de la escuela"
                  ></v-select>
                </section>
                <section v-else>
                  <p>
                    <span class="font-weight-medium">
                      {{ nombreEscuela }}
                    </span>
                    está eliminada pero aún puedes recurperarla. Los vinculos a
                    ésta Escuela ya no se podrán recuperar.
                  </p>
                  <v-btn flat block @click="recuperar">
                    Recuperar Escuela
                  </v-btn>
                </section>
              </v-card-text>
            </v-card>
          </v-flex>
          <v-btn v-if="isEdit && vigencia == true" @click="editar">
            Editar
          </v-btn>
          <v-btn v-else-if="vigencia == true" @click="agregar">Agregar</v-btn>
          <v-btn v-if="isEdit && vigencia == true" @click="dialog = true">
            Eliminar
          </v-btn>
          <v-btn outline @click="nuevo">Limpiar</v-btn>
        </v-layout>
      </v-form>
    </v-flex>

    <!-- Snackbar -->
    <v-snackbar v-model="snack" bottom left :timeout="6000" color="secondary">
      {{ respuesta }}
      <v-btn color="bright" flat @click="snack = false">Cerrar</v-btn>
    </v-snackbar>
    <!-- Dialog para eliminar -->
    <v-dialog v-model="dialog" persistent max-width="360">
      <v-card>
        <v-card-title class="title" primary-title>
          ¿Seguro que desea eliminar? Algunos cambios son irreversibles
        </v-card-title>
        <v-card-text>
          <p>
            Antes de eliminar, seleccione la Escuela que reemplazará a
            <span class="font-weight-medium">{{ nombreEscuela }}</span>
          </p>
          <v-select
            :items="dialogSelects"
            v-model="dialogSelect"
            item-text="nombre"
            item-value="codigo"
            label="Escuela"
          ></v-select>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn flat @click="dialog = false">Cancelar</v-btn>
          <v-btn flat @click="eliminar">Aceptar</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
import { get, post, patch } from "../bd/api";
export default {
  components: {
    MantSelect: () => import("./MantSelect")
  },
  data: () => ({
    isEdit: false,
    snack: false,
    respuesta: "",
    estados: [
      { texto: "Habilitada", valor: 1 },
      { texto: "No habilitada", valor: 0 }
    ],
    dialog: false,
    dialogSelect: 0,

    codigo: "",
    nombre: "",
    universidades: [],
    universidad: undefined,
    facultades: [],
    facultad: "",
    escuelas: [],
    escuela: undefined,
    siglas: "",
    estado: 1,
    vigencia: 1
  }),
  computed: {
    dialogSelects() {
      if (!this.escuela) return;
      let escuelas = this.escuelas.filter(
        e =>
          e.vigencia == true &&
          e.codigo != this.escuela.codigo &&
          e.universidad == this.escuela.universidad
      );
      escuelas.unshift({ nombre: "Ninguna", codigo: 0 });
      return escuelas;
    },
    nombreEscuela() {
      if (this.escuela) return this.escuela.nombre;
      else return "";
    }
  },
  methods: {
    copiarDatos() {
      if (this.escuela) {
        this.isEdit = true;
        this.codigo = this.escuela.codigo;
        this.universidad = this.escuela.universidad;
        this.facultad = this.escuela.facultad;
        this.nombre = this.escuela.nombre;
        this.siglas = this.escuela.siglas;
        this.estado = this.escuela.estado;
        this.vigencia = this.escuela.vigencia;
        if (this.facultad != "") this.cargarFacultades();
      } else this.nuevo();
    },
    agregar() {
      let datos = {
        nombre: this.nombre,
        siglas: this.siglas,
        nombreUniversidad: this.universidad,
        estado: this.estado
      };
      if (this.universidad == "Universidad Nacional Pedro Ruiz Gallo") {
        if (this.facultad == "") {
          this.snackbar("La Facultad no puede estar vacia");
          return;
        }
        datos = {
          ...datos,
          nombreFacultad: this.facultad,
          siglasFacultad: this.obtenerSiglas(this.facultad)
        };
      }
      post("escuelasProfesionales/add", datos).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
          this.nuevo();
        }
      });
    },
    editar() {
      let datos = {
        nombre: this.nombre,
        siglas: this.siglas,
        nombreUniversidad: this.universidad,
        estado: this.estado
      };
      if (this.universidad == "Universidad Nacional Pedro Ruiz Gallo") {
        if (this.facultad == "") {
          this.snackbar("La Facultad no puede estar vacia");
          return;
        }
        datos = {
          ...datos,
          nombreFacultad: this.facultad,
          siglasFacultad: this.obtenerSiglas(this.facultad)
        };
      }
      put("escuelasProfesionales/" + this.escuela.codigo, datos).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
          this.nuevo();
        }
      });
    },
    nuevo() {
      this.isEdit = false;
      this.escuela = undefined;
      this.universidad = undefined;
      this.facultad = "";
      this.codigo = "";
      this.nombre = "";
      this.siglas = "";
      this.estado = 1;
      this.vigencia = 1;
    },
    eliminar() {
      patch("escuelasProfesionales/" + this.escuela.codigo, {
        vigencia: true,
        escuela: this.dialogSelect
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.vigencia = false;
          this.dialog = false;
          this.cargarTodo();
        }
      });
    },
    recuperar() {
      patch("escuelasProfesionales/" + this.escuela.codigo, {
        vigencia: false
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.vigencia = true;
          this.cargarTodo();
        }
      });
    },
    obtenerSiglas(string) {
      return string
        .split(" ")
        .map(e => e[0])
        .join("")
        .toUpperCase();
    },
    cargarTodo() {
      this.cargarEscuelas();
      this.cargarUniversidades();
    },
    cargarUniversidades() {
      get("universidades").then(res => (this.universidades = res.data));
    },
    cargarEscuelas() {
      get("escuelasProfesionales").then(res => {
        this.escuelas = res.data.map(e => ({
          ...e,
          estado: parseInt(e.estado),
          vigencia: parseInt(e.vigencia)
        }));
      });
    },
    cargarFacultades() {
      get("facultades").then(res => (this.facultades = res.data));
    },
    snackbar(mensaje) {
      this.respuesta = mensaje;
      this.snack = true;
    }
  },
  created() {
    this.cargarTodo();
  }
};
</script>


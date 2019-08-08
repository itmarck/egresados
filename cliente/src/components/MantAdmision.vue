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
            v-model="item"
            :items="lista"
            placeholder="Seleccione Admisión"
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
              <span> {{ data.item.nombre }} </span>
            </template>
            <template v-slot:item="data">
              <template>
                <v-list-tile-content
                  :style="data.item.vigencia ? '' : 'opacity: .3'"
                >
                  <v-list-tile-title v-html="data.item.nombre" />
                  <v-list-tile-sub-title v-html="data.item.nombreEscuela" />
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
                Datos de admisión
              </v-card-title>
              <v-card-text>
                <section v-if="vigencia == true">
                  <v-select
                    v-model="universidad"
                    label="Seleccione universidad"
                    :items="universidades"
                    item-value="codigo"
                    item-text="nombre"
                    placeholder="Universidad"
                    @change="cargarEscuelas(universidad)"
                  ></v-select>
                  <v-select
                    v-model="escuela"
                    label="Seleccione escuela"
                    :items="escuelas"
                    item-text="nombre"
                    item-value="codigo"
                    placeholder="Escuela"
                    @change="lista = []"
                    :disabled="universidad == ''"
                  ></v-select>
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
                        :disabled="escuela == ''"
                      ></v-text-field>
                    </template>
                    <v-date-picker
                      v-model="fechaAdmision"
                      @input="fAdmision = false"
                      locale="es-MX"
                      :show-current="false"
                      :max="new Date().toISOString().substr(0, 10)"
                    ></v-date-picker>
                  </v-menu>
                  <v-select
                    v-model="ciclo"
                    :items="['I', 'II', 'III']"
                    prepend-icon="date_range"
                    label="Seleccione ciclo"
                    placeholder="Número de ciclo"
                    :disabled="escuela == ''"
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
                    :disabled="escuela == ''"
                  ></v-select>
                </section>
                <section v-else>
                  <p>
                    <span class="font-weight-medium">{{ nombreItem }}</span>
                    está eliminada pero aún puedes restaurarla. Los vinculos a
                    éste distrito ya no se podrán recuperar.
                  </p>
                  <v-btn flat block @click="recuperar">
                    Recuperar distrito
                  </v-btn>
                </section>
              </v-card-text>
            </v-card>
          </v-flex>
          <v-btn
            v-if="isEdit && vigencia == true"
            @click="editar"
            type="submit"
          >
            Editar
          </v-btn>
          <v-btn v-else-if="vigencia == true" @click="agregar" type="submit">
            Agregar
          </v-btn>
          <v-btn v-if="isEdit && vigencia == true" @click="dialog = true">
            Eliminar
          </v-btn>
          <v-btn outline @click="nuevo">
            Limpiar
          </v-btn>
        </v-layout>
      </v-form>
    </v-flex>
    <!-- Dialog para eliminar -->
    <v-dialog v-model="dialog" persistent max-width="360">
      <v-card>
        <v-card-title class="title" primary-title>
          ¿Seguro que desea eliminar?
        </v-card-title>
        <v-card-text>
          <p>
            <span class="font-weight-medium">{{ nombreItem }}</span> todavía
            estará disponible por si necesita recuperarlo.
          </p>
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
import { get, post, put, patch } from "../bd/api";
import { mapMutations } from "vuex";
export default {
  components: {
    MantSelect: () => import("./MantSelect")
  },
  data: () => ({
    isEdit: false,
    dialog: false,

    lista: [],
    item: undefined,

    universidades: [],
    universidad: "",
    escuelas: [],
    escuela: "",
    fechaAdmision: new Date().toISOString(),
    fAdmision: false,
    ciclo: "",
    modalidades: [],
    modalidad: null,
    vigencia: 1
  }),
  computed: {
    nombreAdmision() {
      return this.fechaAdmision.substr(0, 4) + "-" + this.ciclo;
    },
    nombreItem() {
      if (this.item) return this.item.nombre;
      else return "";
    },
    descripcion() {
      if (this.modalidad) {
        return this.modalidades[this.modalidad - 1].descripcion;
      }
    }
  },
  methods: {
    ...mapMutations(["snackbar"]),
    validar() {
      if (this.universidad == "") {
        this.snackbar("Seleccione Universidad");
        return false;
      }
      if (this.escuela == "") {
        this.snackbar("Seleccione Escuela");
        return false;
      }
      if (this.ciclo == "") {
        this.snackbar("Ingrese número de ciclo");
        return false;
      }
      if (this.modalidad == null) {
        this.snackbar("Seleccione la modalidad de ingreso");
        return false;
      }
      return true;
    },
    nuevo() {
      this.isEdit = false;
      this.item = undefined;
      this.universidad = "";
      this.escuela = "";
      this.fechaAdmision = new Date().toISOString();
      this.ciclo = "";
      this.modalidad = "";
      this.vigencia = 1;
    },
    copiarDatos() {
      if (this.item) {
        this.isEdit = true;
        this.universidad = this.item.universidad;
        get("escuelas/uni/" + this.universidad).then(res => {
          this.escuelas = res.data;
          this.escuela = this.item.escuela;
          this.fechaAdmision = this.item.fecha;
          this.modalidad = this.item.modalidad;
          this.ciclo = this.item.ciclo.substring(5, 8);
          this.vigencia = parseInt(this.item.vigencia);
        });
      } else this.nuevo();
    },
    agregar() {
      if (!this.validar()) return;
      post("admisiones", {
        nombre: this.nombreAdmision,
        escuela: this.escuela,
        admision: this.fechaAdmision,
        modalidad: this.modalidad
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
      put("admisiones/" + this.item.codigo, {
        nombre: this.nombreAdmision,
        escuela: this.escuela,
        admision: this.fechaAdmision,
        modalidad: this.modalidad
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
        }
      });
    },
    eliminar() {
      patch("admisiones/" + this.item.codigo, {
        vigencia: true
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
      patch("admisiones/" + this.item.codigo, {
        vigencia: false
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.vigencia = true;
          this.cargarTodo();
        }
      });
    },
    cargarLista() {
      get("admisiones-all").then(res => {
        this.lista = res.data.map(e => ({
          ...e,
          vigencia: parseInt(e.vigencia)
        }));
      });
    },
    cargarUniversidades() {
      get("universidades-objeto").then(res => (this.universidades = res.data));
    },
    cargarEscuelas(universidad) {
      this.escuela = "";
      this.escuelas = [];
      if (universidad) {
        get("escuelas/uni/" + universidad).then(res => {
          if (res.estado) this.escuelas = res.data;
          else this.escuelas = [];
        });
      }
    },
    cargarModalidades() {
      get("modalidadesAdmision").then(res => (this.modalidades = res.data));
    },
    cargarTodo() {
      this.cargarLista();
      this.cargarUniversidades();
    }
  },
  created() {
    this.cargarTodo();
    this.cargarModalidades();
  }
};
</script>

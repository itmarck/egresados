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
            placeholder="Seleccione Actividad Económica"
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
                  <v-list-tile-sub-title v-html="data.item.descripcion" />
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
                Datos de actividad económica
              </v-card-title>
              <v-card-text>
                <section v-if="vigencia == true">
                  <v-text-field
                    v-model="nombre"
                    label="Ingrese nombre de la actividad"
                    placeholder="Actividad Económica"
                  ></v-text-field>
                  <v-text-field
                    v-model="descripcion"
                    label="Ingrese descripción de la actividad"
                    placeholder="Descripción"
                  ></v-text-field>
                </section>
                <section v-else>
                  <p>
                    <span class="font-weight-medium">{{ nombreItem }}</span>
                    está eliminada pero aún puedes restaurarla. Los vinculos a
                    ésta actividad económica ya no se podrán recuperar.
                  </p>
                  <v-btn flat block @click="recuperar">
                    Recuperar actividad económica
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
          ¿Seguro que desea eliminar? Algunos cambios son irreversibles
        </v-card-title>
        <v-card-text>
          <p>
            Antes de eliminar, seleccione la actividad económica que reemplazará
            a
            <span class="font-weight-medium">{{ nombreItem }}</span> en caso
            ésta se esté usando.
          </p>
          <v-select
            :items="dialogSelects"
            v-model="dialogSelect"
            item-text="nombre"
            item-value="codigo"
            label="Actividad económica"
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
import { get, post, put, patch } from "../bd/api";
import { mapMutations } from "vuex";
export default {
  components: {
    MantSelect: () => import("./MantSelect")
  },
  data: () => ({
    isEdit: false,
    dialog: false,
    dialogSelect: "0",

    lista: [],
    item: undefined,

    nombre: "",
    descripcion: "",
    vigencia: 1
  }),
  computed: {
    dialogSelects() {
      if (!this.item) return;
      let items = this.lista.filter(
        e => e.vigencia && e.codigo != this.item.codigo
      );
      items.unshift({ nombre: "Ninguna", codigo: "0" });
      return items;
    },
    nombreItem() {
      if (this.item) return this.item.nombre;
      else return "";
    }
  },
  methods: {
    ...mapMutations(["snackbar"]),
    validar() {
      if (this.nombre == "") {
        this.snackbar("Ingrese nombre de la actividad económica");
        return false;
      }
      if (this.descripcion == "") {
        this.snackbar("Ingrese la descripción de la actividad económica");
        return false;
      }
      return true;
    },
    nuevo() {
      this.isEdit = false;
      this.item = undefined;
      this.dialogSelect = "0";
      this.nombre = "";
      this.descripcion = "";
      this.vigencia = 1;
    },
    copiarDatos() {
      if (this.item) {
        this.isEdit = true;
        this.dialogSelect = "0";
        this.nombre = this.item.nombre;
        this.descripcion = this.item.descripcion;
        this.vigencia = this.item.vigencia;
      } else this.nuevo();
    },
    agregar() {
      if (!this.validar()) return;
      post("actividadEconomica/add", {
        nombre: this.nombre,
        descripcion: this.descripcion
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
      put("actividadEconomica/" + this.item.codigo, {
        nombre: this.nombre,
        descripcion: this.descripcion
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
        }
      });
    },
    eliminar() {
      patch("actividadEconomica/" + this.item.codigo, {
        vigencia: true,
        actividad: this.dialogSelect
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
      patch("actividadEconomica/" + this.item.codigo, {
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
      get("actividades-objeto").then(res => {
        this.lista = res.data.map(e => ({
          ...e,
          vigencia: parseInt(e.vigencia)
        }));
      });
    },
    cargarTodo() {
      this.cargarLista();
    }
  },
  created() {
    this.cargarTodo();
  }
};
</script>

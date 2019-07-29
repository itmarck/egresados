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
            placeholder="Seleccione Centro Laboral"
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
                  class="text-capitalize"
                  :style="data.item.vigencia ? '' : 'opacity: .3'"
                >
                  <v-list-tile-title v-html="data.item.nombre" />
                  <v-list-tile-sub-title
                    v-html="data.item.Distrito.toLowerCase()"
                  />
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
                Datos de centro laboral
              </v-card-title>
              <v-card-text>
                <section v-if="vigencia == true">
                  <v-text-field
                    v-model="nombre"
                    label="Ingrese razon social del centro laboral"
                    placeholder="CETI"
                    append-icon="poll"
                  ></v-text-field>
                  <v-text-field
                    v-model="ruc"
                    label="Ingrese RUC del centro laboral"
                    placeholder="Este campo es opcional"
                    append-icon="location_city"
                  ></v-text-field>
                  <v-select
                    v-model="actividad"
                    :items="actividades"
                    label="Escriba la actividad económica"
                    placeholder="Tecnología"
                    item-text="nombre"
                    item-value="codigo"
                  ></v-select>
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
    ruc: "",
    actividades: [],
    actividad: "",
    departamentos: [],
    departamento: "",
    provincias: [],
    provincia: "",
    distritos: [],
    distrito: "",
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
        this.snackbar("Ingrese nombre del centro laboral");
        return false;
      }
      if (this.actividad == "") {
        this.snackbar("Ingrese actividad económica");
        return false;
      }
      if (this.distrito == "") {
        this.snackbar("Indica el lugar donde se encuentra ubicado");
        return false;
      }
      return true;
    },
    nuevo() {
      this.isEdit = false;
      this.item = undefined;
      this.dialogSelect = "0";
      this.nombre = "";
      this.ruc = "";
      this.actividad = "";
      this.departamento = "";
      this.provincia = "";
      this.distrito = "";
      this.vigencia = 1;
    },
    copiarDatos() {
      if (this.item) {
        this.isEdit = true;
        this.dialogSelect = "0";
        this.vigencia = this.item.vigencia;
        this.nombre = this.item.nombre;
        this.ruc = this.item.RUC;
        this.actividad = this.item.codigoActividad;
        this.departamento = this.item.departamento;
        this.provincias = [];
        get("provincias/" + this.item.departamento).then(res => {
          this.provincias = res.data;
          this.provincia = this.item.provincia;
          this.distritos = [];
          get("distritos/" + this.item.provincia).then(res => {
            this.distritos = res.data;
            this.distrito = this.item.codigoDistrito;
          });
        });
      } else this.nuevo();
    },
    agregar() {
      if (!this.validar()) return;
      post("centroLaboral/add", {
        codigoActividad: this.actividad,
        codigoDistrito: this.distrito,
        RUC: this.ruc,
        razonSocial: this.nombre
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
      put("centroLaboral/" + this.item.codigo, {
        codigoActividad: this.actividad,
        codigoDistrito: this.distrito,
        RUC: this.ruc,
        razonSocial: this.nombre
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
        }
      });
    },
    eliminar() {
      patch("centroLaboral/" + this.item.codigo, {
        vigencia: true,
        centro: this.dialogSelect
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
      patch("centroLaboral/" + this.item.codigo, {
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
      get("centroLaboral").then(res => {
        this.lista = res.data.map(e => ({
          ...e,
          vigencia: parseInt(e.vigencia)
        }));
      });
    },
    cargarActividades() {
      get("actividades-objeto").then(res => (this.actividades = res.data));
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
    },
    cargarTodo() {
      this.cargarLista();
      this.cargarDepartamentos();
      this.cargarActividades();
    }
  },
  created() {
    this.cargarTodo();
  }
};
</script>

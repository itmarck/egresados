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
            placeholder="Seleccione Distrito"
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
              <span class="text-capitalize">
                {{ data.item.nombre.toLowerCase() }}
              </span>
            </template>
            <template v-slot:item="data">
              <template>
                <v-list-tile-content
                  :style="data.item.vigencia ? '' : 'opacity: .3'"
                >
                  <v-list-tile-title
                    class="text-capitalize"
                    v-html="data.item.nombre.toLowerCase()"
                  />
                  <v-list-tile-sub-title class="text-capitalize">
                    {{
                      (
                        data.item.provincia +
                        " - " +
                        data.item.departamento
                      ).toLowerCase()
                    }}
                  </v-list-tile-sub-title>
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
                Datos de distrito
              </v-card-title>
              <v-card-text>
                <section v-if="vigencia == true">
                  <div v-if="!isEdit">
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
                      :disabled="departamento == ''"
                    ></v-select>
                  </div>
                  <v-text-field
                    v-model="nombre"
                    label="Ingrese nombre del distrito"
                    placeholder="Distrito"
                    :disabled="provincia == ''"
                  ></v-text-field>
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

    departamentos: [],
    departamento: "",
    provincias: [],
    provincia: "",
    nombre: "",
    vigencia: 1
  }),
  computed: {
    nombreItem() {
      if (this.item) return this.item.nombre;
      else return "";
    }
  },
  methods: {
    ...mapMutations(["snackbar"]),
    validar() {
      if (this.departamento == "" && !this.isEdit) {
        this.snackbar("Seleccione Departamento");
        return false;
      }
      if (this.provincia == "" && !this.isEdit) {
        this.snackbar("Seleccione Provincia");
        return false;
      }
      if (this.nombre == "") {
        this.snackbar("Ingrese nombre del Distrito");
        return false;
      }
      return true;
    },
    nuevo() {
      this.isEdit = false;
      this.item = undefined;
      this.departamento = "";
      this.provincia = "";
      this.nombre = "";
      this.vigencia = 1;
    },
    copiarDatos() {
      if (this.item) {
        this.isEdit = true;
        this.nombre = this.item.nombre;
        this.vigencia = this.item.vigencia;
      } else this.nuevo();
    },
    agregar() {
      if (!this.validar()) return;
      post("distritos", {
        departamento: this.departamento,
        provincia: this.provincia,
        nombre: this.nombre
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
      put("distritos/" + this.item.codigo, {
        nombre: this.nombre.toUpperCase()
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          this.cargarTodo();
        }
      });
    },
    eliminar() {
      patch("distritos/" + this.item.codigo, {
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
      patch("distritos/" + this.item.codigo, {
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
      get("distritos-objeto").then(res => {
        this.lista = res.data.map(e => ({
          ...e,
          vigencia: parseInt(e.vigencia)
        }));
      });
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
    cargarTodo() {
      this.cargarLista();
      this.cargarDepartamentos();
    }
  },
  created() {
    this.cargarTodo();
  }
};
</script>

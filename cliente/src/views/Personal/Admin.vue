<template>
  <v-container grid-list-lg>
    <v-layout row wrap>
      <!-- Gestion de personal -->
      <v-flex xs12 md6>
        <v-layout row wrap>
          <!-- Select -->
          <v-flex xs12>
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
          <v-flex>
            <v-layout row wrap>
              <v-flex xs12>
                <v-card>
                  <v-card-title class="title font-weight-light" primary-title>
                    Datos de personal
                  </v-card-title>
                  <v-card-text v-if="!isSelect">
                    <v-text-field
                      v-model="correo"
                      label="Ingrese correo a registrar"
                      placeholder="personal@unprg.edu.pe"
                    ></v-text-field>
                    <p class="body-1 font-weight-light">
                      El personal deberá registrar sus datos personal al
                      ingresar a la cuenta
                    </p>
                  </v-card-text>
                  <v-card-text v-else>
                    <section v-if="vigencia == true">
                      <p class="font-weight-medium">
                        {{ personal.correo }}
                      </p>
                      <p class="body-1 font-weight-light">
                        Ésta cuenta está habilitada y puede realizar cambios en
                        la base de datos
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
                      <v-btn flat block @click="recuperar">
                        Recuperar Personal
                      </v-btn>
                    </section>
                  </v-card-text>
                </v-card>
              </v-flex>
              <v-btn v-if="!isSelect" @click="registrar">
                Registrar personal
              </v-btn>
              <v-btn v-else-if="vigencia" @click="dialogPersonal = true">
                Inhabilitar
              </v-btn>
              <v-btn outline @click="limpiar">Limpiar</v-btn>
            </v-layout>
          </v-flex>
        </v-layout>
      </v-flex>
      <!-- Dialog para eliminar -->
      <v-dialog v-model="dialogPersonal" persistent max-width="360">
        <v-card>
          <v-card-title class="title" primary-title>
            ¿Seguro que desea eliminar?
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
    </v-layout>
  </v-container>
</template>

<script>
import { get } from "../../bd/api";
export default {
  data: () => ({
    isSelect: false,
    personales: [],
    personal: {},
    correo: "",
    vigencia: true,
    dialogPersonal: false
  }),
  methods: {
    seleccionarPersonal() {
      this.isSelect = true;
      this.vigencia = parseInt(this.personal.vigencia);
    },
    limpiar() {
      this.isSelect = false;
      this.personal = {};
    },
    registrar() {},
    recuperar() {},
    quitarPersonal() {},
    cargarPersonal() {
      get("personal").then(res => (this.personales = res.data));
    },
    cargarTodo() {
      this.cargarPersonal();
    }
  },
  created() {
    this.cargarTodo();
  }
};
</script>


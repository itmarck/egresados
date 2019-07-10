<template>
  <v-container grid-list-lg>
    <v-layout row wrap>
      <!-- Carrera card -->
      <v-flex xs12 md6 xl4>
        <v-card>
          <v-card-title class="title font-weight-light" primary-title>
            Datos de carrera
          </v-card-title>
          <v-card-text>
            <v-form>
              <v-combobox
                v-model="univerisidad"
                label="Seleccione universidad"
                :items="universidades"
                item-text="nombre"
                item-value="codigo"
                placeholder="Universidad"
                @change="cargarEscuelas(univerisidad.codigo)"
              ></v-combobox>
              <v-combobox
                v-model="escuela"
                label="Seleccione escuela"
                :items="escuelas"
                item-text="nombre"
                item-value="codigo"
                placeholder="Escuela"
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
      <v-flex xs12 md6 xl4>
        <v-card>
          <v-card-title class="title font-weight-light" primary-title>
            Datos de adminisión
          </v-card-title>
          <v-card-text>
            <v-form>
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
    </v-layout>
  </v-container>
</template>

<script>
import { url } from "../../bd/config";
export default {
  data: () => ({
    universidades: [],
    univerisidad: "",
    escuelas: [],
    escuela: "",
    fechaInicio: new Date().toISOString().substr(0, 10),
    inicio: false,
    fechaTermino: new Date().toISOString().substr(0, 10),
    termino: false,
    fechaAdmision: new Date().toISOString().substr(0, 10),
    admision: false,
    ciclo: "",
    modalidades: [],
    modalidad: null
  }),
  computed: {
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
    cargarEscuelas(codigo) {
      if (codigo) {
        fetch(url + "escuelasProfesionales/uni/" + codigo)
          .then(res => res.json())
          .then(res => {
            if (res.estado) this.escuelas = res.data;
          });
      }
    },
    cargarModalidades() {
      fetch(url + "modalidadesAdmision")
        .then(res => res.json())
        .then(data => (this.modalidades = data));
    },
    cargarUniversidades() {
      fetch(url + "universidades")
        .then(res => res.json())
        .then(data => (this.universidades = data));
    }
  },
  created() {
    this.cargarUniversidades();
    this.cargarModalidades();
  }
};
</script>


<template>
  <v-container grid-list-lg>
    <v-form @submit.prevent="">
      <v-layout row wrap>
        <!-- Registro -->
        <v-flex xs12 md6>
          <v-layout row wrap>
            <!-- Carrera card -->
            <v-flex xs12>
              <v-card>
                <v-card-title class="title font-weight-light" primary-title>
                  Datos de postgrado
                </v-card-title>
                <v-card-text>
                  <section>
                    <v-select
                      :items="carreras"
                      v-model="carrera"
                      item-text="nombreEscuela"
                      item-value="codigo"
                      placeholder="Seleccione carrera"
                      label="Nombre de la escuela de la carrera"
                      prepend-icon="school"
                    ></v-select>
                    <v-select
                      v-model="tipo"
                      :items="tipos"
                      item-text="nombre"
                      item-value="codigo"
                      label="Seleccione tipo de postgrado"
                      placeholder="Tipo"
                      prepend-icon="laptop"
                      persistent-hint
                      :hint="descripcion"
                    ></v-select>
                    <v-radio-group v-model="lugar" row>
                      <v-radio
                        color="primary"
                        label="Universidad"
                        value="U"
                      ></v-radio>
                      <v-radio
                        color="primary"
                        label="Centro de estudios"
                        value="C"
                      ></v-radio>
                    </v-radio-group>
                    <v-combobox
                      v-if="lugar == 'U'"
                      v-model="universidad"
                      label="Seleccione universidad"
                      :items="universidades"
                      placeholder="Universidad"
                    ></v-combobox>
                    <v-combobox
                      v-else
                      v-model="centro"
                      label="Seleccione Centro de Estudios"
                      :items="centros"
                      placeholder="Centro de Estudios"
                    ></v-combobox>
                    <v-text-field
                      v-model="nombre"
                      label="Nombre de postgrado"
                    ></v-text-field>
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
                    <v-select
                      :items="anios"
                      v-model="certificacion"
                      label="Año de certificación"
                      placeholder="Certificación"
                    ></v-select>
                  </section>
                </v-card-text>
              </v-card>
            </v-flex>
            <v-btn color="primary" v-if="isEdit" @click="editar" type="submit">
              Editar
            </v-btn>
            <v-btn color="primary" v-else @click="agregar" type="submit">
              Agregar
            </v-btn>
            <v-btn color="primary" outline @click="nuevo">Limpiar</v-btn>
          </v-layout>
        </v-flex>

        <!-- Lista card -->
        <v-flex xs12 md6>
          <v-card>
            <v-list three-line>
              <v-list-tile
                v-for="postgrado of lista"
                :key="postgrado.codigo"
                @click="copiarDatos(postgrado)"
              >
                <v-list-tile-content>
                  <v-list-tile-title v-html="postgrado.nombre" />
                  <v-list-tile-sub-title>
                    <span v-if="postgrado.lugar == 'U'">
                      {{ postgrado.universidad }}
                    </span>
                    <span else>{{ postgrado.razonSocial }}</span>
                    {{
                      `(${postgrado.fechaInicio.substring(0, 4)} - 
                    ${postgrado.fechaTermino.substring(0, 4)})`
                    }}
                  </v-list-tile-sub-title>

                  <v-list-tile-sub-title v-html="postgrado.tipo" />
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </v-card>
        </v-flex>
        <v-snackbar
          v-model="snack"
          bottom
          left
          :timeout="6000"
          color="secondary"
        >
          {{ respuesta }}
          <v-btn color="bright" flat @click="snack = false">Cerrar</v-btn>
        </v-snackbar>
      </v-layout>
    </v-form>
  </v-container>
</template>

<script>
import { get, post } from "../../bd/api";
import { mapState } from "vuex";
export default {
  data: () => ({
    carreras: [],
    carrera: "",
    tipos: [],
    tipo: "",
    lugar: "U",
    universidades: [],
    universidad: "",
    centros: [],
    centro: "",
    nombre: "",
    fechaInicio: new Date().toISOString().substr(0, 10),
    inicio: false,
    fechaTermino: new Date().toISOString().substr(0, 10),
    termino: false,
    certificacion: "2019",
    lista: [],
    isEdit: false,
    snack: false,
    respuesta: "Algo falló"
  }),
  computed: {
    ...mapState(["user"]),
    descripcion() {
      if (this.tipo) {
        return this.tipos[this.tipo - 1].descripcion;
      }
    },
    anios() {
      let anios = [];
      let anioActual = new Date().getFullYear();
      for (let i = 0; i < 50; i++) {
        anios.push((anioActual - i).toString());
      }
      return anios;
    }
  },
  methods: {
    editar() {},
    agregar() {
      let datos = {
        codigoEgresado: this.carrera,
        codigoTipo: this.tipo,
        nombre: this.nombre,
        fechaInicio: this.fechaInicio,
        fechaTermino: this.fechaTermino,
        anioCertificacion: this.certificacion
      };
      if (this.lugar == "U")
        datos = { ...datos, universidad: this.universidad };
      else datos = { ...datos, centroEstudios: this.centro };

      post("estudiosPostgrado/add", datos).then(res => {
        this.respuesta = res.mensaje;
        this.snack = true;
        if (res.estado == true) {
          this.cargarTodo();
          this.nuevo();
        }
      });
    },
    copiarDatos(postgrado) {
      this.isEdit = true;
      this.carrera = postgrado.codigoEgresado;
      this.tipo = postgrado.codigoTipo;
      this.fechaInicio = postgrado.fechaInicio;
      this.fechaTermino = postgrado.fechaTermino;
      this.nombre = postgrado.nombre;
      this.certificacion = postgrado.anioCertificacion;
      if (postgrado.lugar == "U") {
        this.lugar = "U";
        this.universidad = postgrado.universidad;
        this.centro = "";
      } else {
        this.lugar = "C";
        this.centro = postgrado.razonSocial;
        this.universidad = "";
      }
    },
    nuevo() {
      this.isEdit = false;
      this.carrera = "";
      this.tipo = "";
      this.fechaInicio = new Date().toISOString().substring(0, 10);
      this.fechaTermino = new Date().toISOString().substring(0, 10);
      this.nombre = "";
      this.certificacion = "2019";
      this.lugar = "U";
      this.universidad = "";
      this.centro = "";
    },
    cargarTodo() {
      this.cargarUniversidades();
      this.cargarCentrosEstudio();
      this.cargarLista();
    },
    cargarTipos() {
      get("tiposPostgrado").then(res => (this.tipos = res.data));
    },
    cargarUniversidades() {
      get("universidades").then(res => (this.universidades = res.data));
    },
    cargarCentrosEstudio() {
      get("centroEstudios").then(res => (this.centros = res.data));
    },
    cargarLista() {
      get("estudiosPostgrado/" + this.user.dni).then(
        res => (this.lista = res.data)
      );
    },
    cargarCarreras() {
      get("carreras/" + this.user.dni).then(res => (this.carreras = res.data));
    }
  },
  created() {
    this.cargarTodo();
    this.cargarTipos();
    this.cargarCarreras();
  }
};
</script>

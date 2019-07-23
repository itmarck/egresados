<template>
  <v-container grid-list-lg>
    <v-layout row wrap>
      <!-- Vista del perfil -->
      <v-flex xs12 xl7>
        <v-layout row wrap justify-center>
          <v-flex xs12 sm4 lg3 xl4>
            <v-card>
              <v-img src="http://localhost/egresados/servidor/src/public/images/imagen.jpeg" />
            </v-card>
          </v-flex>
          <v-flex xs12 sm8 lg9 xl8>
            <v-card>
              <v-card-title class="title font-weight-light">
                <span>
                  {{ persona.nombres + " " + persona.apellidoPaterno }}
                </span>
                <v-spacer></v-spacer>
                <v-btn flat icon @click="cambiarPrivacidad">
                  <v-icon v-if="persona.privacidad">public</v-icon>
                  <v-icon v-else>lock</v-icon>
                </v-btn>
              </v-card-title>
              <v-card-text>
                DNI: {{ persona.dni }} <br />
                Aca van los datos de la persona
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn flat color="primary" @click="editar">
                  Editar perfil
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-flex>
      <v-flex xs12 xl5 v-if="isEdit">
        <v-form @submit.prevent="guardar">
          <v-layout row wrap>
            <v-flex xs12>
              <v-card>
                <v-card-text>
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
                    v-model="correo"
                    prepend-icon="email"
                    label="Ingrese correo"
                    placeholder="Correo"
                    type="email"
                    hint="Este correo te va servir para recuperar la contraseña"
                  />
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
                  <v-text-field
                    label="Seleccione foto de perfil"
                    @click="pickFile"
                    v-model="imageName"
                    prepend-icon="photo"
                  ></v-text-field>
                  <input
                    type="file"
                    style="display: none"
                    ref="image"
                    accept="image/*"
                    @change="onFilePicked"
                  />
                </v-card-text>
              </v-card>
            </v-flex>
            <v-flex xs12>
              <v-btn block color="primary" type="submit">Guardar cambios</v-btn>
            </v-flex>
          </v-layout>
        </v-form>
      </v-flex>
      <!-- Snackbar -->
      <v-snackbar v-model="snack" bottom left :timeout="6000" color="secondary">
        {{ respuesta }}
        <v-btn color="bright" flat @click="snack = false">Cerrar</v-btn>
      </v-snackbar>
    </v-layout>
  </v-container>
</template>

<script>
import { get, put, patch, setUser, getUser } from "../../bd/api";
import { mapState } from "vuex";
export default {
  data: () => ({
    isEdit: false,
    respuesta: "",
    snack: false,

    persona: {},
    correo: "",
    nombres: "",
    paterno: "",
    materno: "",
    genero: "1",
    fechaNacimiento: new Date().toISOString().substring(0, 10),
    fecha: false,
    celular: "",
    estados: [
      { codigo: "C", texto: "Casado" },
      { codigo: "S", texto: "Soltero" },
      { codigo: "V", texto: "Viudo" },
      { codigo: "D", texto: "Divorciado" }
    ],
    estadoCivil: "",

    imageName: "",
    imageUrl: "",
    imageFile: ""
  }),
  computed: {
    ...mapState(["user"])
  },
  methods: {
    guardar() {
      let datos = {
        dni: this.persona.dni,
        nombres: this.nombres,
        paterno: this.paterno,
        materno: this.materno,
        genero: this.genero,
        fecha: this.fechaNacimiento,
        celular: this.celular,
        correo: this.correo,
        estado: this.estadoCivil
      };
      put("personas/" + this.persona.codigo, datos).then(res => {
        this.respuesta = res.mensaje;
        this.snack = true;
        if (res.estado == true) {
          this.cargarDatos();
          this.isEdit = false;
        }
      });
    },
    actualizarUsuario() {
      let user = getUser();
      let newUser = {
        ...user,
        nombres: this.persona.nombres,
        apellidoPaterno: this.persona.apellidoPaterno,
        apellidoMaterno: this.persona.apellidoMaterno,
        nombre:
          this.persona.nombres +
          " " +
          this.persona.apellidoPaterno +
          " " +
          this.persona.apellidoMaterno,
        urlFoto: this.foto
      };
      setUser(newUser);
    },
    editar() {
      this.copiarDatos();
      this.isEdit = true;
    },
    copiarDatos() {
      this.isEdit = true;
      this.correo = this.persona.correo;
      this.nombres = this.persona.nombres;
      this.paterno = this.persona.apellidoPaterno;
      this.materno = this.persona.apellidoMaterno;
      this.genero = this.persona.genero;
      this.fechaNacimiento = this.persona.fechaNacimiento;
      this.celular = this.persona.celular;
      this.estadoCivil = this.persona.estadoCivil;
    },
    cargarDatos() {
      get("personas/" + this.user.dni).then(res => {
        this.persona = res.data;
        this.actualizarUsuario();
      });
    },
    cambiarPrivacidad() {
      // Falta campo privacidad en la bd
    },
    onFilePicked(e) {
      const files = e.target.files;
      if (files[0] !== undefined) {
        this.imageName = files[0].name;
        if (this.imageName.lastIndexOf(".") <= 0) {
          return;
        }
        const fr = new FileReader();
        fr.readAsDataURL(files[0]);
        fr.addEventListener("load", () => {
          this.imageUrl = fr.result;
          this.imageFile = files[0];
        });
      } else {
        this.imageName = "";
        this.imageFile = "";
        this.imageUrl = "";
      }
    },
    pickFile() {
      this.$refs.image.click();
    }
  },
  created() {
    this.cargarDatos();
  }
};
</script>


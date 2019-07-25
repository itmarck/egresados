<template>
  <v-container grid-list-lg>
    <v-layout row wrap justify-center v-if="persona != null">
      <!-- Vista del perfil -->
      <v-flex xs12 xl7>
        <v-layout row wrap justify-center>
          <v-flex>
            <v-card>
              <v-img :src="urlFoto" aspect-ratio="1" />
            </v-card>
          </v-flex>
          <v-flex xs12 sm8 lg9 xl8>
            <v-card>
              <v-container>
                <v-card-title class="title font-weight-light">
                  <span>
                    {{ persona.nombres }} <br />
                    {{ persona.apellidoPaterno }}
                    {{ persona.apellidoMaterno }}
                  </span>
                  <v-spacer></v-spacer>
                  <v-btn flat icon @click="editar">
                    <v-icon>edit</v-icon>
                  </v-btn>
                  <v-btn flat icon @click="cambiarPrivacidad">
                    <v-icon v-if="!privacidad">public</v-icon>
                    <v-icon v-else>lock</v-icon>
                  </v-btn>
                </v-card-title>
                <v-card-text>
                  <v-layout column align-start pl-2 pb-3>
                    <p class="body-1">
                      <span class="font-weight-medium"> DNI </span>
                      <span class="font-weight-light"> {{ persona.dni }}</span>
                      <!-- <v-icon small left>featured_video</v-icon> -->
                    </p>
                    <div class="body-1">
                      <v-icon small left>email</v-icon>
                      <span class="font-weight-light">
                        {{ persona.correo }}
                      </span>
                    </div>
                    <div class="body-2">
                      <v-icon small left>event</v-icon>
                      <span class="font-weight-light">
                        {{
                          new Date(
                            persona.fechaNacimiento.replace(/-/g, "\/")
                          ).toLocaleDateString("es-ES", {
                            year: "numeric",
                            month: "long",
                            day: "numeric"
                          })
                        }}
                      </span>
                    </div>
                    <div class="body-1">
                      <v-icon small left>phone_android</v-icon>
                      <span class="font-weight-light">
                        {{ persona.celular }}
                      </span>
                    </div>
                  </v-layout>
                </v-card-text>
              </v-container>
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
    </v-layout>
  </v-container>
</template>

<script>
import { get, put, patch, setUser, getUser, uploadPhoto } from "../../bd/api";
import { urlImage } from "../../bd/config";
import { mapState, mapMutations } from "vuex";
export default {
  data: () => ({
    isEdit: false,
    persona: null,
    correo: "",
    nombres: "",
    paterno: "",
    materno: "",
    genero: "1",
    fechaNacimiento: new Date().toISOString().substring(0, 10),
    fecha: false,
    celular: "",
    estados: [
      { codigo: "S", texto: "Soltero" },
      { codigo: "C", texto: "Casado" },
      { codigo: "N", texto: "Conviviente" },
      { codigo: "D", texto: "Divorciado" },
      { codigo: "P", texto: "Separado" },
      { codigo: "V", texto: "Viudo" }
    ],
    estadoCivil: "",
    imageName: "",
    imageUrl: "",
    imageFile: ""
  }),
  computed: {
    ...mapState(["user"]),
    urlFoto() {
      return urlImage + this.user.urlFoto;
    },
    privacidad() {
      if (this.persona) return parseInt(this.persona.privacidad);
    }
  },
  methods: {
    ...mapMutations(["snackbar"]),
    validar() {
      if (this.nombres == "" || this.paterno == "" || this.materno == "") {
        this.snackbar("Ingrese los nombres completos");
        return false;
      }
      if (this.correo == "") {
        this.snackbar("Ingrese correo");
        return false;
      }
      return true;
    },
    guardar() {
      if (!this.validar()) return;
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
        let respuesta = res.mensaje;
        if (res.estado == true) {
          if (this.imageFile != "")
            uploadPhoto(
              "personas/images/" + this.user.codigo,
              this.imageFile
            ).then(res => {
              this.cargarDatos();
              this.snackbar(res.mensaje + " " + respuesta);
            });
          this.cargarDatos();
          this.isEdit = false;
        }
        this.snackbar(respuesta);
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
        urlFoto: this.persona.urlFoto
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
      patch("personas/privacidad/" + this.user.codigo, {
        privacidad: this.persona.privacidad
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) this.cargarDatos();
      });
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


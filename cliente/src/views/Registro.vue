<template>
  <v-content>
    <public-toolbar></public-toolbar>
    <v-container grid-list-lg>
      <v-form @submit.prevent="registrar">
        <v-layout justify-center>
          <v-flex xs12 sm8 md6 xl4>
            <v-layout row wrap>
              <v-flex xs12>
                <v-card>
                  <v-card-text>
                    <v-form>
                      <v-text-field
                        v-model="correo"
                        prepend-icon="email"
                        label="Ingrese correo"
                        placeholder="Correo"
                        type="email"
                        hint="Este correo te va servir para recuperar la contraseña"
                      />
                      <v-text-field
                        v-model="usuario"
                        prepend-icon="person"
                        label="Usuario"
                        placeholder="Nombre de usuarios"
                        type="text"
                      />
                      <v-text-field
                        v-model="password"
                        prepend-icon="lock"
                        label="Contraseña"
                        placeholder="Contraseña"
                        type="password"
                        hint="Mínimo 6 caracteres"
                      />
                      <v-text-field
                        v-model="repeatPassword"
                        prepend-icon="autorenew"
                        label="Vuelva a ingresar la contraseña"
                        placeholder="Repetir contraseña"
                        type="password"
                      />
                      <v-text-field
                        v-model="dni"
                        prepend-icon="featured_video"
                        label="Ingrese el DNI"
                        placeholder="DNI"
                        type="text"
                      />
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
                    </v-form>
                  </v-card-text>
                </v-card>
              </v-flex>
              <v-flex xs12>
                <v-btn block color="primary" type="submit">Registrarse</v-btn>
              </v-flex>
            </v-layout>
          </v-flex>
        </v-layout>
      </v-form>
    </v-container>
  </v-content>
</template>

<script>
import { post, setUser } from "../bd/api";
import { mapMutations } from "vuex";
export default {
  components: {
    PublicToolbar: () => import("../components/PublicToolbar")
  },
  data: () => ({
    correo: "",
    usuario: "",
    password: "",
    repeatPassword: "",
    dni: "",
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
    estadoCivil: ""
  }),
  methods: {
    ...mapMutations(["snackbar"]),
    validar() {
      if (this.correo == "") {
        this.snackbar("Ingrese el correo");
        return false;
      }
      if (this.usuario == "") {
        this.snackbar("Ingrese el nombre de usuario");
        return false;
      }
      if (this.password.length < 6) {
        this.snackbar("La contraseña debe tener como mínimo 6 caracteres");
        return false;
      }
      if (this.dni == "") {
        this.snackbar("Ingrese número de DNI");
        return false;
      }
      if (this.password != this.repeatPassword) {
        this.snackbar("Las contraseñas no coinciden");
        return false;
      }
      return true;
    },
    registrar() {
      if (!this.validar()) return;
      post("personas", {
        dni: this.dni,
        correo: this.correo,
        usuario: this.usuario,
        clave: this.password,
        nombres: this.nombres,
        paterno: this.paterno,
        materno: this.materno,
        genero: this.genero,
        fecha: this.fechaNacimiento,
        celular: this.celular,
        estado: this.estadoCivil
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          post("usuarios/ingresar", {
            nombre: this.usuario,
            clave: this.password
          }).then(res => {
            if (res.estado == true) {
              setUser(res.data);
              this.$router.push("/login");
            }
          });
        }
      });
    }
  }
};
</script>


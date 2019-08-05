<template>
  <v-content>
    <public-toolbar></public-toolbar>
    <v-container fill-height grid-list-lg>
      <v-layout align-center justify-center>
        <v-flex xs12 sm8 md6 xl4>
          <v-form @submit.prevent="ingresar">
            <v-layout row wrap>
              <v-flex xs12>
                <v-card>
                  <v-card-text>
                    <v-text-field
                      v-model="usuario"
                      prepend-icon="person"
                      label="Usuario"
                      placeholder="Nombre de usuario"
                      type="text"
                    />
                    <v-text-field
                      v-model="clave"
                      prepend-icon="lock"
                      label="Contraseña"
                      placeholder="Contraseña"
                      type="password"
                    />
                  </v-card-text>
                </v-card>
              </v-flex>
              <v-flex xs12>
                <v-btn type="submit" block color="primary">Ingresar</v-btn>
              </v-flex>
              <v-flex xs12 d-flex>
                <v-btn
                  flat
                  class="caption font-weight-light text-xs-center"
                  color="secondary"
                  @click="dialog = true"
                >
                  Olvidé mi contraseña
                </v-btn>
              </v-flex>
            </v-layout>
          </v-form>
        </v-flex>
      </v-layout>
      <!-- Dialog para recuperar -->
      <v-dialog v-model="dialog" persistent max-width="480">
        <v-form @submit.prevent="recuperar">
          <v-card>
            <v-card-title class="font-weight-light" primary-title>
              Te enviaremos con un enlace a tu correo para recuperar tu cuenta y
              cambiar la contraseña.
            </v-card-title>
            <v-card-text>
              <v-text-field
                v-model="correo"
                append-icon="email"
                label="Correo registrado"
                placeholder="correo@ejemplo.com"
                type="text"
              />
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn flat @click="dialog = false">Cancelar</v-btn>
              <v-btn flat color="primary" type="submit">
                <span v-if="!enviando">Aceptar</span>
                <v-progress-circular
                  v-else
                  size="20"
                  width="2"
                  indeterminate
                  color="primary"
                ></v-progress-circular>
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-form>
      </v-dialog>
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
    usuario: "",
    clave: "",

    dialog: false,
    correo: "",
    enviando: false
  }),
  methods: {
    ...mapMutations(["snackbar"]),
    validar() {
      if (this.correo == "") {
        this.snackbar("Ingrese correo donde se enviará el enlace");
        return false;
      }
      const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      if (!pattern.test(this.correo)) {
        this.snackbar("Ingrese un correo válido");
        return false;
      }
      return true;
    },
    ingresar() {
      post("usuarios/ingresar", {
        nombre: this.usuario,
        clave: this.clave
      }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) {
          setUser(res.data);
          this.$router.push("/registro");
        }
      });
    },
    recuperar() {
      if (!this.validar()) return;
      this.enviando = true;
      post("recuperar", { correo: this.correo }).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) this.limpiar();
        else this.enviando = false;
      });
    },
    limpiar() {
      this.dialog = false;
      this.usuario = "";
      this.clave = "";
      this.correo = "";
      this.enviando = false;
    }
  }
};
</script>


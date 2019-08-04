<template>
  <v-content>
    <!-- Toolbar -->
    <v-toolbar color="primary" dark app>
      <v-toolbar-title>
        <span class="font-weight-black">UNPRG </span>
        <span class="font-weight-light">EGRESADOS</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-btn flat to="/login"> Ingresar </v-btn>
      </v-toolbar-items>
    </v-toolbar>
    <!-- Vista -->
    <v-container fill-height grid-list-lg>
      <v-layout justify-center align-center>
        <v-flex xs12 sm8 md6 xl4 v-if="persona.nombres && !invalido">
          <v-form @submit.prevent="cambiar">
            <v-layout row wrap>
              <v-flex xs12>
                <v-card>
                  <v-card-title class="title font-weight-light" primary-title>
                    Hola, {{ persona.nombres }}
                  </v-card-title>
                  <v-card-text>
                    <v-text-field
                      v-model="clave"
                      label="Ingrese la nueva contraseña"
                      placeholder="Nueva contraseña"
                      hint="Mínimo 6 caracteres"
                      type="password"
                    ></v-text-field>
                    <v-text-field
                      v-model="repetir"
                      label="Repita la contraseña"
                      placeholder="Repetir nueva contraseña"
                      type="password"
                    ></v-text-field>
                  </v-card-text>
                </v-card>
              </v-flex>
              <v-flex xs12>
                <v-btn block color="primary" type="submit">
                  Recuperar contraseña
                </v-btn>
              </v-flex>
            </v-layout>
          </v-form>
        </v-flex>
        <v-flex d-flex xs12 sm8 md6 xl4 v-else-if="!invalido">
          <v-progress-circular
            indeterminate
            color="primary"
          ></v-progress-circular>
        </v-flex>
        <v-flex xs12 sm8 md6 xl4 v-else>
          <v-card>
            <v-card-title primary-title class="title font-weight-light">
              Enlace inválido o ha expirado
            </v-card-title>
            <v-card-text>
              Puede que éste enlace ya se haya usado. Si aún lo necesitas por
              favor reenvía el correo en el Inicio de sesión desde la opción
              <span class="font-weight-light">
                OLVIDÉ MI CONTRASEÑA
              </span>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn flat color="primary" to="/login">
                Ir a Reenviar correo
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
import { patch, get } from "../bd/api";
import { mapMutations } from "vuex";
export default {
  data: () => ({
    clave: "",
    repetir: "",

    persona: {},
    invalido: false
  }),
  methods: {
    ...mapMutations(["snackbar"]),
    validar() {
      if (this.clave.length < 6) {
        this.snackbar("La contraseña debe tener como mínimo 6 caracteres");
        return false;
      }
      if (this.clave != this.repetir) {
        this.snackbar("Las contraseñas no coinciden");
        return false;
      }
      return true;
    },
    cambiar() {
      if (!this.validar()) return;
      patch("recuperar/" + this.persona.codigo, { clave: this.clave }).then(
        res => {
          this.snackbar(res.mensaje);
          if (res.estado == true) this.$router.push("./login");
        }
      );
    }
  },
  created() {
    get("recuperar/" + this.$route.params.hash).then(res => {
      if (res.estado == true) this.persona = res.data;
      else this.invalido = true;
    });
  }
};
</script>



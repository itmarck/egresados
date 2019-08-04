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
        <v-btn flat to="login"> Ingresar </v-btn>
      </v-toolbar-items>
    </v-toolbar>
    <!-- Vista -->
    <v-container fill-height grid-list-lg>
      <v-layout justify-center align-center>
        <v-flex xs12 sm8 md6 xl4>
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

    persona: {}
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
      let datos = { tipo: "personal", clave: this.clave };
      if (this.persona.tipo == "E") datos = { ...datos, tipo: "persona" };
      patch("recuperar/" + this.persona.codigo, datos).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) this.$router.push("/login");
      });
    }
  },
  created() {
    get("recuperar/" + this.$route.params.hash).then(res => {
      this.persona = res.data;
    });
  }
};
</script>



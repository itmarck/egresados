<template>
  <v-container grid-list-lg>
    <v-form @submit.prevent="cambiar">
      <v-layout justify-center>
        <v-flex xs12 sm8 md6 xl4>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card>
                <v-card-title class="title font-weight-light" primary-title>
                  Cambiar contraseña
                </v-card-title>
                <v-card-text>
                  <v-text-field
                    v-model="actual"
                    label="Ingrese la contraseña actual"
                    placeholder="Contraseña actual"
                    type="password"
                  ></v-text-field>
                  <v-text-field
                    v-model="nueva"
                    label="Ingrese la nueva contraseña"
                    placeholder="Nueva contraseña"
                    hint="Mínimo 6 caracteres"
                    type="password"
                  ></v-text-field>
                </v-card-text>
              </v-card>
            </v-flex>
            <v-flex xs12>
              <v-btn block v-if="user.tipo != 'E'" type="submit">
                Cambiar contraseña
              </v-btn>
              <v-btn block v-else color="primary" type="submit">
                Cambiar contraseña
              </v-btn>
            </v-flex>
          </v-layout>
        </v-flex>
      </v-layout>
    </v-form>
  </v-container>
</template>

<script>
import { patch } from "../bd/api";
import { mapState, mapMutations } from "vuex";
export default {
  data: () => ({
    actual: "",
    nueva: ""
  }),
  computed: {
    ...mapState(["user"])
  },
  methods: {
    ...mapMutations(["snackbar"]),
    validar() {
      if (this.nueva.length < 6) {
        this.snackbar("La contraseña debe tener como mínimo 6 caracteres");
        return false;
      }
      return true;
    },
    cambiar() {
      if (!this.validar()) return;
      let datos = { tipo: "personal", actual: this.actual, nueva: this.nueva };
      if (this.user.tipo == "E") datos = { ...datos, tipo: "persona" };
      patch("usuarios/" + this.user.codigo, datos).then(res => {
        this.snackbar(res.mensaje);
        if (res.estado == true) this.limpiar();
      });
    },
    limpiar() {
      this.actual = "";
      this.nueva = "";
    }
  }
};
</script>



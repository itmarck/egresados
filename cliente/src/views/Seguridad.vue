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
    <!-- Snackbar -->
    <v-snackbar v-model="snack" bottom left :timeout="6000" color="secondary">
      {{ respuesta }}
      <v-btn color="bright" flat @click="snack = false">Cerrar</v-btn>
    </v-snackbar>
  </v-container>
</template>

<script>
import { patch } from "../bd/api";
import { mapState } from "vuex";
export default {
  data: () => ({
    actual: "",
    nueva: "",

    respuesta: "",
    snack: false
  }),
  computed: {
    ...mapState(["user"])
  },
  methods: {
    cambiar() {
      let datos = { tipo: "personal" };
      if (this.user.tipo == "E") datos = { tipo: "persona" };
      patch("usuarios/" + this.user.codigo, datos).then(res => {
        this.respuesta = res.mensaje;
        this.snack = true;
        if (res.estado == true) this.limpiar();
      });
    },
    limpiar() {
      this.actual = "";
      this.nuevo = "";
    }
  }
};
</script>



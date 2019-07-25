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
                >
                  Olvidé la contraseña
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
import { post, setUser } from "../bd/api";
import { mapMutations } from "vuex";
export default {
  components: {
    PublicToolbar: () => import("../components/PublicToolbar")
  },
  data: () => ({
    usuario: "",
    clave: ""
  }),
  methods: {
    ...mapMutations(["snackbar"]),
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
    }
  }
};
</script>


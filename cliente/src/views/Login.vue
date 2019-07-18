<template>
  <v-content>
    <public-toolbar></public-toolbar>
    <v-container fill-height grid-list-lg>
      <v-layout align-center justify-center>
        <v-flex xs12 sm8 md6 xl4>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card>
                <v-card-text>
                  <v-form>
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
                      hint="Mínimo 6 caracteres"
                      persistent-hint
                    />
                  </v-form>
                </v-card-text>
              </v-card>
            </v-flex>
            <v-flex xs12>
              <v-btn block color="primary" @click="ingresar">Ingresar</v-btn>
            </v-flex>
          </v-layout>
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
    </v-container>
  </v-content>
</template>

<script>
import { url } from "../bd/config";
export default {
  components: {
    PublicToolbar: () => import("../components/PublicToolbar")
  },
  data: () => ({
    usuario: "",
    clave: "",
    snack: false,
    respuesta: "Algo falló"
  }),
  methods: {
    ingresar() {
      let datos = {
        nombre: this.usuario,
        clave: this.clave
      };
      fetch(url + "usuarios/ingresar", {
        method: "POST",
        body: JSON.stringify(datos),
        headers: {
          "Content-Type": "application/json"
        }
      })
        .then(res => res.json())
        .then(res => {
          console.log(res);
          this.snack = true;
          this.respuesta = res.mensaje;
          if (res.estado == true) {
            localStorage.setItem("user", JSON.stringify(res.data));
            if (res.data.tipo == "E") {
              this.$router.push("/egresado");
            }
          }
        });
    }
  }
};
</script>


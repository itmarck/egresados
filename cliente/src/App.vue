<template>
  <v-app>
    <router-view />
    <v-snackbar
      :value="snack"
      bottom
      left
      :timeout="5000"
      color="secondary"
      @input="hideSnack"
    >
      {{ mensaje }}
      <v-btn color="bright" flat @click="hideSnack">Cerrar</v-btn>
    </v-snackbar>
  </v-app>
</template>

<script>
import { get, getUser, setUser, removeUser } from "./bd/api";
import { mapState, mapMutations } from "vuex";
export default {
  computed: {
    ...mapState(["mensaje", "snack"])
  },
  methods: {
    ...mapMutations(["hideSnack"])
  },
  created() {
    let user = getUser();
    if (!user) return;
    get("personas/" + user.dni).then(res => {
      if (res.estado == true) {
        setUser({
          ...user,
          nombres: res.data.nombres,
          apellidoPaterno: res.data.apellidoPaterno,
          apellidoMaterno: res.data.apellidoMaterno,
          urlFoto: res.data.urlFoto
        });
        if (parseInt(res.data.vigencia) == 0) {
          removeUser();
          this.$router.push("/login");
        }
      }
    });
  }
};
</script>


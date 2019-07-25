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
import { get, getUser, removeUser } from "./bd/api";
import { mapState, mapMutations } from "vuex";
export default {
  computed: {
    ...mapState(["mensaje", "snack"])
  },
  methods: {
    ...mapMutations(["hideSnack"])
  },
  created() {
    if (!getUser()) return;
    get("personas/" + getUser().dni).then(res => {
      if (res.estado == true) {
        if (parseInt(res.data.vigencia) == 0) {
          removeUser();
          this.$router.push("/login");
        }
      }
    });
  }
};
</script>


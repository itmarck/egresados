<template>
  <v-app>
    <router-view />
    <v-snackbar
      :value="snack"
      bottom
      left
      :multi-line="mensaje.length > 50"
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
import { get, getUser, userFromServer, removeUser } from "./bd/api";
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
    userFromServer().then(vigencia => {
      if (vigencia == 0) {
        removeUser();
        this.$router.push("/login");
      }
    });
  }
};
</script>


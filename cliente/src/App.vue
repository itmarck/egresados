<template>
  <v-app>
    <router-view />
  </v-app>
</template>

<script>
import { get, getUser, removeUser } from "./bd/api";
export default {
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


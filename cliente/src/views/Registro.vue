<template>
  <v-content>
    <public-toolbar></public-toolbar>
    <v-container grid-list-lg>
      
    </v-container>
  </v-content>
</template>

<script>
export default {
  components: {
    PublicToolbar: () => import("../components/PublicToolbar")
  }
};
</script>


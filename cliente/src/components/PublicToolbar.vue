<template>
  <v-toolbar color="primary" dark app>
    <v-toolbar-title>
      <span class="font-weight-black">UNPRG </span>
      <span class="font-weight-light">EGRESADOS</span>
    </v-toolbar-title>
    <v-spacer></v-spacer>
    <v-toolbar-items>
      <v-btn v-if="this.$route.path == '/registro'" flat to="login">
        Ingresar
      </v-btn>
      <v-btn v-else flat to="registro">Unirse</v-btn>
    </v-toolbar-items>
  </v-toolbar>
</template>

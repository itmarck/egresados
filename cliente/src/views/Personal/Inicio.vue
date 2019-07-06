<template>
  <v-container grid-list-xs>
    <v-toolbar app>
      <v-toolbar-side-icon @click="drawer = !drawer" class="hidden-md-and-up" />
      <v-toolbar-title>Personal</v-toolbar-title>
      <v-spacer />
      <v-toolbar-items>
        <v-btn
          flat
          class="hidden-sm-and-down"
          v-for="link of links"
          :key="link.text"
        >
          {{ link.text }}
        </v-btn>
      </v-toolbar-items>
    </v-toolbar>
    <v-navigation-drawer app v-model="drawer" temporary>
      <v-flex xs12 class="px-4 grey lighten-5">
        <v-img :src="require('@/assets/epici.svg')">
          <v-layout
            slot="placeholder"
          >
            <v-progress-circular
              indeterminate
              color="grey lighten-5"
            ></v-progress-circular>
          </v-layout>
        </v-img>
        <p class="google-font mt-2" style="font-size:130%">Hola</p>
      </v-flex>
      <v-list>
        <v-list-tile
          v-for="(link, i) in links"
          :key="i"
          :to="link.to"
          :href="link.href"
          @click="onClick($event, link)"
          class="google-font"
        >
          <v-list-tile-action>
            <v-icon>{{ link.icon }}</v-icon>
          </v-list-tile-action>

          <v-list-tile-content>
            <v-list-tile-title v-text="link.text" />
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>
    <v-content>
      <router-view></router-view>
    </v-content>
  </v-container>
</template>

<script>
export default {
  data: () => ({
    drawer: false,
    links: [{ text: "Inicio", to: "/", icon: "home" }]
  })
};
</script>

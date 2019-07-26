<template>
  <v-container grid-list-xs>
    <v-toolbar app dark color="primary">
      <v-toolbar-side-icon @click="drawer = !drawer" class="hidden-md-and-up" />
      <v-toolbar-title class="hidden-sm-and-down">
        <span class="font-weight-black text-uppercase">
          {{ user.nombres }}
        </span>
        <span class="font-weight-light text-uppercase">
          {{ user.paterno }} {{ user.materno }}
        </span>
      </v-toolbar-title>
      <v-toolbar-title class="hidden-md-and-up">
        <span class="font-weight-black text-uppercase">
          UNPRG
        </span>
        <span class="font-weight-light text-uppercase">
          EGRESADOS
        </span>
      </v-toolbar-title>
      <v-spacer />
      <v-toolbar-items>
        <v-btn
          flat
          class="hidden-sm-and-down"
          v-for="link of links"
          :key="link.text"
          :to="link.to"
        >
          {{ link.text }}
        </v-btn>
      </v-toolbar-items>
      <v-menu offset-y>
        <template v-slot:activator="{ on }">
          <v-btn icon v-on="on">
            <v-avatar size="35">
              <img :src="urlFoto" alt="Perfil" />
            </v-avatar>
          </v-btn>
        </template>
        <v-list>
          <v-list-tile to="perfil">
            <v-list-tile-title>Perfil</v-list-tile-title>
          </v-list-tile>
          <v-list-tile to="seguridad">
            <v-list-tile-title>Cambiar contraseña</v-list-tile-title>
          </v-list-tile>
          <v-list-tile @click="cerrarSesion">
            <v-list-tile-title>Cerrar sesión</v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu>
    </v-toolbar>
    <v-navigation-drawer app v-model="drawer" hide-overlay temporary>
      <v-flex xs12>
        <v-img :src="urlFoto" gradient="to bottom, transparent 50%, black">
          <v-layout pa-3 column fill-height class="lightbox white--text">
            <v-spacer></v-spacer>
            <v-flex shrink class="title">
              <div class="font-weight-black text-uppercase">
                {{ user.nombres }}
              </div>
              <div class="font-weight-light text-uppercase">
                {{ user.paterno }} {{ user.materno }}
              </div>
            </v-flex>
          </v-layout>
        </v-img>
      </v-flex>
      <v-list>
        <v-list-tile
          v-for="(link, i) in links"
          :key="i"
          :to="link.to"
          class="google-font"
        >
          <v-list-group v-if="link.children">
            <v-list-tile>
              <v-list-tile-action>
                <v-icon>{{ link.icon }}</v-icon>
              </v-list-tile-action>

              <v-list-tile-content>
                <v-list-tile-title v-text="link.text" />
              </v-list-tile-content>
            </v-list-tile>
          </v-list-group>

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
import { mapState } from "vuex";
import { removeUser } from "../../bd/api";
import { urlImage } from "../../bd/config";
export default {
  data: () => ({
    drawer: false,
    links: [
      { text: "Inicio", to: "inicio", icon: "home" },
      { text: "Carreras", to: "carreras", icon: "school" },
      { text: "Postgrado", to: "postgrado", icon: "account_balance" },
      { text: "Experiencia", to: "experiencia", icon: "list_alt" },
      { text: "Curriculum", to: "curriculum", icon: "library_books" }
    ]
  }),
  computed: {
    ...mapState(["user"]),
    urlFoto() {
      return urlImage + this.user.urlFoto;
    }
  },
  methods: {
    cerrarSesion() {
      removeUser();
      this.$router.push("/login");
    }
  }
};
</script>

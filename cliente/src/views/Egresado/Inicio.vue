<template>
  <v-container grid-list-lg fill-height>
    <v-layout row wrap>
      <!-- Datos -->
      <v-flex xs12 md8 xl9>
        <v-card>
          <v-card-text>
            Datos estadísticos
          </v-card-text>
        </v-card>
      </v-flex>
      <!-- Noticias -->
      <v-flex xs12 md4 xl3>
        <v-layout row wrap>
          <v-flex xs12 v-for="(item, i) of lista" :key="i">
            <v-card>
              <v-card-text>
                <v-layout row justify-space-between>
                  <v-flex>
                    <v-avatar size="30">
                      <img :src="urlImage + item.urlFoto" alt="Perfil" />
                    </v-avatar>
                  </v-flex>
                  <v-flex class="font-weight-light">
                    <span class="font-weight-medium">
                      {{ item.nombres }}
                    </span>
                    <span v-if="item.tipo == 'C'">
                      ha egresado de
                    </span>
                    <span v-else-if="item.tipo == 'P'">
                      ha culminado sus estudios de
                    </span>
                    <span v-else-if="item.tipo == 'T'">
                      {{
                        item.fechaTermino == null
                          ? "empezó a trabajar de"
                          : "trabajó de"
                      }}
                    </span>
                    <span class="font-weight-regular">
                      {{ item.nombre }}
                    </span>
                    el
                    {{
                      new Date(
                        item.fecha.replace(/-/g, "\/")
                      ).toLocaleDateString("es-ES", {
                        month: "long",
                        day: "numeric"
                      })
                    }}.
                  </v-flex>
                </v-layout>
              </v-card-text>
              <v-spacer></v-spacer>
              <v-card-actions class="caption">
                <v-spacer></v-spacer>
                {{ item.lugar }}
                <v-icon small>location_on</v-icon>
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { get } from "../../bd/api";
import { urlImage } from "../../bd/config";
export default {
  data: () => ({
    urlImage,
    lista: []
  }),
  methods: {
    cargarLista() {
      get("personas-publico").then(res => (this.lista = res.data));
    },
    cargarTodo() {
      this.cargarLista();
    }
  },
  created() {
    this.cargarTodo();
  }
};
</script>


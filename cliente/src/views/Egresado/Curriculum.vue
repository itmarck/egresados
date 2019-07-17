<template>
  <v-container grid-list-lg>
    <v-layout row wrap>
      <!-- Postgrados -->
      <v-flex xs12 md6>
        <v-card>
          <v-list three-line subheader>
            <v-subheader>Postgrados</v-subheader>
            <v-list-tile
              v-for="postgrado of postgrados"
              :key="postgrado.codigo"
              @click="postgrado.select = !postgrado.select"
            >
              <v-list-tile-action>
                <v-checkbox
                  color="primary"
                  v-model="postgrado.select"
                ></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title v-html="postgrado.nombre" />
                <v-list-tile-sub-title>
                  <span v-if="postgrado.lugar == 'U'">
                    {{ postgrado.universidad }}
                  </span>
                  <span else>{{ postgrado.razonSocial }}</span>
                  {{
                    `(${postgrado.fechaInicio.substring(0, 4)} - 
                    ${postgrado.fechaTermino.substring(0, 4)})`
                  }}
                </v-list-tile-sub-title>
                <v-list-tile-sub-title v-html="postgrado.tipo" />
              </v-list-tile-content>
            </v-list-tile>
          </v-list>
        </v-card>
      </v-flex>
      <!-- Contratos -->
      <v-flex xs12 md6>
        <v-card>
          <v-list two-line subheader>
            <v-subheader>Experiencia</v-subheader>
            <v-list-tile
              v-for="contrato of contratos"
              :key="contrato.codigo"
              @click="contrato.select = !contrato.select"
            >
              <v-list-tile-action>
                <v-checkbox
                  color="primary"
                  v-model="contrato.select"
                ></v-checkbox>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title v-html="contrato.Centrolaboral" />
                <v-list-tile-sub-title>
                  {{ contrato.cargo }} —
                  {{ contrato.fechaInicio.toString().substring(0, 4) }}
                  ({{ contrato.tiempo }} {{ contrato.unidad }})
                </v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </v-list>
        </v-card>
      </v-flex>
      <v-layout>
        <v-flex d-flex>
          <v-btn color="primary">Generar Curriculum</v-btn>
        </v-flex>
      </v-layout>
    </v-layout>
  </v-container>
</template>

<script>
import { url } from "../../bd/config";
export default {
  data: () => ({
    contratos: [],
    postgrados: []
  }),
  computed: {
    contratosSeleccionados() {
      return this.contratos.filter(e => e.select);
    },
    postgradosSeleccionados() {
      return this.postgrados.filter(e => e.select);
    }
  },
  methods: {
    cargarContratos() {
      fetch(url + "contratos/73860228")
        .then(res => res.json())
        .then(res => (this.contratos = res.data));
    },
    cargarPostgrados() {
      fetch(url + "estudiosPostgrado/73860228")
        .then(res => res.json())
        .then(res => (this.postgrados = res.data));
    }
  },
  created() {
    this.cargarContratos();
    this.cargarPostgrados();
  }
};
</script>


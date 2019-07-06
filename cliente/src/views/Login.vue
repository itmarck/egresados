<template>
  <v-content>
      <v-container fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md6 lg4>
            <v-card class="elevation-12">
              <v-toolbar dark color="primary">
                <v-toolbar-title>Iniciar sesión</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form>
                  <v-text-field prepend-icon="person" label="Correo" type="text" />
                  <v-text-field prepend-icon="lock" label="Contraseña" id="password" type="password"/>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary">Acceder</v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
</template>

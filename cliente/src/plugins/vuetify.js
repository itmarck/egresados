import Vue from 'vue';
import Vuetify from 'vuetify/lib';
import 'vuetify/src/stylus/app.styl';

import es from 'vuetify/es5/locale/es';

Vue.use(Vuetify, {
  iconfont: 'md',
  theme: {
    primary: '#0D47A1',
    secondary: '#181818',
    accent: '#0D47A1',
    bright: '#F4BE1D',
    error: '#aa1515'
  },
  lang: {
    locales: { es },
    current: 'es'
  }
});

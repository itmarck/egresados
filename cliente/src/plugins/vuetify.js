import Vue from 'vue'
import Vuetify from 'vuetify/lib'
import 'vuetify/src/stylus/app.styl'

Vue.use(Vuetify, {
  iconfont: 'md',
  theme: {
    primary: '#0D47A1',
    secondary: '#181818',
    accent: '#181818',
    // accent: '#F4BE1D',
    error: '#aa1515'
  }
})

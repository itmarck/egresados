import Vue from 'vue';
import './plugins/vuetify';
import App from './App.vue';
import router from './router/index';
import store from './store/index';

Vue.config.productionTip = false;

function pad(number) {
  if (number < 10) {
    return '0' + number;
  }
  return number;
}

Date.prototype.toISOString = function() {
  return (
    this.getUTCFullYear() +
    '-' +
    pad(this.getUTCMonth()) +
    '-' +
    pad(this.getUTCDate())
  );
};

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');

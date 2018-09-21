import '@babel/polyfill'
import Vue from 'vue'
import './plugins/axios'
import './plugins/vuetify'
import './plugins/vee-validate'
import $ from 'jquery'
import App from './App'
import router from './router'
import store from './store'
import './registerServiceWorker'
import './assets/css/site.css'
import i18n from './i18n'
import swal from 'sweetalert'
import * as filters from '@/filters'
import permissionMixin from '@/mixins/permission'
import formatMixin from '@/mixins/format'
import FBSignInButton from 'vue-facebook-signin-button'
window.$ = require('jquery')
window.JQuery = require('jquery')
Vue.use(FBSignInButton)
// custom filters
Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key])
})

Vue.mixin(permissionMixin)
Vue.mixin(formatMixin)

Vue.config.productionTip = false

Vue.directive('number-only', {
  inserted: function (el, binding, vnode) {
    el.querySelector('input').onkeypress = (e) => {
      let keycode = event.which
      if (!(event.shiftKey === false && (keycode === 8 || keycode === 37 || keycode === 39 || (keycode >= 48 && keycode <= 57)))) {
        return false
      }
    }
  }
})

new Vue({
  router,
  store,
  i18n,
  render: h => h(App)
}).$mount('#app')

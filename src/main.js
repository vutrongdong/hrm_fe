import '@babel/polyfill'
import Vue from 'vue'
import './plugins/axios'
import './plugins/vuetify'
import './plugins/vee-validate'
import App from './App'
import router from './router'
import store from './store'
import './registerServiceWorker'
import './assets/css/site.css'
import i18n from './i18n'
import * as filters from '@/filters'
import permissionMixin from '@/mixins/permission'
import formatMixin from '@/mixins/format'

import DatetimePicker from 'vuetify-datetime-picker'
// import 'vuetify-datetime-picker/src/stylus/main.styl'
// You need a specific loader for CSS files
import 'vue-datetime/dist/vue-datetime.css'
import FBSignInButton from 'vue-facebook-signin-button'
// Vue.use(BootstrapVue)
Vue.use(DatetimePicker)
// Vue.use(Datetime)
Vue.component('tinymce', tinymce)
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

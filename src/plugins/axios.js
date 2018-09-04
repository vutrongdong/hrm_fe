import Vue from 'vue'
import axios from 'axios'
import ls from 'local-storage'

// let auth = ls('auth') || {}
// Full config:  https://github.com/axios/axios#request-config
// axios.defaults.baseURL = process.env.baseURL || process.env.apiUrl || ''
// if (auth.access_token) {
//   axios.defaults.headers.common['Authorization'] = `Bearer ${auth.access_token}`
// }
axios.defaults.headers.post['Content-Type'] = 'application/json'

let config = {
  baseURL: process.env.VUE_APP_API_URL || ''
  // timeout: 60 * 1000, // Timeout
  // withCredentials: true // Check cross-site Access-Control
}

const _axios = axios.create(config)

_axios.interceptors.request.use(
  function (config) {
    let auth = ls('auth') || {}
    if (auth.access_token) {
      config.headers['Authorization'] = `Bearer ${auth.access_token}`
    }
    return config
  },
  function (error) {
    // Do something with request error
    return Promise.reject(error)
  }
)

// Add a response interceptor
_axios.interceptors.response.use(
  function (response) {
    // Do something with response data
    return response
  },
  function (error) {
    // Do something with response error
    return Promise.reject(error)
  }
)

Plugin.install = function (Vue, options) {
  Vue.axios = _axios
  window.axios = _axios
  Object.defineProperties(Vue.prototype, {
    axios: {
      get () {
        return _axios
      }
    },
    $axios: {
      get () {
        return _axios
      }
    }
  })
}

Vue.use(Plugin)

export default _axios

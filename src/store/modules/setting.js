import {
  SET_SETTINGS,
  SET_INITIAL_STATE
} from '../mutation-types'

const initState = () => {
  return {
    settings: {}
  }
}

/**
 * state
 */
const state = {
  settings: initState().settings
}

/**
 * actions
 */
const actions = {
  getSetting ({ commit, dispatch }, payload) {
    let { params } = payload || {}
    dispatch(
      'fetchApi',
      {
        url: 'settings',
        method: 'GET',
        params: params || {},
        success: (response) => {
          commit(SET_SETTINGS, response.data)
        }
      },
      { root: true }
    )
  },
  setSetting ({ commit }, payload) {
    let { settings } = payload || {}
    if (settings) {
      commit(SET_SETTINGS, settings)
    }
  },
  updateSetting ({ commit, dispatch }, payload) {
    let { setting, cb } = payload || {}
    dispatch('fetchApi', {
      url: '/settings',
      method: 'PUT',
      data: setting,
      success: cb
    }, { root: true })
  }
}

/**
 * mutations
 */
const mutations = {
  [SET_SETTINGS]: (state, settings) => {
    state.settings = settings
  },
  [SET_INITIAL_STATE]: (state) => {
    state.settings = initState().settings
  }
}

/**
 * getters
 */
const getters = {
  settings: (state) => state.settings
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

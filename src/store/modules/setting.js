import {
  SET_SETTINGS,
  SET_INITIAL_STATE,
  REMOVE_SETTING
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
  FetchSetting ({ commit, dispatch }, payload) {
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
  getSetting ({ commit, dispatch }, payload) {
    let { settingId, params } = payload || {}
    dispatch(
      'fetchApi',
      {
        url: `settings/${settingId}`,
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
  createSetting ({ commit, dispatch }, payload) {
    let { setting, cb, params } = payload
    dispatch('fetchApi', {
      url: 'settings',
      method: 'POST',
      data: setting,
      params: params,
      success: cb
    }, { root: true })
  },
  updateSetting ({ commit, dispatch }, payload) {
    let { id, setting, cb, params } = payload
    dispatch('fetchApi', {
      url: `settings/${id}`,
      method: 'PUT',
      data: setting,
      params: params,
      success: cb
    }, { root: true })
  },
  updateStatusSetting ({ commit, dispatch }, payload) {
    let { id, cb } = payload
    dispatch('fetchApi', {
      url: `settings/change-status/${id}`,
      method: 'PUT',
      success: cb
    }, { root: true })
  },
  async deleteSetting ({ commit, dispatch }, payload) {
    const { id, cb } = payload || {}
    dispatch('fetchApi', {
      url: `settings/${id}`,
      method: 'DELETE',
      success: response => {
        commit(REMOVE_SETTING, id)
        cb && cb(response.data)
      }
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
  },
  [REMOVE_SETTING]: (state, id) => {
    console.log(id)
    delete state.settings[id]
    console.log(state.settings[id])
  }
}

/**
 * getters
 */
const getters = {
  settingDetail: (state) => state.settings
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

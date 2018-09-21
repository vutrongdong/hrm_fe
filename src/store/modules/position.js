import {
  SET_POSITION
} from '../mutation-types'

const initState = () => {
  return {
    position: {}
  }
}

/**
 * state
 */
const state = {
  position: initState().position
}

/**
 * actions
 */
const actions = {
  setPosition ({ commit }, payload) {
    let { position } = payload || {}
    commit(SET_POSITION, position)
  },
  positionForUser ({ commit, dispatch }, payload) {
    let { params, error } = payload || {}
    dispatch(
      'fetchApi',
      {
        url: `positions`,
        method: 'GET',
        params: params || {},
        success: (response) => {
          commit(SET_POSITION, response.data)
        },
        error: error
      },
      { root: true }
    )
  }
}

/**
 * mutations
 */
const mutations = {
  [SET_POSITION]: (state, position) => {
    state.position = position
  }
}

/**
 * getters
 */
const getters = {
  positionAll: (state) => state.position
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

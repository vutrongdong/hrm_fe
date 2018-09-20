import {
  SET_POSITION,
  SET_INITIAL_STATE
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
  getPosition ({ commit, dispatch }, payload) {
    let { positionId, params, error } = payload || {}
    dispatch(
      'fetchApi',
      {
        url: `positions/${positionId}`,
        method: 'GET',
        params: params || {},
        success: (response) => {
          commit(SET_POSITION, response.data)
        },
        error: error
      },
      { root: true }
    )
  },
  createPosition ({ commit, dispatch }, payload) {
    let { position, cb } = payload || {}
    dispatch('fetchApi', {
      url: 'positions',
      method: 'POST',
      data: position,
      success: cb
    }, { root: true })
  },
  updatePosition ({ commit, dispatch }, payload) {
    let { id, position, cb, error } = payload || {}
    dispatch('fetchApi', {
      url: `positions/${id}`,
      method: 'PUT',
      data: position,
      success: cb,
      error: error
    }, { root: true })
  },
  deletePosition ({ commit, dispatch }, payload) {
    let { id, cb, error } = payload || {}
    dispatch('fetchApi', {
      url: `positions/${id}`,
      method: 'DELETE',
      success: cb,
      error: error
    }, { root: true })
  },
PositionForUser ({ commit, dispatch }, payload) {
    let { positionId, params, error } = payload || {}
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
  // [SET_INITIAL_STATE]: (state) => {
  //   state.role = initState().role
  // }
}

/**
 * getters
 */
const getters = {
  positionDetail: (state) => state.position,
  positionAll: (state) => state.position

}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

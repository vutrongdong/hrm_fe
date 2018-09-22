import {
<<<<<<< HEAD
  SET_POSITION
=======
  SET_POSITION,
  SET_INITIAL_STATE
>>>>>>> origin/dev
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
<<<<<<< HEAD
  positionForUser ({ commit, dispatch }, payload) {
    let { params, error } = payload || {}
=======
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
>>>>>>> origin/dev
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
<<<<<<< HEAD
=======
  // [SET_INITIAL_STATE]: (state) => {
  //   state.role = initState().role
  // }
>>>>>>> origin/dev
}

/**
 * getters
 */
const getters = {
<<<<<<< HEAD
  positionAll: (state) => state.position
=======
  positionDetail: (state) => state.position,
  positionAll: (state) => state.position

>>>>>>> origin/dev
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

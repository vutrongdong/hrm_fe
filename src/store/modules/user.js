import {
  SET_USER,
  SET_INITIAL_STATE
} from '../mutation-types'

const initState = () => {
  return {
    user: {}
  }
}

/**
 * state
 */
const state = {
  user: initState().user
}

/**
 * actions
 */
const actions = {
  setUser ({ commit }, payload) {
    let { user } = payload
    commit(SET_USER, user)
  },
  getUser ({ commit, dispatch }, payload) {
    let { userId, params } = payload
    dispatch(
      'fetchApi',
      {
        url: `users/${userId}`,
        method: 'GET',
        params: params || {},
        success: (response) => {
          commit(SET_USER, response.data)
        }
      },
      { root: true }
    )
  },
  createUser ({ commit, dispatch }, payload) {
    let { user, cb, params } = payload
    dispatch('fetchApi', {
      url: 'users',
      method: 'POST',
      data: user,
      params: params,
      success: cb
    }, { root: true })
  },
  updateUser ({ commit, dispatch }, payload) {
    let { id, user, cb, params } = payload
    dispatch('fetchApi', {
      url: `users/${id}`,
      method: 'PUT',
      data: user,
      params: params,
      success: cb
    }, { root: true })
  },
  deleteUser ({ commit, dispatch }, payload) {
    let { id, cb, error } = payload || {}
    dispatch('fetchApi', {
      url: `users/${id}`,
      method: 'DELETE',
      success: cb,
      error: error
    }, { root: true })
  }
}

/**
 * mutations
 */
const mutations = {
  [SET_USER]: (state, user) => {
    state.user = user
  },
  [SET_INITIAL_STATE]: (state) => {
    state.user = initState().user
  }
}

/**
 * getters
 */
const getters = {
  userDetail: (state) => state.user
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

import {
  SET_BRANCH,
  SET_INITIAL_STATE
} from '../mutation-types'

const initState = () => {
  return {
    branch: {}
  }
}
/**
 * [state description]
 * @type {Object}
 */
const state = {
  branch: initState().branch
}
/**
 * [actions description]
 * @type {Object}
 */
const actions = {
  setBranch ({ commit }, payload) {
    let { branch } = payload
    commit(SET_BRANCH, branch)
  },
  getBranch ({ commit, dispatch }, payload) {
    let { branchId, params } = payload
    console.log(branchId)
    dispatch(
      'fetchApi',
      {
        url: `branches/${branchId}`,
        method: 'GET',
        params: params || {},
        success: (response) => {
          commit(SET_BRANCH, response.data)
        }
      },
      { root: true }
    )
  },
  createBranch ({ commit, dispatch }, payload) {
    let { branch, cb, params } = payload
    dispatch('fetchApi', {
      url: 'branches',
      method: 'POST',
      data: branch,
      params: params,
      success: cb
    }, { root: true })
  },
  updateBranch ({ commit, dispatch }, payload) {
    let { id, branch, cb, params } = payload
    dispatch('fetchApi', {
      url: `branches/${id}`,
      method: 'PUT',
      data: branch,
      params: params,
      success: cb
    }, { root: true })
  },
  deleteBranch ({ commit, dispatch }, payload) {
    let { id, cb, error } = payload || {}
    dispatch('fetchApi', {
      url: `branches/${id}`,
      method: 'DELETE',
      success: cb,
      error: error
    }, { root: true })
  }
}
/**
 * [mutations description]
 * @type {Object}
 */
const mutations = {
  [SET_BRANCH]: (state, branch) => {
    state.branch = branch
  },
  [SET_INITIAL_STATE]: (state) => {
    state.branch = initState().branch
  }
}
/**
 * [getters description]
 * @type {Object}
 */
const getters = {
  branchDetail: (state) => state.branch
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

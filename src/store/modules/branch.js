import {
  SET_INITIAL_STATE,
  SET_BRANCHS,
  SET_BRANCH
} from '../mutation-types'

const initState = () => {
  return {
    branchs: {},
    branch: {}
  }
}

const state = {
  branchs: initState().branchs,
  branch: initState().branch
}
const actions = {
  setBranch ({ commit }, payload) {
    let { branchs } = payload
    commit(SET_BRANCHS, branchs)
  },
  getBranchs ({ commit, dispatch }, payload) {
    dispatch(
      'fetchApi',
      {
        url: `branches`,
        method: 'GET',
        success: (response) => {
          commit(SET_BRANCHS, response.data)
        }
      },
      { root: true }
    )
  },
  getBranch ({ commit, dispatch }, payload) {
    let { branchId, params } = payload
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
  getBranchForUser ({ commit, dispatch }, payload) {
    dispatch(
      'fetchApi',
      {
        url: `branches`,
        method: 'GET',
        success: (response) => {
          commit(SET_BRANCHS, response.data)
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
const mutations = {
  [SET_BRANCHS]: (state, branchs) => {
    state.branchs = branchs
  },
  [SET_BRANCH]: (state, branch) => {
    state.branch = branch
  },
  [SET_INITIAL_STATE]: (state) => {
    state.branchs = initState().branchs
    state.branch = initState().branch
  }

}

const getters = {
  branchAll: (state) => state.branchs,
  branchDetail: (state) => state.branch
}
export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

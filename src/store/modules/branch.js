import {
  SET_INITIAL_STATE,
  SET_BRANCH
} from '../mutation-types'

const initState = () => {
  return {
    branch: {}
  }
}

const state = {
  city: initState().city,
  districts: initState().districts,
  branch: initState().branch
}
const actions = {
  setBranch ({ commit }, payload) {
    let { branch } = payload
    commit(SET_BRANCH, branch)
  },
  getBranch ({ commit, dispatch }, payload) {
    dispatch(
      'fetchApi',
      {
        url: `branches`,
        method: 'GET',
        success: (response) => {
          commit(SET_BRANCH, response.data)
        }
      },
      { root: true }
    )
  },
  getBranchs ({ commit, dispatch }, payload) {
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
  getBranchForUser ({ commit, dispatch }, payload) {
    dispatch(
      'fetchApi',
      {
        url: `branches`,
        method: 'GET',
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
const mutations = {
  [SET_BRANCH]: (state, branch) => {
    state.branch = branch
  },
  [SET_INITIAL_STATE]: (state) => {
    state.branch = initState().branch
  }

}

const getters = {
  branchAll: (state) => state.branch,
  branchDetail: (state) => state.branch
}
export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

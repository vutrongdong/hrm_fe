import {
  SET_DEPARTMENT
} from '../mutation-types'
const initState = () => {
  return {
    department: {}
  }
}

/**
 * state
 */

const state = {
  department: initState().department
}

/**
 * actions
 */

const actions = {
  setDepartment ({ commit }, payload) {
    let { department } = payload || {}
    commit(SET_DEPARTMENT, department)
  },
  getDepartment ({ commit, dispatch }, payload) {
    let { departmentId, params, error } = payload || {}
    dispatch(
      'fetchApi',
      {
        url: `departments/${departmentId}`,
        method: 'GET',
        params: params || {},
        success: (response) => {
          commit(SET_DEPARTMENT, response.data)
        },
        error: error
      },
      { root: true }
    )
  },
  fetchDepartment ({ commit, dispatch }, payload) {
    let { params, error } = payload || {}
    dispatch(
      'fetchApi',
      {
        url: `departments`,
        method: 'GET',
        params: params || {},
        success: (response) => {
          commit(SET_DEPARTMENT, response.data)
        },
        error: error
      },
      { root: true }
    )
  },
  getDepartmentForUser ({ commit, dispatch }, payload) {
    let { branchId, cb } = payload
    dispatch(
      'fetchApi',
      {
        url: `departments/branches/${branchId}`,
        method: 'GET',
        success: (response) => {
          commit(SET_DEPARTMENT, response.data)
          cb && cb()
        }
      },
      { root: true }
    )
  },

  createDepartment ({ commit, dispatch }, payload) {
    let { department, cb, params } = payload
    dispatch('fetchApi', {
      url: 'departments',
      method: 'POST',
      data: department,
      params: params,
      success: cb
    }, { root: true })
  },
  updateDepartment ({ commit, dispatch }, payload) {
    let { id, department, cb, params } = payload
    dispatch('fetchApi', {
      url: `departments/${id}`,
      method: 'PUT',
      data: department,
      params: params,
      success: cb
    }, { root: true })
  },
  updateStatusDepartment ({ commit, dispatch }, payload) {
    let { id } = payload
    dispatch('fetchApi', {
      url: `departments/change-status/${id}`,
      method: 'PUT'
    }, { root: true })
  },
  deleteDepartment ({ commit, dispatch }, payload) {
    let { id, cb, error } = payload || {}
    dispatch('fetchApi', {
      url: `departments/${id}`,
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
  [SET_DEPARTMENT]: (state, department) => {
    state.department = department
  }
}

/**
 * getters
 */
const getters = {
  // departmentByBranch: (state) => state.department,
  departmentDetail: (state) => state.department
  // departmentAll: (state) => state.department
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

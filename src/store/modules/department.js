import {
<<<<<<< HEAD
  SET_DEPARTMENT
=======
  SET_DEPARTMENT,
  SET_BRANCH,
  SET_INITIAL_STATE
>>>>>>> origin/dev
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
<<<<<<< HEAD
=======
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
>>>>>>> origin/dev
  getDepartmentForUser ({ commit, dispatch }, payload) {
    let { branch_id, cb } = payload
    dispatch(
      'fetchApi',
      {
        url: `departments/branches/${branch_id}`,
        method: 'GET',
        success: (response) => {
<<<<<<< HEAD
          commit(SET_DEPARTMENT, response.data)
=======
          commit(SET_DEPARTMENT, response)
>>>>>>> origin/dev
          cb && cb()
        }
      },
      { root: true }
    )
<<<<<<< HEAD
=======
  },
  departmentForPlan ({ commit, dispatch }, payload) {
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
  deleteDepartment ({ commit, dispatch }, payload) {
    let { id, cb, error } = payload || {}
    dispatch('fetchApi', {
      url: `departments/${id}`,
      method: 'DELETE',
      success: cb,
      error: error
    }, { root: true })
>>>>>>> origin/dev
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
<<<<<<< HEAD
  departmentByBranch: (state) => state.department
=======
  departmentDetail: (state) => state.department,
  departmentByBranch: (state) => state.department,
  departmentAll: (state) => state.department
>>>>>>> origin/dev
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

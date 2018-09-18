import {
  SET_DEPARTMENT,
  SET_BRANCH,
  SET_INITIAL_STATE
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
  DepartmentForUser ({ commit, dispatch }, payload) {
    let { departmentId, params, error } = payload || {}
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
  departmentAll: (state) => state.department }

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

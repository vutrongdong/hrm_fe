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
  getDepartmentForUser ({ commit, dispatch }, payload) {
    let { branch_id, cb } = payload
    dispatch(
     'fetchApi',
     {
      url: `departments/branches/${branch_id}`,
      method: 'GET',
      success: (response) => {
        commit(SET_DEPARTMENT, response.data)
        cb && cb()
      }
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
  DepartmentByBranch:(state) => state.department
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

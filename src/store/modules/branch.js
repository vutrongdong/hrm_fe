
// import {
//   SET_INITIAL_STATE,
//   SET_BRANCH
// } from '../mutation-types'

// const initState = () => {
//   return {
//     branch: {}
//   }
// }

// const state = {
//   city: initState().city,
//   districts: initState().districts,
//   branch: initState().branch
// }
// const actions = {
//   setBranch ({ commit }, payload) {
//     let { branch } = payload
//     commit(SET_BRANCH, branch)
//   },
//   getBranch ({ commit, dispatch }, payload) {
//     dispatch(
//       'fetchApi',
//       {
//         url: `branches`,
//         method: 'GET',
//         success: (response) => {
//           commit(SET_BRANCH, response.data)
//         }
//       },
//       { root: true }
//     )
//   },
//   getBranchs ({ commit, dispatch }, payload) {
//     let { branchId, params } = payload
//     console.log(branchId)
//     dispatch(
//       'fetchApi',
//       {
//         url: `branches/${branchId}`,
//         method: 'GET',
//         params: params || {},
//         success: (response) => {
//           commit(SET_BRANCH, response.data)
//         }
//       },
//       { root: true }
//     )
//   },
//   createBranch ({ commit, dispatch }, payload) {
//     let { branch, cb, params } = payload
//     dispatch('fetchApi', {
//       url: 'branches',
//       method: 'POST',
//       data: branch,
//       params: params,
//       success: cb
//     }, { root: true })
//   },
//   updateBranch ({ commit, dispatch }, payload) {
//     let { id, branch, cb, params } = payload
//     dispatch('fetchApi', {
//       url: `branches/${id}`,
//       method: 'PUT',
//       data: branch,
//       params: params,
//       success: cb
//     }, { root: true })
//   },
//   deleteBranch ({ commit, dispatch }, payload) {
//     let { id, cb, error } = payload || {}
//     dispatch('fetchApi', {
//       url: `branches/${id}`,
//       method: 'DELETE',
//       success: cb,
//       error: error
//     }, { root: true })
//   }
// }
// const mutations = {
//   [SET_BRANCH]: (state, branch) => {
//     state.branch = branch
//   },
//   [SET_INITIAL_STATE]: (state) => {
//     state.branch = initState().branch
//   }

// }

// const getters = {
//   branchAll: (state) => state.branch,
//   branchDetail: (state) => state.branch

// }
// export default {
//   namespaced: true,
//   state,
//   actions,
//   mutations,
//   getters
// }
import {
  SET_BRANCH,
  SET_INITIAL_STATE,
  SET_DEPARTMENT
} from '../mutation-types'

const initState = () => {
  return {
    branch: {},
    department:{},
  }
}
/**
 * [state description]
 * @type {Object}
 */
 const state = {
  branch: initState().branch,
  department: initState().department
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

  getDepartmentForUser ({ commit, dispatch }, payload) {
    let { branch_id, cb } = payload
    dispatch(
       'fetchApi',
      {
        url: `branches/${branch_id}?include=departments`,
        method: 'GET',
        success: (response) => {
          commit(SET_DEPARTMENT, response.data)
          cb && cb()
        }
      },
      { root: true }
      )
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
  },
  [SET_DEPARTMENT]: (state, department) => {
    state.department = department
  }

}
/**
 * [getters description]
 * @type {Object}
 */
 const getters = {
  branchAll:(state)=>state.branch,
  branchDetail: (state) => state.branch,
  DepartmentByBranch:(state)=>state.department
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

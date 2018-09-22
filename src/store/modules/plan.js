import {
  SET_PLAN
} from '../mutation-types'

const initState = () => {
  return {
    plan: {}
  }
}

/**
 * state
 */
const state = {
  plan: initState().plan
}

/**
 * actions
 */
const actions = {
  setPlan ({ commit }, payload) {
    let { plan } = payload || {}
    commit(SET_PLAN, plan)
  },
  getPlan ({ commit, dispatch }, payload) {
    let { planId, params, error } = payload || {}
    dispatch(
      'fetchApi',
      {
        url: `plans/${planId}`,
        method: 'GET',
        params: params || {},
        success: (response) => {
          commit(SET_PLAN, response.data)
        },
        error: error
      },
      { root: true }
    )
  },
  createPlan ({ commit, dispatch }, payload) {
    let { plan, cb } = payload || {}
    dispatch('fetchApi', {
      url: 'plans',
      method: 'POST',
      data: plan,
      success: cb
    }, { root: true })
  },
  updatePlan ({ commit, dispatch }, payload) {
    let { id, plan, cb, error } = payload || {}
    dispatch('fetchApi', {
      url: `plans/${id}`,
      method: 'PUT',
      data: plan,
      success: cb,
      error: error
    }, { root: true })
  },
  deletePlan ({ commit, dispatch }, payload) {
    let { id, cb, error } = payload || {}
    dispatch('fetchApi', {
      url: `plans/${id}`,
      method: 'DELETE',
      success: cb,
      error: error
    }, { root: true })
  },
  planForCadidate ({ commit, dispatch }, payload) {
    let { params, error } = payload || {}
    dispatch(
      'fetchApi',
      {
        url: `plans`,
        method: 'GET',
        params: params || {},
        success: (response) => {
          commit(SET_PLAN, response.data)
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
  [SET_PLAN]: (state, plan) => {
    state.plan = plan
  }
  // [SET_INITIAL_STATE]: (state) => {
  //   state.role = initState().role
  // }
}

/**
 * getters
 */
const getters = {
  planDetail: (state) => state.plan,
  planAll: (state) => state.plan
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

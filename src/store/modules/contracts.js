import {
  SET_CONTRACTS
} from '../mutation-types'

const initState = () => {
  return {
    contract: {}
  }
}

/**
 * state
 */
const state = {
  contract: initState().contract
}

/**
 * actions
 */
const actions = {
  setContract ({ commit }, payload) {
    let { contract } = payload || {}
    commit(SET_CONTRACTS, contract)
  },
  fetchContract ({ commit, dispatch }, payload) {
    let { params, error } = payload || {}
    dispatch(
      'fetchApi',
      {
        url: `contracts`,
        method: 'GET',
        params: params || {},
        success: (response) => {
          commit(SET_CONTRACTS, response.data)
        },
        error: error
      },
      { root: true }
    )
  },
  getContract ({ commit, dispatch }, payload) {
    let { contractId, params, error } = payload || {}
    dispatch(
      'fetchApi',
      {
        url: `contracts/${contractId}`,
        method: 'GET',
        params: params || {},
        success: (response) => {
          commit(SET_CONTRACTS, response.data)
        },
        error: error
      },
      { root: true }
    )
  },
   createContract ({ commit, dispatch }, payload) {
    let { contract, cb } = payload || {}
    dispatch('fetchApi', {
      url: 'contracts',
      method: 'POST',
      data: contract,
      success: cb
    }, { root: true })
  },
  updateContract ({ commit, dispatch }, payload) {
    let { id, contract, cb, error } = payload || {}
    dispatch('fetchApi', {
      url: `contracts/${id}`,
      method: 'PUT',
      data: contract,
      success: cb,
      error: error
    }, { root: true })
  },
  deleteContract ({ commit, dispatch }, payload) {
    let { id, cb, error } = payload || {}
    dispatch('fetchApi', {
      url: `contracts/${id}`,
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
  [SET_CONTRACTS]: (state, contract) => {
    state.contract = contract
  }
}

const getters = {
  contractDetail: (state) => state.contract
}

export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

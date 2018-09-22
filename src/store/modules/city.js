<<<<<<< HEAD
import {
  SET_CITIES,
  SET_DISTRICTS,
  SET_INITIAL_STATE
=======

import {
  SET_CITIES,
  SET_DISTRICTS,
  SET_INITIAL_STATE,
  SET_BRANCH
>>>>>>> origin/dev
} from '../mutation-types'

const initState = () => {
  return {
    city: {},
<<<<<<< HEAD
    districts: {}
=======
    districts: {},
    branches: {}
>>>>>>> origin/dev
  }
}

const state = {
  city: initState().city,
<<<<<<< HEAD
  districts: initState().districts
=======
  districts: initState().districts,
  branches: initState().branches
>>>>>>> origin/dev
}

const actions = {
  setCity ({ commit }, payload) {
    let { city } = payload
    commit(SET_CITIES, city)
  },
  getCity ({ commit, dispatch }, payload) {
    dispatch(
      'fetchApi',
      {
        url: `cities`,
        method: 'GET',
        success: (response) => {
          commit(SET_CITIES, response.data)
        }
      },
      { root: true }
    )
  },
<<<<<<< HEAD
  getDistrictByCity ({ commit, dispatch }, payload) {
    let { city_id } = payload
    // console.log(city_id)
=======

  getDistrictByCity ({ commit, dispatch }, payload) {
    let { city_id } = payload
>>>>>>> origin/dev
    dispatch(
      'fetchApi',
      {
        url: `cities/${city_id}?include=districts`,
        method: 'GET',
        success: (response) => {
          commit(SET_DISTRICTS, response.data)
        }
      },
      { root: true }
    )
  }
<<<<<<< HEAD
=======

>>>>>>> origin/dev
}
const mutations = {
  [SET_CITIES]: (state, city) => {
    state.city = city
  },
  [SET_INITIAL_STATE]: (state) => {
    state.city = initState().city
  },
  [SET_DISTRICTS]: (state, districts) => {
    state.districts = districts
  }
}

const getters = {
  cityAll: (state) => state.city,
  districtByCity: (state) => state.districts
<<<<<<< HEAD
=======

>>>>>>> origin/dev
}
export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

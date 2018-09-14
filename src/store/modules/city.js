import {
  SET_CITIES,
  SET_DISTRICTS,
  SET_INITIAL_STATE,
} from '../mutation-types'

const initState = () => {
  return {
    city: {},
    districts:{}
  }
}

const state = {
  city: initState().city,
  districts: initState().districts
}

const actions ={
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
  getDistrictByCity({commit,dispatch},payload){
    dispatch('fetchApi',
    {
        url: `cities/${cityId}?include=districts`,
        method: 'GET',
        success: (response) =>{
           commit(SET_DISTRICTS,response.data)
        }
    },
    {root:true}
    )
  }
}

const mutations = {
  [SET_CITIES]: (state, city) => {
    state.city = city
  },
  [SET_INITIAL_STATE]: (state) => {
    state.city = initState().city
  },
  [SET_DISTRICTS]: (state,districts)=>{
    state.districts = districts
  }
}

const getters = {
  cityAll: (state) => state.city,
  districtByCity:(state)=>state.districts
}
export default {
  namespaced: true,
  state,
  actions,
  mutations,
  getters
}

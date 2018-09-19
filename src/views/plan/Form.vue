<template>
    <v-form @submit.prevent="validateBeforeSubmit">
    <v-text-field
      :error-messages="errors.has('title') ? errors.collect('title') : []"
      v-validate="'required|min:3'"
      :data-vv-as="$t('label.title')"
      name="title"
      :label="$t('label.title') + ' *'"
      v-model="plan.title">
    </v-text-field>
    <v-text-field
      :error-messages="errors.has('content') ? errors.collect('content') : []"
      v-validate="'required|min:3'"
      :data-vv-as="$t('label.content')"
      name="content"
      :label="$t('label.content') + ' *'"
      v-model="plan.content">
    </v-text-field>
    <v-flex xs12 text-xs-center>
      <v-btn
      :loading="isFetchingApi"
      :disabled="isFetchingApi"
      color="primary"
      type="submit">
        <template v-if="isCreate">
          <v-icon left>add</v-icon> {{$t('control.create')}}
        </template>
        <template v-else>
          <v-icon left>save</v-icon> {{$t('control.save')}}
        </template>
        </v-btn>
    </v-flex>
    </v-form>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import { map, chain } from 'lodash'
export default{
  name: 'PlanForm',
  computed:{
    ...mapGetters(['isFetchingApi']),
    isCreate () {
      return this.type === 'create'
    }
  },
  props:{
    type:{
      type: String,
      default: 'create'
    },
     dataPlan: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  data(){
    return{
      plan:{
         title:'',
         content:''
      }
    }
  },
  methods:{
    ...mapActions(['fetchApi']),
    setInitData(){
        let dataPlan = { ...this.dataPlan}
        this.plan = { ...this.plan, ...dataPlan }
    },
    validateBeforeSubmit(){
        this.$validator.validateAll().then(result =>{
            if(result){
              let submitData = { ...this.plan}
              this.$emit('submit', submitData)
            }else{
          this.$store.dispatch('showNotify', {
            text: this.$t('alert.invalid'),
            color: 'warning'
          })
            }
        })
    }
  },
  created () {
    !!this.dataPlan && this.setInitData()
  }
}
</script>

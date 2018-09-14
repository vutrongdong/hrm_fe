    `<template>
      <v-form @submit.prevent="validateBeforeSubmit">
        <v-container fluid>
          <v-layout row wrap>
            <v-flex xs6>
              <v-text-field :error-messages="errors.has('name') ? errors.collect('name') : []" v-validate="'required|min:3'":data-vv-as="$t('label.name')"name="name":label="$t('label.name') + '*'"v-model="branch.name">
              </v-text-field>

              <v-text-field :error-messages="errors.has('phone') ? errors.collect('phone') : []":data-vv-as="$t('label.phone')"name="phone":label="$t('label.phone')"v-model="branch.phone">
              </v-text-field>

              <!-- {{ cityAll }} -->
              <v-text-field :error-messages="errors.has('website') ? errors.collect('website') : []":data-vv-as="$t('label.website')"name="website":label="$t('label.website')"v-model="branch.website">
              </v-text-field>

              <v-text-field :error-messages="errors.has('email') ? errors.collect('email') : []":data-vv-as="$t('label.email')"name="email":label="$t('label.email')"v-model="branch.email">
              </v-text-field>

              <v-text-field :error-messages="errors.has('facebook') ? errors.collect('facebook') : []"v-validate="'required|min:3'":data-vv-as="$t('label.facebook')"name="name":label="$t('label.facebook') "v-model="branch.facebook">
              </v-text-field>
              <v-text-field :error-messages="errors.has('instagram') ? errors.collect('instagram') : []":data-vv-as="$t('label.instagram')"name="instagram":label="$t('label.instagram')"v-model="branch.instagram">
              </v-text-field>


              <v-text-field :error-messages="errors.has('zalo') ? errors.collect('zalo') : []":data-vv-as="$t('label.zalo')"name="zalo":label="$t('label.zalo')"v-model="branch.zalo">
              </v-text-field>

              <v-text-field :error-messages="errors.has('status') ? errors.collect('status') : []":data-vv-as="$t('label.status')"name="status":label="$t('label.status')"v-model="branch.status">
              </v-text-field>
            </v-flex>
            <v-flex xs6>

              <v-text-field :error-messages="errors.has('description') ? errors.collect('description') : []":data-vv-as="$t('label.description')"name="description":label="$t('label.description')"v-model="branch.description">
              </v-text-field>
              <v-text-field :error-messages="errors.has('about') ? errors.collect('about') : []":data-vv-as="$t('label.about')"name="about":label="$t('label.about')"v-model="branch.about">
              </v-text-field>

              <v-text-field :error-messages="errors.has('address') ? errors.collect('address') : []":data-vv-as="$t('label.address')"name="address":label="$t('label.address')"v-model="branch.address">
              </v-text-field>

              <v-text-field :error-messages="errors.has('tax_number') ? errors.collect('tax_number') : []":data-vv-as="$t('label.tax_number')"name="tax_number":label="$t('label.tax_number')"v-model="branch.tax_number">
              </v-text-field>

              <v-text-field :error-messages="errors.has('bank') ? errors.collect('bank') : []":data-vv-as="$t('label.bank')"name="bank":label="$t('label.bank')"v-model="branch.bank">
              </v-text-field>


               <!--  <v-text-field :error-messages="errors.has('city_id') ? errors.collect('city_id') : []":data-vv-as="$t('label.city_id')"name="city_id":label="$t('label.city_id')"v-model="branch.city_id">
               </v-text-field> -->
               <!-- {{ cityAll[0].districts.data[0] }} -->
               <v-select v-validate="'required'" :error-messages="errors.has('city_id') ? errors.collect('city_id') : []" :data-vv-as="$t('label.city_id')" name="city_id" :label="$t('label.city_id')" v-model="branch.city_id"  :items="cityAll" item-value="id" item-text="name">
               </v-select>
             <!--   <v-select :error-messages="errors.has('district_id') ? errors.collect('district_id') : []":data-vv-as="$t('label.district_id')" name="district_id":label="$t('label.district_id')"v-model="branch.district_id"  :items="districtAll" item-value="id" item-text="name" @change='changeCity'>
               </v-select> -->
           <!--   <v-text-field :error-messages="errors.has('district_id') ? errors.collect('district_id') : []":data-vv-as="$t('label.district_id')"name="district_id":label="$t('label.district_id')"v-model="branch.district_id">
           </v-text-field> -->
           <br>
           <v-radio-group  row :error-messages="errors.has('type') ? errors.collect('type') : []":data-vv-as="$t('label.type')"name="type" v-model="branch.type">
            <v-radio label="Chi Nhánh Chính" value="1"></v-radio>
            <v-radio label="Chi Nhánh Phụ" value="0"></v-radio>
          </v-radio-group>

        </v-flex>
        <v-flex xs12 text-xs-center>
          <v-btn
          :loading="isFetchingApi"
          :disabled="isFetchingApi"
          color="primary"
          type="submit"
          >
          <template v-if="isCreate">
            <v-icon left>add</v-icon> {{$t('control.create')}}
          </template>
          <template v-else>
            <v-icon left>save</v-icon> {{$t('control.save')}}
          </template>
        </v-btn>
      </v-flex>
    </v-layout>
  </v-container>
</v-form>
</template>
<script>
  // import DataView from '@/components/DataView/DataView'
  import { mapGetters, mapActions } from 'vuex'
  import { map } from 'lodash'
  export default{
    name: 'BranchForm',
    components: {
      DataView
    },
    computed: {
      ...mapGetters(['isFetchingApi']),
      ...mapGetters('City',['cityAll']),
      ...mapGetters('District',['districtAll']),
      isCreate () {
        return this.type === 'create'
      }
    },
    props: {
      type: {
        type: String,
        default: 'create'
      },
      dataBranch: {
        type: Object,
        default: () => {
          return {}
        }
      }
    },
    data () {
      return {
        branch: {
          name: '',
          description: '',
          about: '',
          phone: '',
          address: '',
          website: '',
          email: '',
          facebook: '',
          instagram: '',
          zalo: '',
          tax_number: '',
          bank: '',
          type: '',
          city_id: '',
          district_id: '',
          type: ''
        }
      }
    },
    methods: {
      ...mapActions(['fetchApi']),
      ...mapActions('City',['getCity']),
      ...mapActions('District',['getDistrictByCity']),
      setInitData () {
        let dataBranch = { ...this.dataBranch }
        this.branch = { ...this.branch, ...dataBranch }
      },
      changeCity(){
        this.getDistrictByCity({

        })
      },
      validateBeforeSubmit () {
        this.$validator.validateAll().then(result => {
          if (result) {
            this.$emit('submit', this.branch)
          } else {
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.invalid'),
              color: 'warning'
            })
          }
        })
      }
    },
    created () {
      this.getCity()
      !!this.dataBranch && this.setInitData()
    }
  }
  </script>
  `

<template>
  <v-form @submit.prevent="validateBeforeSubmit">
    <v-container fluid>
      <v-layout row wrap>
        <v-flex xs6>
          <v-text-field :error-messages="errors.has('name') ? errors.collect('name') : []" v-validate="'required'":data-vv-as="$t('label.name')"name="name":label="$t('label.name') + '*'"v-model="branch.name">
          </v-text-field>

          <v-text-field :error-messages="errors.has('phone') ? errors.collect('phone') : []":data-vv-as="$t('label.phone')"name="phone":label="$t('label.phone')"v-model="branch.phone">
          </v-text-field>

          <v-text-field :error-messages="errors.has('website') ? errors.collect('website') : []":data-vv-as="$t('label.website')"name="website":label="$t('label.website')"v-model="branch.website">
          </v-text-field>

          <v-text-field :error-messages="errors.has('email') ? errors.collect('email') : []":data-vv-as="$t('label.email')"name="email":label="$t('label.email') + '*'"v-model="branch.email">
          </v-text-field>

          <v-text-field :error-messages="errors.has('facebook') ? errors.collect('facebook') : []":data-vv-as="$t('label.facebook')"name="facebook":label="$t('label.facebook') "v-model="branch.facebook">
          </v-text-field>
          <v-text-field :error-messages="errors.has('instagram') ? errors.collect('instagram') : []":data-vv-as="$t('label.instagram')"name="instagram":label="$t('label.instagram')"v-model="branch.instagram">
          </v-text-field>

          <v-text-field :error-messages="errors.has('zalo') ? errors.collect('zalo') : []":data-vv-as="$t('label.zalo')"name="zalo":label="$t('label.zalo')"v-model="branch.zalo">
          </v-text-field>

          <label>Trạng thái</label>
          <v-checkbox   style="margin-top:0px" :label='status' :error-messages="errors.has('status') ? errors.collect('status') : []":data-vv-as="$t('label.status')" name="status" v-model="branch.status">
          </v-checkbox>

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

          <v-select v-if="Array.isArray(cityAll)" v-validate="'required'" :error-messages="errors.has('city_id') ? errors.collect('city_id') : []" :data-vv-as="$t('label.city_id')" name="city_id" :label="$t('label.city_id') + '*'" v-model="branch.city_id" :items="cityAll" item-value="id" item-text="name" @change="changedCity" placeholder="Chọn một thành phố">
          </v-select>

          <v-select v-if="districtByCity.districts" :error-messages="errors.has('district_id') ? errors.collect('district_id') : []":data-vv-as="$t('label.district_id')" name="district_id" :label="$t('label.district_id')+ '*'"v-model="branch.district_id" :items="districtByCity.districts.data" item-value="id" item-text="name" placeholder="Hãy chọn một quận hoặc huyện">
          </v-select>

          <v-select v-else name="district_id" :label="$t('label.district_id')" v-model="branch.district_id" placeholder="Bạn cần chọn thành phố trước">
          </v-select>

          <label>Thuộc loại</label>
          <v-checkbox style="margin-top:0px" :label="type_branch" :error-messages="errors.has('type') ? errors.collect('type') : []" :data-vv-as="$t('label.type')" name="type" v-model="branch.type"></v-checkbox>

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
import { mapGetters, mapActions } from 'vuex'
export default{
  name: 'BranchForm',
  components: {
    DataView
  },
  computed: {
    ...mapGetters(['isFetchingApi']),
    ...mapGetters('City', ['cityAll', 'districtByCity']),
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
      // defaults:0,
      type_branch: 'Chi nhánh Chính',
      status: 'Hiển thị',
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
        type: 0,
        city_id: '',
        district_id: '',
        status: ''
      }
    }
  },
  methods: {
    ...mapActions(['fetchApi']),
    ...mapActions('City', ['getCity', 'getDistrictByCity']),
    setInitData () {
      let dataBranch = { ...this.dataBranch }
      this.branch = { ...this.branch, ...dataBranch }
    },
    changedCity (value) {
      this.getDistrictByCity({
        city_id: value
      })
    },
    validateBeforeSubmit () {
      this.$validator.validateAll().then(result => {
        if (result) {
          let branch = Object.assign({}, this.branch)
          branch.status = branch.status ? 1 : 0
          branch.type = branch.type ? 1 : 0
          this.$emit('submit', branch)
        } else {
          this.$store.dispatch('showNotify', {
            text: this.$t('alert.invalid'),
            color: 'warning'
          })
        }
      })
    }
  },
  mounted () {
    this.getDistrictByCity({
      city_id: this.branch.city_id
    })
  },
  created () {
    this.getCity()
    !!this.dataBranch && this.setInitData()
  }
}
</script>
<style>
  label{
    color: #5b5a5a;
    font-size:17px;
  }
</style>

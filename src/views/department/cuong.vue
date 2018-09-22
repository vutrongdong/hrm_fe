<template>
  <v-form  @submit.prevent="validateBeforeSubmit">
        <v-container fluid>
          <h2>department</h2>
        <v-layout row wrap>
            <v-flex xs6>
            <v-text-field
              :error-messages="errors.has('name') ? errors.collect('name') : []"
              v-validate="'required|min:3'"
              :data-vv-as="$t('label.name')"
              name="name"
              :label="$t('label.name') + '*'"
              v-model="department.name">
            </v-text-field>
          </v-flex>

           <v-flex xs6>
               <v-select v-validate="'required'"
              :error-messages="errors.has('status') ? errors.collect('status') : []"
               :data-vv-as="$t('label.status')" name="status" :label="$t('label.status')"
                v-model="department.status" :items="items" item-value="id" item-text="name">
                </v-select>
          </v-flex>

        </v-layout>

         <v-layout row wrap>
            <v-flex xs6>
            <v-text-field
              :error-messages="errors.has('branch_id') ? errors.collect('branch_id') : []"
              v-validate="'required'"
              :data-vv-as="$t('label.branch_id')"
              name="branch_id"
              :label="$t('label.branch_id') + '*'"
              v-model="department.branch_id">
            </v-text-field>
          </v-flex>
        </v-layout>
      </v-container>

        <v-container fluid>
          <h2>branch</h2>
        <v-layout row wrap>
          <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('name') ? errors.collect('name') : []"
            v-validate="'required'"
            :data-vv-as="$t('label.name')"
            name="name"
            :label="$t('label.name') + '*'"
            v-model="department.branch.data.id">
          </v-text-field>
         <!--  <v-select v-validate="'required'"
                :error-messages="errors.has('branch_id') ? errors.collect('branch_id') : []"
                :data-vv-as="$t('label.branch_id')"
                name="branch_id"
                 :label="$t('label.branch_id')"
                 v-model="department.branch.data.branch_id"
                 item-value="department.branch.data.id"
                 item-text="na"
                 :items=""
                >
          </v-select> -->
        </v-flex>
         <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('description') ? errors.collect('description') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.description')"
            name="description"
            :label="$t('label.description') + '*'"
            v-model="department.branch.data.description">
          </v-text-field>
        </v-flex>
        </v-layout>
         <v-layout row wrap>
          <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('about') ? errors.collect('about') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.about')"
            name="about"
            :label="$t('label.about') + '*'"
            v-model="department.branch.data.about">
          </v-text-field>
        </v-flex>
         <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('phone') ? errors.collect('phone') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.phone')"
            name="phone"
            :label="$t('label.phone') + '*'"
            v-model="department.branch.data.phone">
          </v-text-field>
        </v-flex>
        </v-layout>
         <v-layout row wrap>
          <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('address') ? errors.collect('address') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.address')"
            name="address"
            :label="$t('label.address') + '*'"
            v-model="department.branch.data.address">
          </v-text-field>
        </v-flex>
         <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('website') ? errors.collect('website') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.website')"
            name="website"
            :label="$t('label.website') + '*'"
            v-model="department.branch.data.website">
          </v-text-field>
        </v-flex>
        </v-layout>

        <v-layout row wrap>
          <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('email') ? errors.collect('email') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.email')"
            name="email"
            :label="$t('label.email') + '*'"
            v-model="department.branch.data.email">
          </v-text-field>
        </v-flex>
         <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('facebook') ? errors.collect('facebook') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.facebook')"
            name="facebook"
            :label="$t('label.facebook') + '*'"
            v-model="department.branch.data.facebook">
          </v-text-field>
        </v-flex>
        </v-layout>

          <v-layout row wrap>
          <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('instagram') ? errors.collect('instagram') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.instagram')"
            name="instagram"
            :label="$t('label.instagram') + '*'"
            v-model="department.branch.data.instagram">
          </v-text-field>
        </v-flex>
         <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('zalo') ? errors.collect('zalo') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.zalo')"
            name="zalo"
            :label="$t('label.zalo') + '*'"
            v-model="department.branch.data.zalo">
          </v-text-field>
        </v-flex>
        </v-layout>

          <v-layout row wrap>
          <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('tax_number') ? errors.collect('tax_number') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.tax_number')"
            name="tax_number"
            :label="$t('label.tax_number') + '*'"
            v-model="department.branch.data.tax_number">
          </v-text-field>
        </v-flex>
         <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('bank') ? errors.collect('bank') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.bank')"
            name="bank"
            :label="$t('label.bank') + '*'"
            v-model="department.branch.data.bank">
          </v-text-field>
        </v-flex>
        </v-layout>

            <v-layout row wrap>
          <v-flex xs6>
               <v-select v-validate="'required'"
              :error-messages="errors.has('type') ? errors.collect('type') : []"
               :data-vv-as="$t('label.type')" name="type" :label="$t('label.type')"
                v-model="department.branch.data.type" :items="chinhanh" item-value="id" item-text="name">
                </v-select>
          </v-flex>

           <v-flex xs6>
          <v-select v-validate="'required'"
                :error-messages="errors.has('city_id') ? errors.collect('city_id') : []"
                :data-vv-as="$t('label.city_id')"
                name="city_id"
                 :label="$t('label.city_id')"
                 v-model="department.branch.data.city_id"
                 :items="cityAll"
                 item-value="id"
                 item-text="name"
                 @change="changedCity">
          </v-select>
          </v-flex>
        </v-layout>
           <v-layout row wrap>
          <v-flex xs6>
               <v-select v-validate="'required'"  v-if="districtByCity.districts" :items="districtByCity.districts.data"
              :error-messages="errors.has('district') ? errors.collect('district') : []"
               :data-vv-as="$t('label.district')" name="type" :label="$t('label.district')"
                v-model="department.branch.data.district_id"  item-value="id" item-text="name">
                </v-select>
                 <v-select v-model="department.branch.data.district_id" v-else :label="$t('label.district_id')" placeholder='vui lòng chọn thành phố trước khi chọn bố'>
          </v-select>
          </v-flex>
           <v-flex xs6>
               <v-select v-validate="'required'"
              :error-messages="errors.has('branch_status') ? errors.collect('branch_status') : []"
               :data-vv-as="$t('label.branch_status')" name="branch_status" :label="$t('label.branch_status')"
                v-model="department.branch.data.status" :items="items" item-value="id" item-text="name">
                </v-select>
          </v-flex>
        </v-layout>
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
        </v-container>
  </v-form>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
export default{
  name: 'DepartmentForm',
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
    datacity: {
      type: Object,
      default: () => {
        return {}
      }
    },
    dataDepartment: {
      type: Object,
      default: () => {
        return {}
      }
    },
    datadistrict: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  data () {
    return {
      department: {
        name: '',
        status: '',
        branch_id: '',
        branch: {
          data: {
            id: '',
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
            status: ''
          }
        }
      },
      items: [
        {
          'id': '',
          'name': '-- Su lua chon ---'
        },
        {
          'id': 1,
          'name': 'Hiển thị'
        },
        {
          'id': 0,
          'name': 'Không hiển thị'
        }
      ],
      chinhanh: [
        {
          'id': '',
          'name': '-- Sự lựa chọn ---'
        },
        {
          'id': 1,
          'name': 'Chi nhánh chính'
        },
        {
          'id': 2,
          'name': 'Chi nhánh phu'
        }
      ]
    }
  },

  methods: {
    ...mapActions(['fetchApi']),
    ...mapActions('City', ['getCity', 'getDistrictByCity']),
    setInitData () {
      let dataDepartment = { ...this.dataDepartment }
      this.department = { ...this.department, ...dataDepartment }
    },
    changedCity (value) {
      this.getDistrictByCity({
        cityId: value
      })
    },
    validateBeforeSubmit () {
      this.$validator.validateAll().then(result => {
        if (result) {
          this.$emit('submit', this.department)
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
    !!this.dataDepartment && this.setInitData()
  }

}
</script>

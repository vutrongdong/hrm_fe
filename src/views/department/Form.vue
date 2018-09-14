<template>
  <v-form>
   <!--    <v-container fluid>
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
          <v-text-field
            :error-messages="errors.has('status') ? errors.collect('status') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.status')"
            name="status"
            :label="$t('label.status') + '*'"
            v-model="department.status">
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
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.name')"
            name="name"
            :label="$t('label.name') + '*'"
            v-model="department.branch.data.name">
          </v-text-field>
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
            :error-messages="errors.has('phone') ? errors.collect('phone') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.phone')"
            name="phone"
            :label="$t('label.phone') + '*'"
            v-model="department.branch.data.phone">
          </v-text-field>
        </v-flex>
        </v-layout>

         </v-layout>
       <v-layout row wrap>
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
        </v-layout>

      <v-layout row wrap>
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
      </v-layout>

      <v-layout row wrap>
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
        </v-layout>

        <v-layout row wrap>
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
         <v-flex xs6>
          <v-text-field
            :error-messages="errors.has('type') ? errors.collect('type') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.type')"
            name="type"
            :label="$t('label.type') + '*'"
            v-model="department.branch.data.type">
          </v-text-field>
        </v-flex>
        </v-layout>
      </v-container> -->
  </v-form>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import { map, chain } from 'lodash'
export default{
  name: 'DepartmentForm',
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
        branch: {
           data: {
              name: '',
              description: '',
              about: '',
              phone: '',
              address: '',
              website: '',
              email : '',
              facebook: '',
              instagram:'',
              zalo: '',
              tax_number: '',
              bank: '',
              type: '',
              city_id: '',
              district_id: '',
              status:''
           }
        }
      }
    }
  },

  methods:{
      ...mapActions(['fetchApi']),
      ...mapActions('City',['getCity']),
      ...mapActions('District',['getDistrictByCity']),
  }

}
</script>

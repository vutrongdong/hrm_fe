<template>
  <v-container>
    <v-form @submit.prevent="validateBeforeSubmit">
      <v-tabs centered color="cyan" dark icons-and-text md12>
        <v-tabs-slider color="yellow"></v-tabs-slider>
        <!-- thông tin chi nhánh -->
        <v-tab href="#tab-1">
          Thông tin chi nhánh
          <v-icon>fas fa-info-circle</v-icon>
        </v-tab>
        <!-- Thông tin thêm -->
        <v-tab href="#tab-2">
          Thông tin thêm
          <v-icon>phone</v-icon>
        </v-tab>
        <!-- tab1 -->
        <v-tab-item id="tab-1" style="margin:30px 0px">
          <v-card flat row>
            <!-- <h4>Thông tin chính</h4> -->
            <v-layout>
              <v-flex md6 xs6 style="margin-right:10px">
                <!-- name -->
                <v-text-field
                placeholder="Tên chi nhánh"
                :error-messages="errors.has('name') ? errors.collect('name') : []"
                v-validate="'required'"
                :data-vv-as="$t('label.name')"
                name="name"
                :label="$t('label.name') + '*'"
                v-model="branch.name"> </v-text-field>
                <!-- address -->
                <v-text-field
                placeholder="Nhập địa chỉ"
                :error-messages="errors.has('address') ? errors.collect('address') : []"
                :data-vv-as="$t('label.address')"
                name="address"
                v-validate="'required'"
                :label="$t('label.address') + '*'"
                v-model="branch.address"> </v-text-field>
                <!-- tax_number -->
                <v-text-field
                placeholder="Nhập mã số thuế"
                :error-messages="errors.has('tax_number') ? errors.collect('tax_number') : []"
                :data-vv-as="$t('label.tax_number')"
                name="tax_number"
                v-validate="'required'"
                :label="$t('label.tax_number') + '*'"
                v-model="branch.tax_number"> </v-text-field>
                <!-- status -->
                <label>Trạng thái</label>
                <v-checkbox
                style="margin-top:0px"
                :label='status'
                @change='statusBranch'
                :error-messages="errors.has('status') ? errors.collect('status') : []"
                :data-vv-as="$t('label.status')"
                name="status"
                v-model="branch.status"> </v-checkbox>
              </v-flex>
              <v-flex md6 xs6 style="margin-left:10px">
                <!-- city -->
                <v-select
                v-if="Array.isArray(cityAll)"
                v-validate="'required'"
                :error-messages="errors.has('city_id') ? errors.collect('city_id') : []"
                :data-vv-as="$t('label.city_id')"
                name="city_id"
                :label="$t('label.city_id') + '*'"
                v-model="branch.city_id"
                :items="cityAll"
                item-value="id"
                item-text="name"
                @change="changedCity"
                placeholder="Chọn một thành phố" > </v-select>
                <!-- district -->
                <v-select
                v-if="districtAll.districts.data"
                :disabled = "!districtActive"
                v-validate="'required'"
                :error-messages="errors.has('district_id') ? errors.collect('district_id') : []"
                :data-vv-as="$t('label.district_id')"
                name="district_id"
                :label="$t('label.district_id')+ '*'"
                v-model="branch.district_id"
                :items="districtAll.districts.data"
                item-value="id"
                item-text="name"
                placeholder="Hãy chọn một quận hoặc huyện"> </v-select>
                <!-- email -->
                <v-text-field
                placeholder="Nhập email"
                :error-messages="errors.has('email') ? errors.collect('email') : []"
                :data-vv-as="$t('label.email')"
                name="email"
                v-validate="'required'"
                :label="$t('label.email') + '*'"
                v-model="branch.email"> </v-text-field>
                <!-- type_branch -->
                <label>Thuộc loại</label>
                <v-checkbox
                @change="typeBranch"
                style="margin-top:0px"
                :label="type_branch"
                :error-messages="errors.has('type') ? errors.collect('type') : []"
                :data-vv-as="$t('label.type')"
                name="type"
                v-model="branch.type"></v-checkbox>
              </v-flex>
            </v-layout>
          </v-card>
        </v-tab-item>
        <!-- tab1 -->
        <v-tab-item id="tab-2" style="margin:30px 0px">
          <v-card flat row>
            <v-layout>
              <v-flex md6 xs6 style="margin-right:10px">
                <!-- phone -->
                <v-text-field
                placeholder="Nhập số điện thoại"
                :error-messages="errors.has('phone') ? errors.collect('phone') : []"
                :data-vv-as="$t('label.phone')"
                name="phone"
                :label="$t('label.phone')"
                v-model="branch.phone"> </v-text-field>
                <!-- facebook -->
                <v-text-field
                placeholder="Nhập link facebook"
                :error-messages="errors.has('facebook') ? errors.collect('facebook') : []"
                :data-vv-as="$t('label.facebook')"
                name="facebook"
                :label="$t('label.facebook') "
                v-model="branch.facebook"> </v-text-field>
                <!-- website -->
                <v-text-field
                placeholder="Nhập link website"
                :error-messages="errors.has('website') ? errors.collect('website') : []"
                :data-vv-as="$t('label.website')"
                name="website"
                :label="$t('label.website')"
                v-model="branch.website"> </v-text-field>
                <!-- description -->
                <v-text-field
                placeholder="Nhập mô tả"
                :error-messages="errors.has('description') ? errors.collect('description') : []"
                :data-vv-as="$t('label.description')"
                name="description"
                :label="$t('label.description')"
                v-model="branch.description"> </v-text-field>
              </v-flex>
              <v-flex md6 xs6 style="margin-left:10px">
                <!-- about -->
                <v-text-field
                placeholder="Nhập thông tin"
                :error-messages="errors.has('about') ? errors.collect('about') : []"
                :data-vv-as="$t('label.about')"
                name="about"
                :label="$t('label.about')"
                v-model="branch.about"> </v-text-field>
                <!-- instagram -->
                <v-text-field
                placeholder="Nhập instagram"
                :error-messages="errors.has('instagram') ? errors.collect('instagram') : []"
                :data-vv-as="$t('label.instagram')"
                name="instagram"
                :label="$t('label.instagram')"
                v-model="branch.instagram"> </v-text-field>
                <!-- zalo -->
                <v-text-field
                placeholder="Nhập zalo"
                :error-messages="errors.has('zalo') ? errors.collect('zalo') : []"
                :data-vv-as="$t('label.zalo')"
                name="zalo"
                :label="$t('label.zalo')"
                v-model="branch.zalo"> </v-text-field>
                <!-- bank -->
                <v-text-field
                placeholder="Nhập tài khoản ngân hàng"
                :error-messages="errors.has('bank') ? errors.collect('bank') : []"
                :data-vv-as="$t('label.bank')"
                name="bank"
                :label="$t('label.bank')"
                v-model="branch.bank"> </v-text-field>
              </v-flex>
            </v-layout>
          </v-card>
        </v-tab-item>
      </v-tabs>
      {{dataBranch}}
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
  </v-form>
</v-container>
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
      districtActive: false,
      type_branch: 'Chi nhánh Chính',
      status: 'Hoạt động',
      districtAll: {},
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
        type: true,
        city_id: '',
        district_id: '',
        status: true
      }
    }
  },
  watch: {
    dataBranch (val) {
      this.branch = val
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
      this.districtActive = true
      this.getDistrictByCity({
        cityId: value,
        cb: () => {
          this.districtAll = this.districtByCity
        }
      })
    },
    statusBranch () {
      if (this.branch.status) { this.status = 'Hoạt động' } else { this.status = 'Không hoạt động' }
    },
    typeBranch () {
      if (this.branch.type) { this.type_branch = 'Chi nhánh chính' } else { this.type_branch = 'Chi nhánh phụ' }
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
  created () {
    !!this.dataBranch && this.setInitData()
    if (this.$route.params.id) {
      this.districtActive = true
      this.getDistrictByCity({
        cityId: this.dataBranch.city_id,
        cb: () => {
          this.districtAll = this.districtByCity
        }
      })
    } else {
      this.getDistrictByCity({
        cityId: 1,
        cb: () => {
          this.districtAll = this.districtByCity
        }
      })
    }
    this.getCity()
  }
}
</script>
<style>
label{
  color: #5b5a5a;
  font-size:17px;
}
</style>

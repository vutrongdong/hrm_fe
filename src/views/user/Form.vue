
<template>
  <v-form @submit.prevent="validateBeforeSubmit">
    <v-tabs centered color="cyan" dark icons-and-text >
      <v-tabs-slider color="yellow"></v-tabs-slider>
      <!-- thông tin tài khoản -->
      <v-tab href="#tab-1">
        Thông tin tài khoản
      </v-tab>
      <!-- Thông tin cá nhân -->
      <v-tab href="#tab-2">
        Thông tin cá nhân
      </v-tab>
      <!-- công việc -->
      <v-tab href="#tab-3">
        Công việc
      </v-tab>
      <!-- tab1 -->
      <v-tab-item id="tab-1" style="margin:30px 0px">
        <v-card flat row>
         <v-layout>
          <v-flex md6 style="margin-right:10px">
            <!-- email -->
            <v-text-field
            placeholder="Example@gmail.com"
            :error-messages="errors.has('email') ? errors.collect('email') : []"
            v-validate="'required|email'"
            :data-vv-as="$t('label.email')"
            name="email"
            :label="$t('label.email')"
            class="input-required"
            type="email"
            :disabled="!isCreate"
            v-model="user.email"> </v-text-field>
            <!-- password -->
            <v-text-field
            placeholder="Nhập mật khẩu"
            v-if="isCreate"
            :error-messages="errors.has('password') ? errors.collect('password') : []" v-validate="'required|min:6'"
            :data-vv-as="$t('label.password')"
            name="password"
            :label="$t('label.password')"
            class="input-required"
            type="password"
            v-model="user.password"> </v-text-field>
            <!-- status -->
            <v-flex style="margin-top:12px;">
              <label>Trạng thái</label>
              <v-flex row>
                <v-checkbox
                style="margin-top:0px"
                @change="status_txt"
                :label="status"
                class="checkbox"
                name="status"
                v-model="user.status">
              </v-checkbox>
            </v-flex></v-flex>
          </v-flex>
          <v-spacer></v-spacer>
          <v-flex md6 style="margin-left:10px">
            <!-- name -->
            <v-text-field
            placeholder="Nhập vào tên"
            :error-messages="errors.has('name') ? errors.collect('name') : []"
            v-validate="'required|min:3'"
            :data-vv-as="$t('label.name')"
            name="name"
            :label="$t('label.name')"
            class="input-required"
            v-model="user.name"></v-text-field>
            <!-- password confirm -->
            <v-text-field
            placeholder="Nhập lại mật khẩu"
            v-if="isCreate"
            :error-messages="errors.has('password_confirmation') ? errors.collect('password_confirmation') : []"
            v-validate="'required|min:6'"
            :data-vv-as="$t('label.password_confirmation')"
            name="password_confirmation"
            :label="$t('label.password_confirmation')"
            class="input-required"
            type="password"
            v-model="user.password_confirmation"> </v-text-field>
            <!-- quyền truy cập -->
            <v-autocomplete
            multiple
            label="Quyền truy cập"
            v-model="user.roles"
            :items="roles"
            chips
            item-text="name"
            item-value="id"
            color="white"
            hide-no-data
            hide-selected
            placeholder="Tìm kiếm"
            style="margin-left:-30px"
            prepend-icon="mdi-database-search">
            <template slot="selection" slot-scope="data">
              <v-chip
              :selected="data.selected"
              close class="chip--select-multi"
              @input="data.parent.selectItem(data.item)">
              {{ data.item.name }}
            </v-chip></template></v-autocomplete>
          </v-flex>
        </v-layout>
      </v-card>
    </v-tab-item>
    <!-- tab2 -->
    <v-tab-item id="tab-2" style="margin-top:30px">
      <v-layout>
        <v-flex md6 style="margin-right:10px">
          <!-- phone -->
          <v-text-field
          placeholder="nhập số điện thoại"
          :error-messages="errors.has('phone') ? errors.collect('phone') : []"
          :data-vv-as="$t('label.phone')"
          name="phone"
          :label="$t('label.phone')"
          v-model="user.phone"></v-text-field>
          <!-- address -->
          <v-text-field
          :error-messages="errors.has('address') ? errors.collect('address') : []"
          placeholder="Nhập địa chỉ"
          :data-vv-as="$t('label.address')"
          name="address"
          :label="$t('label.address')"
          v-model="user.address"> </v-text-field>
          <!-- qualification -->
          <v-text-field
          placeholder="nhập trình độ học vấn"
          :error-messages="errors.has('qualification') ? errors.collect('qualification') : []"
          :data-vv-as="$t('label.qualification')"
          name="qualification"
          :label="$t('label.qualification')"
          v-model="user.qualification"></v-text-field>
          <!-- gender -->
          <v-flex md12 row>
            <v-flex style="margin-top:12px">
              <v-select
              :items="genderUser"
              item-text="name"
              item-value="value"
              v-model="user.gender"
              label="Giới tính"
              ></v-select>
            </v-flex> </v-flex>
          </v-flex>
          <v-flex md6 style="margin-left:10px">
            <!-- birth_day -->
            <template>
              <v-menu
              ref="dateOfBirth"
              :close-on-content-click="false"
              v-model="dateOfBirth"
              :nudge-right="40"
              lazy transition="scale-transition"
              offset-y
              full-width
              min-width="290px">
              <v-text-field
              placeholder="Nhập ngày sinh"
              slot="activator"
              v-model="user.date_of_birth"
              label="Ngày sinh"
              readonly > </v-text-field>
              <v-date-picker
              ref="picker"
              v-model="user.date_of_birth"
              :max="new Date().toISOString().substr(0, 10)"
              min="1950-01-01"
              @change="save"> </v-date-picker> </v-menu>
            </template>
            <!-- image -->
            <v-flex class="mt-3">
              <label style="color: #7f8c91;">Ảnh đại diện</label>
              <imageUpload :multiple="false"/>
            </v-flex> </v-flex>
          </v-layout>
        </v-tab-item>
        <v-tab-item id="tab-3" style="margin-top:30px">
          <h3 v-if="isCreate">Hợp đồng</h3>
          <v-layout row wrap v-if="isCreate">
            <v-flex xs6 class="pr-2">
              <!-- title contract -->
              <v-text-field
              placeholder="Nhập tiêu đề hợp đồng"
              :error-messages="errors.has('title') ? errors.collect('title') : []"
              :data-vv-as="$t('label.title')"
              name="title"
              :label="$t('label.title') + ' * '"
              v-model="user.contracts.title"> </v-text-field>
              <!-- type contract -->
              <v-select
              :error-messages="errors.has('type') ? errors.collect('type') : []"
              :data-vv-as="$t('label.type')"
              name="type"
              :label="$t('label.type')"
              v-model="user.contracts.type"
              :items="typeContract"
              item-value="value"
              item-text="name"> </v-select>
              <!-- status contract-->
              <v-select
              :error-messages="errors.has('status') ? errors.collect('status') : []"
              :data-vv-as="$t('label.status')"
              name="status"
              :label="$t('label.status')"
              v-model="user.contracts.status"
              :items="statusContract"
              item-value="value"
              item-text="name"> </v-select>
            </v-flex>
            <v-flex xs6 class="pl-2">
              <!-- date_sign -->
              <template>
                <v-menu
                ref="dateSign"
                :close-on-content-click="false"
                v-model="dateSign"
                :nudge-right="40"
                lazy transition="scale-transition"
                offset-y
                full-width
                min-width="290px">
                <v-text-field
                placeholder="Nhập ngày ký"
                slot="activator"
                v-model="user.contracts.date_sign"
                label="Ngày ký"
                readonly > </v-text-field>
                <v-date-picker
                ref="picker"
                v-model="user.contracts.date_sign"
                :max="new Date().toISOString().substr(0, 10)"
                min="1950-01-01"
                @change="save"> </v-date-picker> </v-menu>
              </template>
              <!-- date_effective -->
              <template>
                <v-menu
                ref="dateEffective"
                :close-on-content-click="false"
                v-model="dateEffective"
                :nudge-right="40"
                lazy transition="scale-transition"
                offset-y
                full-width
                min-width="290px">
                <v-text-field
                placeholder="Ngày có hiệu lực"
                slot="activator"
                v-model="user.contracts.date_effective"
                label="Ngày có hiệu lực"
                readonly > </v-text-field>
                <v-date-picker
                ref="picker"
                v-model="user.contracts.date_effective"
                :max="new Date().toISOString().substr(0, 10)"
                min="1950-01-01"
                @change="save"> </v-date-picker> </v-menu>
              </template>
              <!-- date_expiration -->
              <template>
                <v-menu
                ref="dateExpiration"
                :close-on-content-click="false"
                v-model="dateExpiration"
                :nudge-right="40"
                lazy transition="scale-transition"
                offset-y
                full-width
                min-width="290px">
                <v-text-field
                placeholder="Ngày hết hạn"
                slot="activator"
                v-model="user.contracts.date_expiration"
                label="Ngày có hết hạn"
                readonly > </v-text-field>
                <v-date-picker
                ref="picker"
                v-model="user.contracts.date_expiration"
                :max="new Date().toISOString().substr(0, 10)"
                min="1950-01-01"
                @change="save"> </v-date-picker> </v-menu>
              </template>
            </v-flex>

          </v-layout>
          <v-layout row wrap>
            <!-- form sub -->
            <formSub
            :dataUser="user"
            v-on:positionAndDepartment="positionAndDepartment($event)">
          </formSub>
        </v-layout>
        <!-- tab3 -->
      </v-tab-item>
    </v-tabs>
    <!-- end tab -->
    <!-- button create or update -->
    <v-flex md12 text-md-center>
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
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import { map } from 'lodash'
import formSub from './FormSub'
import imageUpload from '@/components/UploadMultipleImage/UploadMultipleImage'
export default{
  name: 'UserForm',
  components: { formSub, imageUpload },
  computed: {
    ...mapGetters(['isFetchingApi']),
    ...mapGetters('Contracts', ['contractDetail']),
    isCreate () {
      return this.type === 'create'
    }
  },
  props: {
    type: {
      type: String,
      default: 'create'
    },
    dataUser: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  data () {
    return {
      status: 'Kích hoạt',
      dateOfBirth: false,
      dateSign: false,
      dateEffective: false,
      dateExpiration: false,
      genderUser: [
      { name: 'Nam', value: 1 },
      { name: 'Nữ', value: 0 },
      { name: 'Khác', value: 2 }
      ],
      typeContract: [
      { name: 'Học việc', value: 0 },
      { name: 'Cộng tác viên', value: 1 },
      { name: 'Thử việc', value: 2 },
      { name: 'Có thời hạn', value: 3 },
      { name: 'Không thời hạn', value: 4 },
      { name: 'Khác', value: 5 }
      ],
      statusContract: [
      { name: 'Tiêu chuẩn', value: 0 },
      { name: 'Chấm dứt', value: 1 },
      { name: 'Gia hạn', value: 2 }
      ],
      user: {
        avatar: '',
        gender: 1,
        status: true,
        roles: [],
        departments: [],
        contracts:
        {
          status: 0,
          type: 0,
          date_sign: null,
          date_effective: null,
          date_expiration: null
        }
      },
      roles: []
    }
  },
  watch: {
    dataUser (val) {
      this.user = val
    },
    dateOfBirth (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    },
    dateSign (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    },
    dateEffective (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    },
    dateExpiration (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    }
  },
  methods: {
    ...mapActions(['fetchApi']),
    setInitData () {
      let dataUser = { ...this.dataUser }
      if (dataUser.roles) {
        dataUser.roles = map(dataUser.roles.data, (role) => {
          return role.id
        })
      }
      this.user = { ...this.user, ...dataUser }
    },
    save (date) {
      this.$refs.dateOfBirth.save(date)
      this.$refs.dateSign.save(date)
      this.$refs.dateEffective.save(date)
      this.$refs.dateExpiration.save(date)
    },
    status_txt () {
      if (this.user.status) { this.status = 'Kích hoạt' } else { this.status = 'Không kích hoạt' }
    },
    // thời gian đăng kí , có hiệu lực hợp đồng
    dateConstract () {
      let today = new Date()
      let dd = today.getDate()
      let mm = today.getMonth() + 1
      let yyyy = today.getFullYear()

      if (dd < 10) {
        dd = '0' + dd
      }

      if (mm < 10) {
        mm = '0' + mm
      }
      today = yyyy + '-' + mm + '-' + dd
      this.user.contracts.date_sign = today
      this.user.contracts.date_effective = today
    },
    // thời gian kết thúc hợp đồng
    dateExpirationConstract () {
      let today = new Date()
      let dd = today.getDate()
      let mm = today.getMonth() + 3
      let yyyy = today.getFullYear()

      if (dd < 10) {
        dd = '0' + dd
      }

      if (mm < 10) {
        mm = '0' + mm
      }
      today = yyyy + '-' + mm + '-' + dd
      this.user.contracts.date_expiration = today
    },
    validateBeforeSubmit () {
      this.$validator.validateAll().then(result => {
        if (result) {
          let user = Object.assign({}, this.user)
          user.status = user.status ? 1 : 0
          this.$emit('submit', this.user)
        } else {
          this.$store.dispatch('showNotify', {
            text: this.$t('alert.invalid'),
            color: 'warning'
          })
        }
      })
    },
    positionAndDepartment (updated) {
      this.user.departments = updated
    }
  },
  mounted () {
    this.fetchApi({
      url: 'roles',
      method: 'GET',
      params: {
        limit: -1
      },
      success: (response) => {
        this.roles = response.data
      }
    })
  },
  created () {
    this.dateExpirationConstract()
    this.dateConstract()
    this.dataUser && this.setInitData()
    this.status_txt()
  }
}
</script>
<style scoped>
label{
  color: #5b5a5a;
  font-size:15px;
}
.image-icon-info{
  display:none !important;
}
</style>

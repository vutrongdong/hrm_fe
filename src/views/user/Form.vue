<template>
  <v-form @submit.prevent="validateBeforeSubmit">
    <v-tabs centered color="cyan" dark icons-and-text >
      <v-tabs-slider color="yellow"></v-tabs-slider>
      <!-- thông tin tài khoản -->
      <v-tab href="#tab-1">
        Thông tin tài khoản
        <v-icon>phone</v-icon>
      </v-tab>
      <!-- Thông tin cá nhân -->
      <v-tab href="#tab-2">
        Thông tin cá nhân
        <v-icon>account_box</v-icon>
      </v-tab>
      <!-- công việc -->
      <v-tab href="#tab-3">
        Công việc
        <v-icon>favorite</v-icon>
      </v-tab>
      <!-- tab1 -->
      <v-tab-item id="tab-1" style="margin:30px 0px">
        <v-card flat row>
         <v-layout>
          <v-flex md6 style="margin-right:10px">
            <!-- email -->
            <v-text-field
            placeholder="vd:trongdong717@gmail.com"
            :error-messages="errors.has('email') ? errors.collect('email') : []"
            v-validate="'required|email'"
            :data-vv-as="$t('label.email')"
            name="email"
            :label="$t('label.email') + '*'"
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
            :label="$t('label.password') + '*'"
            type="password"
            v-model="user.password"> </v-text-field>
            <!-- status -->
            <v-flex style="margin-top:12px;">
              <label>Trạng Thái</label>
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
            :label="$t('label.name') + '*'"
            v-model="user.name"></v-text-field>
            <!-- password confirm -->
            <v-text-field
            placeholder="Nhập lại password"
            v-if="isCreate"
            :error-messages="errors.has('password_confirmation') ? errors.collect('password_confirmation') : []"
            v-validate="'required|min:6'"
            :data-vv-as="$t('label.password_confirmation')"
            name="password_confirmation"
            :label="$t('label.password_confirmation') + '*'"
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
            placeholder="tìm kiếm"
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
              ref="menu"
              :close-on-content-click="false"
              v-model="menu"
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
              <imageUpload/>
            </v-flex> </v-flex>
          </v-layout>
        </v-tab-item>
        <v-tab-item id="tab-3" style="margin-top:30px">
          <h3>Hợp đồng</h3>
          <v-layout row wrap>
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
              v-validate="'required'"
              :error-messages="errors.has('type') ? errors.collect('type') : []"
              :data-vv-as="$t('label.type')"
              name="type"
              :label="$t('label.type')"
              v-model="user.contracts.type"
              :items="contractDetail"
              item-value="type"
              item-text="type_txt"> </v-select>
              <!-- status contract-->
              <v-select
              v-validate="'required'"
              :error-messages="errors.has('status') ? errors.collect('status') : []"
              :data-vv-as="$t('label.status')"
              name="status"
              :label="$t('label.status')"
              v-model="user.contracts.status"
              :items="contractDetail"
              item-value="status"
              item-text="status_txt"> </v-select>
            </v-flex>
            <v-flex xs6 class="pl-2">
              <!-- date_sign -->
              <v-datetime-picker
              label="Ngày đăng kí"
              v-model="user.contracts.date_sign"
              ></v-datetime-picker>
              <!-- date_efective -->
              <v-datetime-picker
              label="Ngày có hiệu lực"
              v-model="user.contracts.date_efective"
              ></v-datetime-picker>
              <!-- date_expiration -->
              <v-datetime-picker
              label="Ngày kết thúc"
              v-model="user.contracts.date_expiration"
              ></v-datetime-picker>
            </v-flex>

          </v-layout>
          <v-layout row wrap>
            <!-- form sub -->
            <formSub
            :dataUser="user"
            v-on:positionAndDepartment="positionAndDepartment($event)">
          </formSub> </v-flex>
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
import formSub from './Form_sub'
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
      range: 1,
      menu: false,
      genderUser: [
        { name: 'Nam', value: 1 },
        { name: 'Nữ', value: 2 },
        { name: 'Khác', value: 3 }
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
          date_efective: null,
          date_expiration: null
        }
      },
      roles: []
    }
  },
  watch: {
    menu (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    },
    dataUser (val) {
      this.user = val
    }
  },
  methods: {
    ...mapActions(['fetchApi']),
    ...mapActions('Contracts', ['fetchContract']),
    setInitData () {
      let dataUser = { ...this.dataUser }
      console.log('let', dataUser)
      if (dataUser.roles) {
        dataUser.roles = map(dataUser.roles.data, (role) => {
          return role.id
        })
      }
      this.user = { ...this.user, ...dataUser }
    },
    save (date) {
      this.$refs.menu.save(date)
    },
    status_txt () {
      if (this.user.status) { this.status = 'Kích hoạt' } else { this.status = 'Không kích hoạt' }
    },
    // thời gian đăng kí , có hiệu lực hợp đồng
    dateConstract () {
      let date = new Date()
      this.user.contracts.date_sign = date
      this.user.contracts.date_efective = date
    },
    // thời gian kết thúc hợp đồng
    dateExpirationConstract () {
      let date = new Date()
      date.setMonth(date.getMonth() + 2)
      this.user.contracts.date_expiration = date
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
    this.fetchContract()
    this.dataUser && this.setInitData()
    this.status_txt()
  }
}
</script>
<style coped>
label{
  color: #5b5a5a;
  font-size:15px;
}
.image-list-container, align-items-center{
  display:none !important;
}
.image-icon-info{
  display:none !important;
}
</style>

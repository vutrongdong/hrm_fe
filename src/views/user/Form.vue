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
         <h3>Thông tin tài khoản</h3>
         <v-layout>
          <v-flex md6 style="margin-right:10px">
            <!-- email -->
            <v-text-field
            placeholder="Nhập email"
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
      <h3>Thông tin cá nhân</h3>
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
              <label style="margin-top:10px">Giới tính</label>
              <v-checkbox
              @change="gender_txt"
              :label="gender"
              class="checkbox"
              style="margin-top:0px;"
              name="gender"
              v-model="user.gender">
            </v-checkbox>
          </v-flex> </v-flex>
        </v-flex>
        <!--right  thông tin bổ sung -->
        <v-flex md6 style="margin-left:10px">
          <!-- address -->
          <v-text-field
          :error-messages="errors.has('address') ? errors.collect('address') : []"
          placeholder="Nhập địa chỉ"
          :data-vv-as="$t('label.address')"
          name="address"
          :label="$t('label.address')"
          v-model="user.address"> </v-text-field>
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
          <v-flex>
            <link href='https://fonts.googleapis.com/css?family=Material+Icons' rel="stylesheet" type="text/css">
            <v-text-field placeholder="Chọn một ảnh" label="Hình ảnh" @click='pickFile' v-model='user.avatar'></v-text-field>
            <input
            type="file"
            style="display: none"
            ref="image"
            accept="image/*"
            @change="onFilePicked"
            >
            <img :src="imageUrl" width="100%" v-if="imageUrl"/>
          </v-flex> </v-flex>
        </v-layout>
      </v-tab-item>
      <v-tab-item id="tab-3" style="margin-top:30px">
        <v-flex md-11>
            <!-- form sub -->
            <form_Sub
            :dataUser="user"
            v-on:positionAndDepartment="positionAndDepartment($event)"> </form_Sub> </v-flex>
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
  import form_Sub from './Form_sub'
  export default{
    name: 'UserForm',
    components: { form_Sub },
    computed: {
      ...mapGetters(['isFetchingApi']),
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
    watch: {
      menu (val) {
        val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
      },
      dataUser (val) {
        this.user = val
      }
    },
    data () {
      return {
        imageUrl: '',
        imageFile: '',
        gender: '',
        status: 'Kích hoạt',
        range: 1,
        menu: false,
        user: {
          avatar: '',
          gender: true,
          status: true,
          roles: [],
          departments: []
        },
        roles: [],
        departmentPosition: []
      }
    },
    methods: {
      ...mapActions(['fetchApi']),
      setInitData () {
        let dataUser = { ...this.dataUser }
        console.log('let',dataUser)
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
      status_txt ()
      {
        if (this.user.status) { this.status = 'Kích hoạt' } else { this.status = 'Không kích hoạt' }
      },
    gender_txt () {
      if (this.user.gender) { this.gender = 'Nam' } else { this.gender = 'Nữ' }
    },
  validateBeforeSubmit () {
    this.$validator.validateAll().then(result => {
      if (result) {
        let user = Object.assign({}, this.user)
        user.gender = user.gender ? 1 : 0
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
  pickFile () {
    this.$refs.image.click()
  },
  onFilePicked (e) {
    const files = e.target.files
    if (files[0] !== undefined) {
      this.user.avatar = files[0].name
      if (this.user.avatar.lastIndexOf('.') <= 0) {
        return
      }
      const fr = new FileReader()
      fr.readAsDataURL(files[0])
      fr.addEventListener('load', () => {
        this.imageUrl = fr.result
              this.imageFile = files[0] // this is an image file that can be sent to server...
            })
    } else {
      this.user.avatar = ''
      this.imageFile = ''
      this.imageUrl = ''
    }
  },
    // end upload image
    positionAndDepartment (updated, index) {
      this.departmentPosition[index] = updated
      this.user.departments = this.departmentPosition
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
    this.dataUser && this.setInitData()
    this.status_txt ()
    this.gender_txt()
  }
}
</script>
<style coped>
label{
  color: #5b5a5a;
  font-size:15px;
}
</style>

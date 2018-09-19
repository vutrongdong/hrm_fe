<template>
  <v-form @submit.prevent="validateBeforeSubmit">
    <v-container fluid>
      <v-layout row wrap>
        <v-flex xs6>
          <h3>Thông tin tài khoản</h3>
          <v-text-field :error-messages="errors.has('name') ? errors.collect('name') : []"v-validate="'required|min:3'":data-vv-as="$t('label.name')"name="name":label="$t('label.name') + '*'" v-model="user.name">
          </v-text-field>

          <v-text-field :error-messages="errors.has('phone') ? errors.collect('phone') : []":data-vv-as="$t('label.phone')"name="phone":label="$t('label.phone')"v-model="user.phone">
          </v-text-field>

          <v-text-field :error-messages="errors.has('email') ? errors.collect('email') : []"v-validate="'required|email'":data-vv-as="$t('label.email')"name="email":label="$t('label.email') + '*'"type="email":disabled="!isCreate"v-model="user.email">
          </v-text-field>

          <v-text-field v-if="isCreate":error-messages="errors.has('password') ? errors.collect('password') : []"v-validate="'required|min:6'":data-vv-as="$t('label.password')"name="password":label="$t('label.password') + '*'"type="password"v-model="user.password">
          </v-text-field>

          <v-text-field v-if="isCreate":error-messages="errors.has('password_confirmation') ? errors.collect('password_confirmation') : []"v-validate="'required|min:6'":data-vv-as="$t('label.password_confirmation')"name="password_confirmation":label="$t('label.password_confirmation') + '*'"type="password"v-model="user.password_confirmation">
          </v-text-field>

          <h3>Quyền truy cập</h3>
          <v-autocomplete multiple v-model="user.roles":items="roles"chips item-text="name"item-value="id"color="white"hide-no-data hide-selected placeholder="tìm kiếm"prepend-icon="mdi-database-search" style="margin-top:-5px; margin-left:-33px">
            <template slot="selection"slot-scope="data">
              <v-chip :selected="data.selected"close class="chip--select-multi"@input="data.parent.selectItem(data.item)">
                {{ data.item.name }}
              </v-chip>
            </template>
          </v-autocomplete>
        </v-flex>
        <v-flex xs6>
          <h3>Thông tin nhân sự</h3>
          <v-text-field :error-messages="errors.has('qualification') ? errors.collect('qualification') : []":data-vv-as="$t('label.qualification')"name="qualification":label="$t('label.qualification')" v-model="user.qualification">
          </v-text-field>

          <v-text-field :error-messages="errors.has('address') ? errors.collect('address') : []":data-vv-as="$t('label.address')"name="address":label="$t('label.address')"v-model="user.address">
          </v-text-field>

          <template>
            <v-menu ref="menu":close-on-content-click="false"v-model="menu":nudge-right="40"lazy transition="scale-transition"offset-y full-width min-width="290px">
              <v-text-field slot="activator"v-model="user.date_of_birth" label="Ngày sinh"readonly >
              </v-text-field>

              <v-date-picker ref="picker" v-model="user.date_of_birth":max="new Date().toISOString().substr(0, 10)"min="1950-01-01"@change="save">
              </v-date-picker>
            </v-menu>
          </template>

          <v-text-field :error-messages="errors.has('company_name') ? errors.collect('company_name') : []":data-vv-as="$t('label.company_name')"name="company_name":label="$t('label.company_name')"v-model="user.company_name">
          </v-text-field>

          <v-flex xs12 row>
            <v-flex xs5 style="margin-left:20px">
              <label style="margin-top:10px">Giới tính</label>
              <v-radio-group style="margin-top:-2px" v-model="user.gender" row>
                <v-radio value='0' label="Nam"></v-radio>
                <v-radio value='1' label="Nữ"></v-radio>
              </v-radio-group>
            </v-flex>
            <v-spacer></v-spacer>
            <v-flex xs5>
              <label style="margin-top:10px">Trạng Thái</label>
              <v-radio-group style="margin-top:-2px" v-model="user.status" row>
                <v-radio value='0' label="Ân"></v-radio>
                <v-radio value='1' label="Hiện"></v-radio>
              </v-radio-group>
            </v-flex>
          </v-flex>
        </v-flex>

        <v-flex xs12>
          <h3 style="margin-bottom:15px">Chi nhánh, phòng ban, vị trí</h3>
          <children :id='index' v-for="(n,index) in range" :DepartmentUser="department_user" @add="Add()" @delete="Remove(index)"></children>
        </v-flex>

        <v-flex xs12 text-xs-center>
          <v-btn :loading="isFetchingApi":disabled="isFetchingApi"color="primary"type="submit"
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
import { map } from 'lodash'
import children from './Form_sub'
export default{
  name: 'UserForm',
  components:{children},
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
    }
  },
  data () {
    return {
      range:1,
      menu: false,
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        roles: []
      },
      roles: [],
      department_user:[]
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
      this.$refs.menu.save(date)
    },
    Add() {
      this.range += 1
    },
    Remove(index){
      if(index!=0){
        $('#'+index).remove()
      }
    },
    validateBeforeSubmit () {
      this.$validator.validateAll().then(result => {
        if (result) {
          this.$emit('submit', this.user)
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
    !!this.dataUser && this.setInitData()
  }
}
</script>
<style>
label{
  color: #5b5a5a;
  font-size:15px;
}
</style>

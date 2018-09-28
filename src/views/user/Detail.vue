<template>
  <v-layout ref="laylout" row fill-height>
   <v-flex xs4>
    <listting :is-mini="true" />
  </v-flex>
  <v-flex xs8 class="border-e0-left">
    <v-toolbar dense color="white" flat>
      <v-toolbar-title>{{ $t('title.user.detail') }}: {{userDetail.name}}</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn  v-if="canAccess('user.update')" icon @click="$router.push({name: 'user-edit', params: {id: $route.params.id}})">
        <v-icon>edit</v-icon>
      </v-btn>
      <v-btn v-if="canAccess('user.delete')" icon @click="removeConfirm">
        <v-icon>delete</v-icon>
      </v-btn>
      <v-btn icon @click="$router.push({name: 'user'})">
        <v-icon>close</v-icon>
      </v-btn>
    </v-toolbar>
    <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
      <v-layout row>
        <v-flex md5 sm5 xs5>
          <img v-if="userDetail.image" src="userDetail.image" alt="">
          <img width="100%" src="https://demo1.sinnovasoft.com/Content/images/empty.png" alt="">
        </v-flex>
        <v-flex md7 sm7 xs7 style="padding-left:10px;" id="info-user">
          <p v-if="userDetail.code"> - Mã nhân viên : {{ userDetail.code }}</p>
          <p v-if="userDetail.name"> - Tên nhân viên : {{ userDetail.name }}</p>
          <p v-if='userDetail.qualification'> - Trình độ chuyên môn : {{ userDetail.qualification }}</p>
          <p v-if='userDetail.address'> - Địa chỉ : {{ userDetail.address }}</p>
          <p v-if="userDetail.phone"> - Số điện thoại: {{ userDetail.phone }}</p>
          <p v-if="userDetail.gender_txt"> - Giới tính: {{ userDetail.gender_txt }}</p>
          <p v-if="userDetail.date_of_birth"> - Ngày sinh: {{ userDetail.date_of_birth }}</p>
          <p v-if="userDetail.status_txt"> - Trạng thái: {{ userDetail.status_txt }}</p>
        </v-flex>
      </v-layout>{{ userDetail.departments.data[0].name }}
      <v-layout row v-if="userDetail.departments">
        <v-flex style="margin-top:40px;">
          <p row style="margin-top:-20px;">
              <p v-for='department in userDetail.departments.data' style="margin-left:15px;" :key="'department' + department.id">
                <!-- <p color="green" text-color="white" v-if="department.branch">{{ department.branch.data.name }}</p>
                <p color="orange" text-color="white">{{ department.name }}</p>
                <p color="teal" text-color="white">{{ department.position_name }} --></p>
              </p>
          </p>
        </v-flex>
      </v-layout>
    </v-container>
  </v-flex>
  <dialog-confirm v-model="dialogDelete" @input="remove" />
</v-layout>
</template>

<script>
import Listting from './Listting'
import { mapActions, mapGetters } from 'vuex'
import DialogConfirm from '@/components/DialogConfirm'
export default{
  name: 'UserDetail',
  components: {
    Listting,
    DialogConfirm
  },
  data () {
    return {
      dataViewHeight: 0,
      dialogDelete: false
    }
  },
  computed: {
    ...mapGetters('User', ['userDetail'])
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('User', ['getUser', 'deleteUser']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    removeConfirm () {
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteUser({
          id: this.$route.params.id,
          cb: (response) => {
            this.removeDataviewEntry({
              name: 'user',
              data: this.userDetail,
              key: 'id'
            })
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.$router.push({name: 'user'})
          },
          error: (error) => {
            if (error.status === 404) {
              this.$store.dispatch('showNotify', {
                text: this.$t('alert.not-found'),
                color: 'warning'
              })
            }
          }
        })
      }
    }
  },
  created () {
    this.setMiniDrawer(true)
    if (!this.userDetail.id) {
      this.getUser({ userId: this.$route.params.id, params: { include: 'roles,departments' } })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }
}
</script>

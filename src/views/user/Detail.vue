<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs4>
      <listting />
    </v-flex>
    <v-flex xs8 class="border-e0-left">
      <v-toolbar dense color="white" flat>
        <v-toolbar-title>{{ $t('title.user.detail') }}: {{userDetail.name}}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-menu :nudge-width="100" offset-y>
          <v-btn icon slot="activator">
            <v-icon>more_vert</v-icon>
          </v-btn>
          <v-list>
            <v-list-tile
            v-for="item in 10"
            :key="item"
            >
            <v-list-tile-title v-text="item"></v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu>
      <v-btn v-if="canAccess('user.update')" icon @click="$router.push({name: 'user-edit', params: {id: $route.params.id}})">
        <v-icon>edit</v-icon>
      </v-btn>
      <v-btn v-if="canAccess('user.delete')" icon @click="removeConfirm()">
        <v-icon>delete</v-icon>
      </v-btn>
      <v-btn icon @click="$router.push({name: 'user'})">
        <v-icon>close</v-icon>
      </v-btn>
    </v-toolbar>
    <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
      <p>Tên: {{userDetail.name}}</p>
      <p>Mã nhân viên: {{ userDetail.code }}</p>
      <p>Trình độ chuyên môn:{{ userDetail.qualification }}</p>
      <p>Địa chỉ:{{ userDetail.address }}</p>
      <p>Email: {{userDetail.email}}</p>
      <p>Số điện thoại: {{userDetail.phone}}</p>
      <p>Giới tính: {{ userDetail.gender_txt }}</p>
      <p>Ngày sinh:{{ userDetail.date_of_birth }}</p>
      <p v-if="userDetail.departments">Thuộc phòng ban:
        <v-chip color="green" text-color="white" v-for="dm in userDetail.departments.data" :key="'dm' + dm.id">
          {{dm.name}}
        </v-chip>
      </p>
      <p v-if="userDetail.positions">Chức vụ:
        <v-chip color="orange" text-color="white" v-for="position in userDetail.positions.data" :key="'position' + position.id">
          {{position.name}}
        </v-chip>
      </p>
      <p v-if="userDetail.roles">Quyền truy cập:
        <v-chip color="secondary" text-color="white" v-for="role in userDetail.roles.data" :key="'role' + role.id">
          {{role.name}}
        </v-chip>
      </p>
      <P>Trạng thái:{{ userDetail.status_txt }}</P>
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
            this.$router.push({ name: 'user' })
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
      this.getUser({ userId: this.$route.params.id, params: { include: 'departments,positions,roles' } })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }
}
</script>

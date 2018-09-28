<template>
  <v-layout ref="laylout" fill-height>
    <v-flex xs12 class="border-e0-left white">
      <v-toolbar dense color="white" flat>
        <v-spacer></v-spacer>
        <v-toolbar-title>Chỉnh sửa người dùng: {{userDetail.name}}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon @click="$router.push({name: 'user'})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-container class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
        <user-form v-if="userDetail.id" @submit="submitForm" type="edit" :dataUser="userDetail" />
      </v-container>
    </v-flex>
  </v-layout>
</template>
<script>
import UserForm from './Form'
import Listting from './Listting'
import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'EditUser',
  components: {
    UserForm,
    Listting
  },
  data () {
    return {
      dataViewHeight: 0
    }
  },
  computed: {
    ...mapGetters('User', ['userDetail'])
  },
  methods: {
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('User', ['updateUser', 'getUser', 'setUser']),
    ...mapActions('Dataview', ['updateDataviewEntry']),
    submitForm (formData) {
      // console.log(formData)
      // return false
      this.updateUser({
        id: this.$route.params.id,
        user: formData,
        params: {
          include: 'roles'
        },
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })
          this.setUser({ user: response.data })
          this.updateDataviewEntry({
            name: 'user',
            data: response.data,
            key: 'id'
          })
          this.$router.push({ name: 'user', params: { id: this.$route.params.id } })
        }
      })
    }
  },
  created () {
    if (!this.userDetail.id) {
      this.getUser({ userId: this.$route.params.id, params: { include: 'roles,departments' } })
    }
    console.log('userDetail', this.userDetail)
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }
}
</script>

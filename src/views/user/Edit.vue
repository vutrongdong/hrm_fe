<template>
  <v-layout ref="laylout" fill-height>
    <v-flex class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
      <user-form v-if="userDetail.id" @submit="submitForm" type="edit" :dataUser="userDetail" />
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
      if (formData.departments.data) {
        formData.departments = formData.departments.data
      }
      this.updateUser({
        id: this.$route.params.id,
        user: formData,
        params: {
          include: 'roles,departments'
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
      this.getUser({ userId: this.$route.params.id, params: { include: 'roles,departments,contracts' } })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 5
  }
}
</script>

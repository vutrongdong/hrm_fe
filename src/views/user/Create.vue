<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs12 pa-5 class="white">
      <h3>Thêm Chi Nhánh</h3>
      <user-form @submit="submitForm" />
    </v-flex>
  </v-layout>
</template>

<script>
import UserForm from './Form'
import { mapActions } from 'vuex'
export default{
  name: 'CreateUser',
  components: {
    UserForm
  },
  methods: {
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('User', ['createUser']),
    submitForm (formData) {
      this.createUser({
        user: formData,
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })

          this.$router.push({
            name: 'user',
            query: {
              reload: null
            }
          })
        }
      })
    }
  },
  created () {
    this.setMiniDrawer(false)
  }
}
</script>

<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs12 pa-5 class="white">
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
<<<<<<< HEAD
      console.log(formData)
      return false
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
=======
      // this.createUser({
      //   user: formData,
      //   cb: (response) => {
      //     this.showNotify({
      //       color: 'success',
      //       text: 'Thành công'
      //     })
      //     this.$router.push({
      //       name: 'user',
      //       query: {
      //         reload: null
      //       }
      //     })
      //   }
      // })
      console.log('data', formData)
>>>>>>> origin/dev
    }
  },
  created () {
    this.setMiniDrawer(false)
  }
}
</script>

<template>
  <v-layout ref="laylout" row>
    <v-flex xs12 class="border-e0-left white">
      <v-toolbar dense color="white" flat>
        <v-spacer></v-spacer>
        <v-toolbar-title>{{ $t('title.user.create') }}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon @click="$router.push({name: 'user'})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-container>
        <user-form @submit="submitForm" />
      </v-container>
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
      if (formData.departments.length && !formData.departments[0].department_id) {
        formData.departments = []
      }
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

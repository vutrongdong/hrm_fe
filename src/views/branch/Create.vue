<template>
  <v-card flat>
    <v-flex xs12>
      <v-toolbar dense color="white" flat>
        <v-spacer></v-spacer>
        <v-toolbar-title>{{ $t('title.branch.create') }}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon @click="$router.push({name: 'branch'})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
      <branch-form @submit="submitForm"/>
    </v-flex>
  </v-card>
</template>
<script>
import BranchForm from './Form'
import { mapActions } from 'vuex'
export default{
  name: 'CreateForm',
  components: {
    BranchForm
  },
  methods: {
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Branch', ['createBranch']),
    submitForm (formData) {
      // console.log(formData)
      // return false
      this.createBranch({
        branch: formData,
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })
          this.$router.push({
            name: 'branch',
            query: {
              reload: null
            }
          })
        }
      })
    }
  }
}
</script>

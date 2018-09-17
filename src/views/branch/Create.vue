<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs12>
      <h2 style="padding:15px">Thêm Chi Nhánh</h2>
      <branch-form @submit="submitForm"/>
    </v-flex>
  </v-layout>
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

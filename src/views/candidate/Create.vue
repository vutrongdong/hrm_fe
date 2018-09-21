<template>
  <v-layout row wrap>
      <v-flex xs12 pa-5 class="white">
            <candidate-form @submit="submitForm" />
      </v-flex>
  </v-layout>
</template>
<script>
import CandidateForm from './Form'
import { mapActions } from 'vuex'
export default{
 name: 'CreateCandidate',
 components: {
    CandidateForm
  },
  methods: {
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Candidate', ['createCandidate']),
    submitForm (formData) {
        this.createCandidate({
            candidate : formData,
            cb: (response) =>{
              this.showNotify({
                 color: 'success',
                 text: 'Thành công'
              })
              this.$router.push({
                  name: 'candidate',
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

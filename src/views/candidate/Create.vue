<template>
  <v-layout row wrap>
      <v-flex xs12 pa-5 class="white">
        <v-toolbar dense color="white" flat>
          <v-toolbar-title>{{ $t('title.candidate.create') }}</v-toolbar-title>
          <v-spacer></v-spacer>
         <v-btn icon @click="$router.push({name: 'candidate'})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
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
        candidate: formData,
        cb: (response) => {
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

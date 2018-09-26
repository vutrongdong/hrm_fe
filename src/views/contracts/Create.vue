<template>
  <v-layout row wrap>
      <v-flex xs12 pa-5 class="white">
        <v-toolbar dense color="white" flat>
          <v-toolbar-title>{{ $t('title.contract.create') }}</v-toolbar-title>
          <v-spacer></v-spacer>
         <v-btn icon @click="$router.push({name: 'contract'})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
            <contract-form @submit="submitForm" />
      </v-flex>
  </v-layout>
</template>
<script type="text/javascript">
import ContractForm from './Form'
import { mapActions, mapGetters } from 'vuex'
  export default{
 name: 'CreateContract',
  components: {
    ContractForm
  },
  methods: {
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Contracts', ['createContract']),
    submitForm (formData) {
      this.createContract({
        contract: formData,
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })
          this.$router.push({
            name: 'contract',
            // query: {
            //   reload: null
            // }
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

<template>
  <v-layout ref="laylout" row fill-height>
      <v-flex  xs12 class="border-e0-left white">
      <v-toolbar dense color="white" flat>
          <v-toolbar-title>{{ $t('title.candidate.edit') }} : {{contractDetail.title}} </v-toolbar-title>
          <v-spacer></v-spacer>
         <v-btn icon @click="$router.push({name: 'candidate-detail', params: {id: $route.params.id}})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-container fluid>
          <ContractForm v-if="contractDetail.id" @submit="submitForm" type="edit" :dataContract="contractDetail"/>
      </v-container>
      </v-flex>
  </v-layout>
</template>
<script type="text/javascript">
import ContractForm from './Form'
import listting from './Listting'
import { mapActions, mapGetters } from 'vuex'
  export default{
  name: 'EditContract',
  components: {
    ContractForm
  },
  data () {
    return {
    }
  },
  computed: {
    ...mapGetters('Contracts', ['contractDetail'])
  },
  methods: {
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Contracts', ['updateContract', 'getContract', 'setContract']),
    ...mapActions('Dataview', ['updateDataviewEntry']),
    submitForm (formData) {
      this.updateContract({
        id: this.$route.params.id,
        contract: formData,
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })
          this.setContract({ contract: response.data })
          this.updateDataviewEntry({
            name: 'contract',
            data: response.data,
            key: 'id'
          })
          this.$router.push({
            name: 'contract',
            query: {
              reload: null
            }
          })
        }
      })
    }
  },
  created () {
    this.setMiniDrawer(true)
    if (!this.contractDetail.id) {
      this.getContract({ contractId: this.$route.params.id })
    }
  },
  }
</script>

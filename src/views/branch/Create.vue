<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs12 class="border-e0-left white">
      <v-toolbar dense color="white" flat>
        <v-spacer></v-spacer>
        <v-toolbar-title>{{ $t('title.branch.create') }}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon @click="$router.push({name: 'branch'})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
       <branch-form @submit="submitForm"/>
     </v-container>
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
  data () {
    return {
      dataViewHeight: 0
    }
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
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }
}
</script>

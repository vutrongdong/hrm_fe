<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs12 class="border-e0-left white">
      <v-toolbar dense color="white" flat>
        <v-spacer></v-spacer>
        <v-toolbar-title>{{ $t('title.branch.edit') }}: {{branchDetail.name}}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon @click="$router.push({name: 'branch'})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
        <branch-form v-if="branchDetail.id" @submit="submitForm" type="edit" :dataBranch="branchDetail" />
      </v-container>
    </v-flex>
  </v-layout>
</template>
<script>
import BranchForm from './Form'
import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'CreateBranch',
  components: {
    BranchForm
  },
  data () {
    return {
      dataViewHeight: 0
    }
  },
  computed: {
    ...mapGetters('Branch', ['branchDetail'])
  },
  methods: {
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Branch', ['updateBranch', 'getBranch', 'getBranchs', 'setBranch']),
    ...mapActions('Dataview', ['updateDataviewEntry']),
    submitForm (formData) {
      this.updateBranch({
        id: this.$route.params.id,
        branch: formData,
        params: {
        },
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })
          this.setBranch({ branch: response.data })
          this.updateDataviewEntry({
            name: 'branch',
            data: response.data,
            key: 'id'
          })
          this.$router.push({
            name: 'branch',
            params: { id: this.$route.params.id }
          })
        }
      })
    }
  },
  created () {
    this.setMiniDrawer(true)
    if (!this.branchDetail.id) {
      this.getBranch({ branchId: this.$route.params.id })
      this.getBranchs()
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }
}
</script>

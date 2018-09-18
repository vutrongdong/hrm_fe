<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs4>
      <listting />
    </v-flex>
    <v-flex xs8 class="border-e0-left white">
      <v-toolbar dense color="white" flat>
        <v-toolbar-title>{{ $t('title.branch.edit') }}: {{branchDetail.name}}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon @click="$router.push({name: 'branch-detail', params: {id: $route.params.id}})">
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
import Listting from './Listting'
import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'CreateBranch',
  components: {
    BranchForm,
    Listting
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
    ...mapActions('Branch', ['updateBranch', 'getBranch', 'setBranch']),
    ...mapActions('Dataview', ['updateDataviewEntry']),
    submitForm (formData) {
      this.updateBranch({
        id: this.$route.params.id,
        branch: formData,
        params: {
          include: 'roles'
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
            name: 'branch-detail',
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
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }
}
</script>

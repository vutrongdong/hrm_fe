<template>
   <v-layout ref="laylout" row fill-height>
      <!--  <v-flex xs4>
            <listting />
      </v-flex> -->
      <v-flex xs12 class="border-e0-left">
          <v-toolbar dense color="white" flat>
            <v-toolbar-title>{{ $t('title.plan.edit') }}: {{planDetail.title}}</v-toolbar-title>
            <v-spacer></v-spacer>
            <v-btn icon @click="$router.push({name: 'position-detail', params: {id: $route.params.id}})">
               <v-icon>close</v-icon>
            </v-btn>
          </v-toolbar>
          <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
               <plan-form v-if="planDetail.id" @submit="submitForm"  type="edit" :dataPlan="planDetail" />
          </v-container>
      </v-flex>
   </v-layout>
</template>
<script>
import PlanForm from './Form'
import listting from './Listting'

import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'EditPlan',
  components: {
    PlanForm,
    listting
  },
  data () {
    return {
      dataViewHeight: 0
    }
  },
  computed: {
    ...mapGetters('Plan', ['planDetail'])
  },
  methods: {
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Plan', ['updatePlan', 'getPlan', 'setPlan']),
    ...mapActions('Dataview', ['updateDataviewEntry']),
    submitForm (formData) {
      this.updatePlan({
        id: this.$route.params.id,
        plan: formData,
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })
          this.setPlan({ plan: response.data })
          this.updateDataviewEntry({
            name: 'plan',
            data: response.data,
            key: 'id'
          })
          this.$router.push({
            name: 'plan-detail',
            params: { id: this.$route.params.id }
          })
        }
      })
    }
  },
  created () {
    this.setMiniDrawer(true)
    if (!this.planDetail.id) {
      this.getPlan({ planId: this.$route.params.id,  params: { include: 'details' }})
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }
}
</script>

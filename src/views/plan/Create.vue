<template>
    <v-layout row>
         <v-flex xs12 pa-5 class="white">
              <PlanForm @submit="submitForm" />
        </v-flex>
    </v-layout>
</template>
<script>
import PlanForm from './Form'
import { mapActions } from 'vuex'
export default{
  name: 'CreatePlan',
  components: {
    PlanForm
  },
  methods: {
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Plan', ['createPlan']),
    submitForm (formData) {
      this.createPlan({
        plan: formData,
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })
          this.$router.push({
            name: 'plan',
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

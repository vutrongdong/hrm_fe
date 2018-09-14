<template>
    <v-layout row >
        <v-flex xs12 pa-5 class="white">
                  <PositionForm @submit="submitForm"></PositionForm>
        </v-flex>
    </v-layout>
</template>
<script>
import PositionForm from './Form'
import { mapActions } from 'vuex'
export default{
  name: 'CreatePosition',
  components:{
    PositionForm
   },
   methods:{
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Position',['createPosition']),
    submitForm (formData) {
      this.createPosition({
        position: formData,
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })

          this.$router.push({
            name: 'position',
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
<style>

</style>

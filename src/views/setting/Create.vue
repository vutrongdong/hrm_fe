<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs12>
      <h2 style="padding:15px">Thêm Chi Thông Tin</h2>
      <setting-form @submit="submitForm"/>
    </v-flex>
  </v-layout>
</template>
<script>
import settingForm from './Form'
import { mapActions } from 'vuex'
export default{
  name: 'CreateForm',
  components: {
    settingForm
  },
  methods: {
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Setting', ['createSetting']),
    submitForm (formData) {
      this.createSetting({
        setting: formData,
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })

          this.$router.push({
            name: 'setting',
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

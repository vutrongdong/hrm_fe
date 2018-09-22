<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs12 class="border-e0-left white">
      <v-toolbar dense color="white" flat>
        <v-toolbar-title>{{ $t('title.setting.edit') }}: {{settingDetail.value}}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon @click="$router.push({name: 'setting'})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
        <setting-form v-if="settingDetail.id" @submit="submitForm" type="edit" :dataSetting="settingDetail" />
      </v-container>
    </v-flex>
  </v-layout>
</template>
<<<<<<< HEAD
<script>
import settingForm from './Form'
=======

<script>
import settingForm from './Form'
import Listting from './Listting'
>>>>>>> origin/dev
import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'Createsetting',
  components: {
<<<<<<< HEAD
    settingForm
=======
    settingForm,
    Listting
>>>>>>> origin/dev
  },
  data () {
    return {
      dataViewHeight: 0
    }
  },
  computed: {
    ...mapGetters('Setting', ['settingDetail'])
  },
  methods: {
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Setting', ['updateSetting', 'getSetting', 'setSetting']),
    ...mapActions('Dataview', ['updateDataviewEntry']),
    submitForm (formData) {
      this.updateSetting({
        id: this.$route.params.id,
        setting: formData,
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })
<<<<<<< HEAD
          this.setSetting({ setting: response.data })
=======

          this.setSetting({ setting: response.data })

>>>>>>> origin/dev
          this.updateDataviewEntry({
            name: 'setting',
            data: response.data,
            key: 'id'
          })
<<<<<<< HEAD
=======

>>>>>>> origin/dev
          this.$router.push({
            name: 'setting'
          })
        }
      })
    }
  },
  created () {
    this.setMiniDrawer(true)
    if (!this.settingDetail.id) {
      this.getSetting({ settingId: this.$route.params.id })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }
}
</script>

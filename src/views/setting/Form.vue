<template>
  <v-form @submit.prevent="validateBeforeSubmit">
    <v-container fluid>
      <v-layout row wrap>
        <v-flex xs12>
<<<<<<< HEAD
          <!-- name -->
          <v-text-field
          :error-messages="errors.has('name') ? errors.collect('name') : []"
          v-validate="'required'"
          :data-vv-as="$t('label.name')"
          name="name"
          :label="$t('label.name') + '*'"
          v-model="setting.name"> </v-text-field>
          <!-- value -->
          <v-text-field
          v-validate="'required'"
          :error-messages="errors.has('value') ? errors.collect('value') : []"
          :data-vv-as="$t('label.value')"
          name="value"
          :label="$t('label.value')"
          v-model="setting.value"> </v-text-field>
          <!-- status -->
          <label>Trạng thái</label>
          <v-checkbox
          v-validate="'required'"
          style="margin-top:0px"
          :label='status'
          :error-messages="errors.has('status') ? errors.collect('status') : []"
          :data-vv-as="$t('label.status')"
          name="status"
          v-model="setting.status">
        </v-checkbox>
      </v-flex>
      <v-flex xs12 text-xs-center>
        <v-btn
        :loading="isFetchingApi"
        :disabled="isFetchingApi"
        color="primary"
        type="submit"
        >
        <template v-if="isCreate">
          <v-icon left>add</v-icon> {{$t('control.create')}}
        </template>
        <template v-else>
          <v-icon left>save</v-icon> {{$t('control.save')}}
        </template>
      </v-btn>
    </v-flex>
  </v-layout>
</v-container>
=======
          <v-text-field
          :error-messages="errors.has('name') ? errors.collect('name')
          : []" v-validate="'required'" :data-vv-as="$t('label.name')"
          name="name" :label="$t('label.name') + '*'" v-model="setting.name">
          </v-text-field>

          <v-text-field
          v-validate="'required'"
          :error-messages="errors.has('value') ? errors.collect('value') : []" :data-vv-as="$t('label.value')"
          name="value" :label="$t('label.value')" v-model="setting.value">
          </v-text-field>
          <label>Trạng thái</label>
          <v-checkbox v-validate="'required'"  style="margin-top:0px" :label='status' :error-messages="errors.has('status') ? errors.collect('status') : []" :data-vv-as="$t('label.status')" name="status" v-model="setting.status">
          </v-checkbox>
        </v-flex>
        <v-flex xs12 text-xs-center>
          <v-btn
          :loading="isFetchingApi"
          :disabled="isFetchingApi"
          color="primary"
          type="submit"
          >
          <template v-if="isCreate">
            <v-icon left>add</v-icon> {{$t('control.create')}}
          </template>
          <template v-else>
            <v-icon left>save</v-icon> {{$t('control.save')}}
          </template>
        </v-btn>
      </v-flex>
    </v-layout>
  </v-container>
>>>>>>> origin/dev
</v-form>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
export default{
  name: 'settingForm',
  components: {
    DataView
  },
  computed: {
    ...mapGetters(['isFetchingApi']),
    isCreate () {
      return this.type === 'create'
    }
  },
  props: {
    type: {
      type: String,
      default: 'create'
    },
    dataSetting: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  data () {
    return {
      status: 'Hiển thị',
      setting: {
        name: '',
        value: '',
        status: ''
      }
    }
  },
  methods: {
    ...mapActions(['fetchApi']),
    setInitData () {
      let dataSetting = { ...this.dataSetting }
      this.setting = { ...this.setting, ...dataSetting }
    },
    validateBeforeSubmit () {
      this.$validator.validateAll().then(result => {
        if (result) {
          this.$emit('submit', this.setting)
        } else {
          this.$store.dispatch('showNotify', {
            text: this.$t('alert.invalid'),
            color: 'warning'
          })
        }
      })
    }
  },
  created () {
    !!this.dataSetting && this.setInitData()
  }
}
</script>

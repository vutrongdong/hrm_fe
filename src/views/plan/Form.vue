<template>
    <v-form @submit.prevent="validateBeforeSubmit">
        <v-layout row wrap>
            <v-flex xs6>
                  <v-text-field
                    :error-messages="errors.has('title') ? errors.collect('title') : []"
                    v-validate="'required|min:3'"
                    :data-vv-as="$t('label.title')"
                    name="title"
                    :label="$t('label.title') + ' *'"
                    v-model="plan.title">
                  </v-text-field>
            </v-flex>

            <v-flex xs6>
                <v-text-field
                    :error-messages="errors.has('content') ? errors.collect('content') : []"
                    v-validate="'required|min:3'"
                    :data-vv-as="$t('label.content')"
                    name="content"
                    :label="$t('label.content') + ' *'"
                    v-model="plan.content">
                  </v-text-field>
            </v-flex>
        </v-layout>
        <v-layout row wrap>
                <v-flex xs6>
                <template>
                  <v-menu
                  ref="menu"
                  :close-on-content-click="false"
                  v-model="menu"
                  :nudge-right="40"
                  lazy transition="scale-transition"
                  offset-y full-width min-width="290px">
                    <v-text-field slot="activator" v-model="plan.date_start" label="ngày bắt đầu" readonly >
                    </v-text-field>

                <v-date-picker
                    ref="picker"
                    v-model="plan.date_start"
                    :max="new Date().toISOString().substr(0, 10)"
                    min="1950-01-01"
                    @change="save">
                    </v-date-picker>
                  </v-menu>
                </template>
                </v-flex>

                <v-flex xs6>
                <template>
                  <v-menu
                  ref="menu"
                  :close-on-content-click="false"
                  v-model="menu1"
                  :nudge-right="40"
                  lazy transition="scale-transition"
                  offset-y full-width min-width="290px">
                    <v-text-field slot="activator" v-model="plan.date_end" label="ngày kết thúc" readonly >
                    </v-text-field>

                    <v-date-picker
                    ref="picker"
                    v-model="plan.date_end"
                    :max="new Date().toISOString().substr(0, 10)"
                    min="1950-01-01"
                    @change="save">
                    </v-date-picker>
                  </v-menu>
                </template>
                </v-flex>
        </v-layout>

    <v-flex xs12 text-xs-center>
      <v-btn
      :loading="isFetchingApi"
      :disabled="isFetchingApi"
      color="primary"
      type="submit">
        <template v-if="isCreate">
          <v-icon left>add</v-icon> {{$t('control.create')}}
        </template>
        <template v-else>
          <v-icon left>save</v-icon> {{$t('control.save')}}
        </template>
        </v-btn>
    </v-flex>
    </v-form>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
// import { map, chain } from 'lodash'
export default{
  name: 'PlanForm',
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
    dataPlan: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  data () {
    return {
      menu: null,
      menu1: null,
      plan: {
        title: '',
        content: '',
        date_start: '',
        date_end: ''
      }
    }
  },
  watch: {
    menu (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    }
  },
  methods: {
    ...mapActions(['fetchApi']),
    setInitData () {
      let dataPlan = { ...this.dataPlan }
      this.plan = { ...this.plan, ...dataPlan }
    },
    validateBeforeSubmit () {
      this.$validator.validateAll().then(result => {
        if (result) {
          let submitData = { ...this.plan }
          this.$emit('submit', submitData)
        } else {
          this.$store.dispatch('showNotify', {
            text: this.$t('alert.invalid'),
            color: 'warning'
          })
        }
      })
    },
      save (date) {
      this.$refs.menu.save(date)
    },
  },
  created () {
    !!this.dataPlan && this.setInitData()
  }
}
</script>





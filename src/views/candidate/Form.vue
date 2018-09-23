<template>
  <v-form  @submit.prevent="validateBeforeSubmit">
        <v-container fluid>
        <v-layout row wrap>
          <v-flex xs6>
              <v-text-field
              :error-messages="errors.has('name') ? errors.collect('name') : []"
              v-validate="'required|min:3'"
              :data-vv-as="$t('label.name')"
              name="name"
              :label="$t('label.name') + '*'"
              v-model="candidate.name">
            </v-text-field>
          </v-flex>

            <v-flex xs6>
              <v-text-field
              :error-messages="errors.has('email') ? errors.collect('email') : []"
              v-validate="'required|min:3'"
              :data-vv-as="$t('label.email')"
              name="email"
              :label="$t('label.email') + '*'"
              v-model="candidate.email">
            </v-text-field>
          </v-flex>
        </v-layout>

          <v-layout row wrap>
          <v-flex xs6>
              <v-text-field
              :error-messages="errors.has('phone') ? errors.collect('phone') : []"
              v-validate="'required|min:3'"
              :data-vv-as="$t('label.phone')"
              name="phone"
              :label="$t('label.phone') + '*'"
              v-model="candidate.phone">
            </v-text-field>
          </v-flex>

            <v-flex xs6>
              <v-text-field
              :error-messages="errors.has('source') ? errors.collect('source') : []"
              v-validate="'required|min:3'"
              :data-vv-as="$t('label.source')"
              name="source"
              :label="$t('label.source') + '*'"
              v-model="candidate.source">
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
                    <v-text-field slot="activator" v-model="candidate.date_apply" label="ngày nộp đơn" readonly >
                    </v-text-field>

                    <v-date-picker
                    ref="picker"
                    v-model="candidate.date_apply"
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
                    <v-text-field slot="activator" v-model="candidate.time_interview" label="thời gian phỏng vấn" readonly >
                    </v-text-field>

                    <v-date-picker
                    ref="picker"
                    v-model="candidate.time_interview"
                    :max="new Date().toISOString().substr(0, 10)"
                    min="1950-01-01"
                    @change="save">
                    </v-date-picker>
                  </v-menu>
                </template>
                </v-flex>
        </v-layout>
        <v-layout row wrap>
            <v-flex xs6>
               <v-select
                  v-if="Array.isArray(planAll)"
                  v-validate="'required'"
                  :error-messages="errors.has('plan_id') ? errors.collect('plan_id') : []"
                  :data-vv-as="$t('label.plan_id')"
                  name="plan_id"
                  :label="$t('label.plan_id')"
                  v-model="candidate.plan_id"
                  :items="planAll"
                  item-value="id"
                  item-text="title">
                </v-select>
            </v-flex>
            <v-flex xs6>
               <v-select
                  v-if="Array.isArray(positionAll)"
                  v-validate="'required'"
                  :error-messages="errors.has('position_id') ? errors.collect('position_id') : []"
                  :data-vv-as="$t('label.position_id')"
                  name="position_id"
                  :label="$t('label.position_id')"
                  v-model="candidate.position_id"
                  :items="positionAll"
                  item-value="id"
                  item-text="name">
                </v-select>
            </v-flex>
        </v-layout>
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

      </v-container>
  </v-form>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
export default{
  name: 'CandidateForm',
  computed: {
    ...mapGetters(['isFetchingApi']),
    ...mapGetters('Position', ['positionAll']),
    ...mapGetters('Plan', ['planAll']),
    isCreate () {
      return this.type === 'create'
    }
  },
  props: {
    type: {
      type: String,
      default: 'create'
    },
    dataCandidate: {
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
      candidate: {
        name: '',
        email: '',
        phone: '',
        source: '',
        date_apply: '',
        time_interview: '',
        plan_id: '',
        position_id: '',
        status: 0
      },
      items: [
        {
          'id': '',
          'name': '-- Su lua chon ---'
        },
        {
          'id': 0,
          'name': 'Mới'
        },
        {
          'id': 1,
          'name': 'Chờ kết quả'
        },
        {
          'id': 2,
          'name': 'Trượt'
        },
        {
          'id': 3,
          'name': 'Đỗ'
        },
        {
          'id': 4,
          'name': 'Danh sách đen'
        }
      ]
    }
  },
  watch: {
    menu (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    }
  },
  methods: {
    ...mapActions(['fetchApi']),
    ...mapActions('Position', ['PositionForUser']),
    ...mapActions('Plan', ['planForCadidate']),
    setInitData () {
      let dataCandidate = { ...this.dataCandidate }
      this.candidate = { ...this.candidate, ...dataCandidate }
    },
    validateBeforeSubmit () {
      this.$validator.validateAll().then(result => {
        if (result) {
          this.$emit('submit', this.candidate)
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
    }
  },

  created () {
    this.PositionForUser()
    this.planForCadidate()
    !!this.dataCandidate && this.setInitData()
  }
}
</script>

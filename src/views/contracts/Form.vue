@ <template>
<v-form  @submit.prevent="validateBeforeSubmit">
        <v-container fluid>
          <v-layout row wrap>
          <v-flex xs6>
              <v-text-field
              :error-messages="errors.has('code') ? errors.collect('code') : []"
              v-validate="'required|min:3'"
              :data-vv-as="$t('label.code')"
              name="code"
              :label="$t('label.code') + '*'"
              v-model="contract.code">
            </v-text-field>
          </v-flex>

            <v-flex xs6>
               <v-text-field
              :error-messages="errors.has('title') ? errors.collect('title') : []"
              v-validate="'required|min:3'"
              :data-vv-as="$t('label.title')"
              name="title"
              :label="$t('label.title') + '*'"
              v-model="contract.title">
            </v-text-field>
            </v-flex>
        </v-layout>

        <v-layout row wrap>
          <v-flex xs6>
             <v-select
                  v-validate="'required'"
                  :error-messages="errors.has('type') ? errors.collect('type') : []"
                  :data-vv-as="$t('label.type')"
                  name="type"
                  :label="$t('label.type')"
                  v-model="contract.type"

                  :items="types"
                  item-value="id"
                  item-text="name">
            </v-select>
          </v-flex>

            <v-flex xs6>
                 <v-select
                  v-validate="'required'"
                  :error-messages="errors.has('status') ? errors.collect('status') : []"
                  :data-vv-as="$t('label.status')"
                  name="status"
                  :label="$t('label.status')"
                  v-model="contract.status"
                  :items="status"
                  item-value="id"
                  item-text="name">
            </v-select>
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
                      offset-y
                      full-width
                      min-width="290px">
                      <v-text-field
                      slot="activator"
                      v-model="contract.date_sign"
                      label="date_sign"
                      readonly >
                      </v-text-field>

                      <v-date-picker
                      ref="picker"
                      v-model="contract.date_sign"
                      :max="new Date().toISOString().substr(0, 10)"
                      min="1950-01-01"
                      @change="save"> </v-date-picker> </v-menu>
                    </template>
                </v-flex>

            <v-flex xs6>
                <template>
                  <v-menu
                  ref="menu1"
                  :close-on-content-click="false"
                  v-model="menu1"
                  :nudge-right="40"
                  lazy transition="scale-transition"
                  offset-y full-width min-width="290px">
                  <v-text-field slot="activator"
                  v-model="contract.date_effective"
                  label="date_effective" readonly >
                  </v-text-field>

                  <v-date-picker
                    ref="picker"
                    v-model="contract.date_effective"
                    :max="new Date().toISOString().substr(0, 10)"
                    min="1950-01-01"
                    @change="save1">
                    </v-date-picker>
                  </v-menu>
                </template>
                </v-flex>
        </v-layout>
         <v-layout row wrap>
                <v-flex xs6>
                   <template>
                      <v-menu
                      ref="menu2"
                      :close-on-content-click="false"
                      v-model="menu2"
                      :nudge-right="40"
                      lazy transition="scale-transition"
                      offset-y
                      full-width
                      min-width="290px">
                      <v-text-field
                      slot="activator"
                      v-model="contract.date_expiration"
                      label="date_expiration"
                      readonly >
                      </v-text-field>
                      <v-date-picker
                      ref="picker"
                      v-model="contract.date_expiration"
                      :max="new Date().toISOString().substr(0, 10)"
                      min="1950-01-01"
                      @change="save2"> </v-date-picker> </v-menu>
                    </template>
                </v-flex>
              <v-flex xs6>
                 <v-select
                  v-validate="'required'"
                  :error-messages="errors.has('user_id') ? errors.collect('user_id') : []"
                  :data-vv-as="$t('label.user_id')"
                  name="user_id"
                  :label="$t('label.user_id')"
                  v-model="contract.user_id"
                  :items="userDetail"
                  v-if="Array.isArray(userDetail)"
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
  name: 'ContractForm',
  computed: {
    ...mapGetters(['isFetchingApi']),
    ...mapGetters('User', ['userDetail']),
    isCreate () {
      return this.type === 'create'
    }
  },
  props: {
    type: {
      type: String,
      default: 'create'
    },
    dataContract: {
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
      menu2: null,
      contract: {
        code: '',
        title: '',
        type: 0,
        status: 0,
        date_sign: '',
        date_effective: '',
        date_expiration: '',
        user_id: 1
      },
      status: [
        {
          'id': 0,
          'name': 'Học việc'
        },
        {
          'id': 1,
          'name': 'Cộng tác viên'
        },
        {
          'id': 2,
          'name': 'Thử việc'
        },
        {
          'id': 3,
          'name': 'Có thời hạn'
        },
        {
          'id': 4,
          'name': 'Không thời hạn'
        },
        {
          'id': 5,
          'name': 'Khác'
        }
      ],
      types: [
        {
          'id': 0,
          'name': 'Tiêu chuẩn'
        },
        {
          'id': 1,
          'name': 'Chấm dứt'
        },
        {
          'id': 2,
          'name': 'Gia hạn'
        }
      ]
    }
  },
  watch: {
    menu (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    },
    menu1 (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    },
    menu2 (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    }

  },
  methods: {
    ...mapActions(['fetchApi']),
    ...mapActions('User', ['fetchUser']),
    setInitData () {
      let dataContract = { ...this.dataContract }
      this.contract = { ...this.contract, ...dataContract }
    },
    validateBeforeSubmit () {
      this.$validator.validateAll().then(result => {
        if (result) {
          this.$emit('submit', this.contract)
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
    save1 (date) {
      this.$refs.menu1.save(date)
    },
    save2 (date) {
      this.$refs.menu2.save(date)
    }
  },
  created () {
    this.fetchUser()
    !!this.dataContract && this.setInitData()
  }
}
</script>

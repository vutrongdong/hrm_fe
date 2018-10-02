    <template>
      <v-form  @submit.prevent="validateBeforeSubmit">
        <v-container fluid>
          <v-layout row wrap class="marTop-22">
            <v-flex xs6 class="pr-2">
              <!-- title contract -->
              <v-text-field
              placeholder="Nhập tiêu đề hợp đồng"
              :error-messages="errors.has('title') ? errors.collect('title') : []"
              :data-vv-as="$t('label.title')"
              name="title"
              :label="$t('label.title') + ' * '"
              v-model="contract.title"> </v-text-field>
              <!-- type contract -->
            </v-flex>
            <v-flex xs6 class="pr-2">
             <v-select
             v-validate="'required'"
             :error-messages="errors.has('type') ? errors.collect('type') : []"
             :data-vv-as="$t('label.type')"
             name="type"
             :label="$t('label.type')"
             v-model="contract.type"
             :items="types"
             item-value="id"
             item-text="name"> </v-select>
             <!-- status contract-->
           </v-flex>
         </v-layout>
         <v-layout row wrap class="marTop-22">
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
       <v-flex xs6>
        <!-- date_sign -->
        <!-- date_sign -->
        <template>
          <v-menu
          ref="dateSign"
          :close-on-content-click="false"
          v-model="dateSign"
          :nudge-right="40"
          lazy transition="scale-transition"
          offset-y
          full-width
          min-width="290px">
          <v-text-field
          placeholder="Nhập ngày ký"
          slot="activator"
          v-model="contract.date_sign"
          label="Ngày ký"
          readonly > </v-text-field>
          <v-date-picker
          ref="picker"
          v-model="contract.date_sign"
          :max="new Date().toISOString().substr(0, 10)"
          min="1950-01-01"
          @change="save"> </v-date-picker> </v-menu>
        </template>
      </v-flex>
    </v-layout>

    <v-layout row wrap class="marTop-22">
      <v-flex xs6>
        <!-- date_effective -->
        <template>
          <v-menu
          ref="dateEffective"
          :close-on-content-click="false"
          v-model="dateEffective"
          :nudge-right="40"
          lazy transition="scale-transition"
          offset-y
          full-width
          min-width="290px">
          <v-text-field
          placeholder="Ngày  hiệu lực"
          slot="activator"
          v-model="contract.date_effective"
          label="Ngày  hiệu lực"
          readonly > </v-text-field>
          <v-date-picker
          ref="picker"
          v-model="contract.date_effective"
          :max="new Date().toISOString().substr(0, 10)"
          min="1950-01-01"
          @change="save"> </v-date-picker> </v-menu>
          </template>
        </v-flex>

        <v-flex xs6>
         <template>
          <v-menu
          ref="dateExpiration"
          :close-on-content-click="false"
          v-model="dateExpiration"
          :nudge-right="40"
          lazy transition="scale-transition"
          offset-y
          full-width
          min-width="290px">
          <v-text-field
          placeholder="Ngày có hết hạn"
          slot="activator"
          v-model="contract.date_expiration"
          label="Ngày có hết hạn"
          readonly > </v-text-field>
          <v-date-picker
          ref="picker"
          v-model="contract.date_expiration"
          :max="new Date().toISOString().substr(0, 10)"
          min="1950-01-01"
          @change="save"> </v-date-picker> </v-menu>
        </template>
      </v-flex>
    </v-layout>

    <v-layout row wrap class="marTop-22 marButton-22">
      <v-flex xs6>
       <v-autocomplete
       v-model="contract.user_id"
       :items="userDetail"
       item-value="id"
       label="Tên nhân viên"
       item-text="name"
       v-if="Array.isArray(userDetail)"
       >
     </v-autocomplete>
   </v-flex>
 </v-layout>
 <v-flex xs12 text-xs-center class="marTop-22">
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
      dateSign: false,
      dateEffective: false,
      dateExpiration: false,
      contract: {
        code: '',
        title: '',
        type: 0,
        status: 0,
        date_sign: '',
        date_effective: '',
        date_expiration: '',
        user_id: ''
      },
      types: [
        { 'id': 0, 'name': 'Học việc' },
        { 'id': 1, 'name': 'Cộng tác viên' },
        { 'id': 2, 'name': 'Thử việc' },
        { 'id': 3, 'name': 'Có thời hạn' },
        { 'id': 4, 'name': 'Không thời hạn' },
        { 'id': 5, 'name': 'Khác' }
      ],
      status: [
        { 'id': 0, 'name': 'Tiêu chuẩn' },
        { 'id': 1, 'name': 'Chấm dứt' },
        { 'id': 2, 'name': 'Gia hạn' }
      ]
    }
  },
  watch: {
    dateSign (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    },
    dateEffective (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    },
    dateExpiration (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    }
  },
  methods: {
    ...mapActions(['fetchApi']),
    ...mapActions('User', ['fetchUser']),
    save (date) {
      this.$refs.dateSign.save(date)
      this.$refs.dateEffective.save(date)
      this.$refs.dateExpiration.save(date)
    },
    // thời gian đăng kí , có hiệu lực hợp đồng
    dateConstract () {
      let today = new Date()
      let dd = today.getDate()
      let mm = today.getMonth() + 1
      let yyyy = today.getFullYear()
      if (dd < 10) {
        dd = '0' + dd
      }
      if (mm < 10) {
        mm = '0' + mm
      }
      today = yyyy + '-' + mm + '-' + dd
      this.contract.date_sign = today
      this.contract.date_effective = today
    },
    // thời gian kết thúc hợp đồng
    dateExpirationConstract () {
      let today = new Date()
      let dd = today.getDate()
      let mm = today.getMonth() + 3
      let yyyy = today.getFullYear()
      if (dd < 10) {
        dd = '0' + dd
      }
      if (mm < 10) {
        mm = '0' + mm
      }
      today = yyyy + '-' + mm + '-' + dd
      this.contract.date_expiration = today
    },
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
    }
  },
  created () {
    this.fetchUser()
    this.dateExpirationConstract()
    this.dateConstract()
    !!this.dataContract && this.setInitData()
  }
}
</script>
<style scoped>
  .marTop-22{
   margin-top: -22px !important;
 }
 .marButton-22{
  margin-bottom: 22px !important;
}
</style>

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
          <v-datetime-picker
          label="Ngày đăng ký"
          v-model="contract.date_sign"
          ></v-datetime-picker>
        </v-flex>
      </v-layout>

      <v-layout row wrap class="marTop-22">
        <v-flex xs6>
         <!-- date_efective -->
         <v-datetime-picker
         label="Ngày có hiệu lực"
         v-model="contract.date_efective"
         ></v-datetime-picker>
       </v-flex>

       <v-flex xs6>
         <!-- date_expiration -->
         <v-datetime-picker
         label="Ngày kết thúc"
         v-model="contract.date_expiration"
         ></v-datetime-picker>
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
    menu (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    }
  },
  methods: {
    ...mapActions(['fetchApi']),
    ...mapActions('User', ['fetchUser']),
    // thời gian đăng kí , có hiệu lực hợp đồng
    dateConstract () {
      let date = new Date()
      this.contract.date_sign = date
      this.contract.date_efective = date
    },
    // thời gian kết thúc hợp đồng
    dateExpirationConstract () {
      let date = new Date()
      date.setMonth(date.getMonth() + 2)
      this.contract.date_expiration = date
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

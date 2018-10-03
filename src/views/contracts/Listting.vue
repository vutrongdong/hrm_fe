    <template>
      <v-layout ref="laylout" column fill-height>
        <div ref="header">
          <v-toolbar height="70px" color="white" flat>
            <v-layout row wrap>
             <v-flex md1 xs3 :class="isMini">
              <!--  <v-tooltip bottom> -->
              <v-tooltip bottom>
                <v-btn slot="activator" v-if="canAccess('contract.create')"
                @click="$router.push({name: 'contract-create'})"
                class="mr-3 mt-3" icon color="primary"
                >
                <v-icon>add</v-icon
                  ></v-btn>
                  <span>Thêm mới</span>
                </v-tooltip>
                <!--  <span>Thêm mới</span> -->
                <!-- </v-tooltip> -->
              </v-flex>
              <v-flex xs5 class="mr-2" :class="isMini && 'full-flex-basic'">
                <v-text-field
                hide-details
                single-line
                placeholder="Nhập tiêu đề hợp đồng"
                v-model="params.q"
                @keyup="changeSearch"
                ></v-text-field>
              </v-flex>
              <v-flex xs5 class="mt-1 mr-2" :class="isMini && 'd-none'">
                <v-autocomplete
                :items="userDetail"
                item-value="id"
                item-text="name"
                @change="filter"
                v-model="params.user_id"
                v-if="Array.isArray(userDetail)"
                >
              </v-autocomplete>
            </v-flex>
          </v-layout>
          <v-layout slot="extension" v-if="!isMini">
            <v-flex sm1 class="text-bold text-uppercase">
              STT
            </v-flex>
            <v-flex sm3 class="text-bold text-uppercase">
             tiêu đề
           </v-flex>
           <v-flex sm2 class="text-bold text-uppercase">
            loại
          </v-flex>
          <v-flex  sm2 class="text-uppercase text-bold">
            tên nhân viên
          </v-flex>
          <v-flex sm2 class="text-uppercase text-bold">
            <v-flex sm12>Ngày</v-flex>
          </v-flex>
          <v-flex sm1 class="text-bold text-uppercase pr-2">
            trạng thái
          </v-flex>
          <v-flex sm1 class="text-bold text-uppercase">
            Hành động
          </v-flex>
        </v-layout>
      </v-toolbar>
    </div>
    <v-flex xs12  class="border-e0-top">
      <data-view
      :name="dataViewName"
      api-url="contracts"
      v-if="dataViewHeight"
      :viewHeight="dataViewHeight"
      :params="params"
      :ref="dataViewName">
      <template slot-scope="{items}">
        <v-list three-line>
          <template v-for="(item, index) in items.data">
           <v-list-tile
           :key="'item' + item.id"
           avatar
           @click="contractDetail(item)"
           :inactive="item.id === $route.params.id"
           :class="item.id === $route.params.id && 'grey lighten-2'"
           >
           <v-layout class="pa-2">
            <v-flex sm1 :class="isMini && 'd-none'">
              {{index + 1}}
            </v-flex>
            <v-flex  class="pr-3" sm3 :class="isMini && 'full-flex-basic full-max-width'">
              {{ item.title }}
            </v-flex>
            <v-flex  sm2  :class="isMini && 'd-none'">
             <v-tooltip bottom sm12>
               <v-flex xs12  slot="activator">
                {{ item.type_txt }}
              </v-flex>
              <span> Loại hợp đồng</span>
            </v-tooltip>
          </v-flex>
          <v-flex class="pr-5 pl-2" sm2 :class="isMini && 'd-none'">
            {{item.user_name}}
          </v-flex>
          <v-flex xs2  class="pl-2" :class="isMini  && 'd-none'">
            <v-tooltip  bottom sm12>
              <v-flex xs12 slot="activator">
                {{item.date_sign}}
              </v-flex>
              <span>Ngày đăng ký</span>
            </v-tooltip>

            <v-tooltip  bottom sm12>
              <v-flex xs12 slot="activator">
                {{ item.date_effective }}
              </v-flex>
              <span>Ngày hiệu lực</span>
            </v-tooltip>

            <v-tooltip bottom sm12>
             <v-flex xs12 slot="activator">
              {{ item.date_expiration }}
            </v-flex>
            <span>Ngày  kết thúc</span>
          </v-tooltip>
        </v-flex>
        <v-flex xs1 class="pl-3" :class="isMini && 'd-none'">
          {{item.status_txt}}
        </v-flex>
        <v-flex xs1 class="pl-1" :class="isMini && 'd-none'">
         <v-tooltip bottom>
          <v-btn slot="activator" class="ma-0" v-if="canAccess('contracts.update')" icon @click.stop="$router.push({name: 'contract-edit', params: {id: item.id}})">
            <v-icon class='theme--light teal--text'>edit</v-icon>
          </v-btn>
          <span>Sửa</span>
        </v-tooltip>
        <v-tooltip bottom>
          <v-btn slot="activator" class="ma-0" v-if="canAccess('contracts.delete')" icon @click.stop="removeConfirm(item.id)">
            <v-icon class="theme--light pink--text">delete</v-icon>
          </v-btn>
          <span>Xóa</span>
        </v-tooltip>
      </v-flex>
    </v-layout>
  </v-list-tile>
  <v-divider
  :key="'div' + index + item.id"
  v-if="index + 1 < items.data.length"
  ></v-divider>
</template>
</v-list>
</template>
</data-view>
</v-flex>
<dialog-confirm v-model="dialogDelete" @input="remove" />
</v-layout>
</template>
<script type="text/javascript">
import DialogConfirm from '@/components/DialogConfirm'
import { debounce } from 'lodash'
import DataView from '@/components/DataView/DataView'
import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'ContractListting',
  props: {
    isMini: {
      type: Boolean,
      default: false
    }
  },
  components: {
    DataView,
    DialogConfirm
  },
  data: () => ({
    dialogDelete: false,
    dataViewHeight: 0,
    dataViewName: 'contract',
    idContract: null,
    user: [],
    params: {
      q: '',
      user_id: ''
    }
  }),
  computed: {
    ...mapGetters(['isFetchingApi']),
    ...mapGetters('User', ['userDetail']),
    ...mapGetters('Contracts', ['contractDetail'])
  },
  methods: {
    ...mapActions('Dataview', ['removeDataviewEntry']),
    ...mapActions('Contracts', ['deleteContract', 'getContract']),
    ...mapActions('User', ['fetchUser']),
    // changeStatus
    contractDetail (contract) {
      this.getContract({ contractId: contract.id })
      this.$router.push({ name: 'contract-detail', params: { id: contract.id } })
    },
    /// screach
    changeSearch: debounce(function () {
      this.filter()
    }, 500),
    filter () {
      this.$refs[this.dataViewName].$emit('reload')
    },
    removeConfirm (id) {
      this.idContract = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteContract({
          id: this.idContract,
          cb: (response) => {
            this.removeDataviewEntry({
              name: 'contract',
              data: this.contractDetail,
              key: 'id'
            })
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.$refs[this.dataViewName].$emit('reload')
          },
          error: (error) => {
            if (error.status === 404) {
              this.$store.dispatch('showNotify', {
                text: this.$t('alert.not-found'),
                color: 'warning'
              })
            }
          }
        })
      }
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 188
    let query = { ...this.$route.query }
    if (query.hasOwnProperty('reload')) {
      this.$nextTick(() => {
        this.$refs[this.dataViewName].$emit('reload')
      })
      delete query.reload
      this.$router.replace({
        query: query
      })
    }
  },
  created () {
    this.fetchUser()
  }
}
</script>
<style type="text/css" media="screen">
  .v-input.v-text-field{
       margin-top: 3px
  }
</style>

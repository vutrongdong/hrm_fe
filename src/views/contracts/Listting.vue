    <template>
      <v-layout ref="laylout" column fill-height>
        <div ref="header">
          <v-toolbar height="60px" color="white" flat>
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
            </v-layout>
            <v-layout slot="extension" v-if="!isMini">
              <v-flex sm1 class="text-bold text-uppercase">
                STT
              </v-flex>
              <v-flex sm2 class="text-bold text-uppercase">
               tiêu đề
             </v-flex>
             <v-flex sm2 class="text-bold text-uppercase">
              loại hợp đồng
            </v-flex>
            <v-flex sm2 class="text-bold text-uppercase">
              trạng thái
            </v-flex>

            <v-flex sm1 class="text-bold text-uppercase mr-3">
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
             <v-layout class="pa-2" :key="index">
               <v-flex sm1 class="ml-3" sm1 :class="isMini && 'd-none'">
                {{ index + 1 }}
              </v-flex>
              <v-flex class="pr-5" sm2 :class="isMini && 'd-none'">
                {{ item.title }}
              </v-flex>
              <v-flex xs2  :class="isMini && 'd-none'">
                {{item.type_txt}}
              </v-flex>
              <v-flex xs2 :class="isMini && 'd-none'">

              </v-flex>
            </v-layout>
          </template>
        </v-list>
      </template>
    </data-view>
  </v-flex>
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
      dataViewName: 'contracts',
      idContract: null,
      params: {
        q: ''
      }
    }),
    mounted () {
      this.dataViewHeight = this.$refs.laylout.clientHeight - 168
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
    }
  }
</script>
<style type="text/css" media="screen">

</style>

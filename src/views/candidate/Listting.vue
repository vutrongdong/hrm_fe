 <template ref="laylout" column fill-height>
  <v-layout ref="laylout" column fill-height>
    <v-toolbar dense color="white" flat>
      <v-btn v-if="canAccess('candidate.create')" class="mr-3" icon color="primary" @click="$router.push({name: 'candidate-create'})">
        <v-icon>add</v-icon>
      </v-btn>
      <v-text-field
        hide-details
        single-line
      ></v-text-field>
    </v-toolbar>
    <v-flex xs12 class="border-e0-top">
        <data-view
        :name="dataViewName"
        api-url="candidates"
        v-if="dataViewHeight"
        :viewHeight="dataViewHeight"
        :params="params"
        :ref="dataViewName"
        >
        <template slot-scope="{items}">
          <v-list three-line>
            <template  v-for="(item) in items.data">
              <v-list-tile
                :key="'item' + item.id"
                avatar
                @click="candidateDetail(item)"
                :inactive="item.id === $route.params.id"
                :class="item.id === $route.params.id && 'grey lighten-2'"
              >
                  <v-list-tile-content>
                      <v-list-tile-title>name : {{ item.name }}</v-list-tile-title>
                      <v-list-tile-title> {{item.email}} - {{item.phone}} </v-list-tile-title>
                      <v-list-tile-title v-if="item.status ==0">Status : Mới</v-list-tile-title>
                      <v-list-tile-title v-else-if="item.status ==1">Status : Chờ kết quả</v-list-tile-title>
                    <v-list-tile-title v-if="item.status ==2">Status : Trượt</v-list-tile-title>
                      <v-list-tile-title v-if="item.status ==3">Status : Đỗ</v-list-tile-title>
                        <v-list-tile-title v-if="item.status ==4"> Status : Danh sách đen</v-list-tile-title>
                  </v-list-tile-content>
              </v-list-tile>
            </template>
          </v-list>
        </template>
        </data-view>
    </v-flex>
    </v-layout>
 </template>
<script>
import DataView from '@/components/DataView/DataView'
import NoData from '@/components/NoData'
import { mapActions } from 'vuex'
export default{
  name: 'candidateListting',
  components: {
    DataView,
    NoData
  },
  data: () => ({
    dataViewHeight: 0,
    dataViewName: 'candidate',
    params: {
      q: ''
    }
  }),
  methods: {
    ...mapActions('Candidate', ['getCandidate']),
    candidateDetail (candidate) {
      this.getCandidate({ candidateId: candidate.id})
      this.$router.push({ name: 'candidate-detail', params: { id: candidate.id } })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 49
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

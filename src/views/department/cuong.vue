<!--  <template ref="laylout" column fill-height>
  <v-layout ref="laylout" column fill-height>
    <v-toolbar dense color="white" flat>
      <v-btn v-if="canAccess('department.create')" class="mr-3" icon color="primary" @click="$router.push({name: 'department-create'})">
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
        api-url="departments"
        v-if="dataViewHeight"
        :viewHeight="dataViewHeight"
        :params="params"
        :ref="dataViewName"
       >
      <template slot-scope="{items}">
        <v-list three-line>
          <template v-for="(item) in items.data">
              <v-list-tile
                :key="'item' + item.id"
                avatar
                @click="departmentDetail(item)"
                :inactive="item.id === $route.params.id"
                :class="item.id === $route.params.id && 'grey lighten-2'"
              >
               <v-list-tile-content>
                  <v-list-tile-title>{{ item.name }}</v-list-tile-title>
                </v-list-tile-content>

                 <v-list-tile-action>
                  <v-icon v-if="item.status" color="green lighten-1">check</v-icon>
                  <v-icon v-else color="grey lighten-1">lock</v-icon>
                </v-list-tile-action>
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
  name: 'departmentListting',
  components: {
    DataView,
    NoData
  },
  data: () => ({
    dataViewHeight: 0,
    dataViewName: 'department',
    params: {
      q: '',
      include: 'branch'
    }
  }),
  methods: {
    ...mapActions('Department', ['getDepartment']),
    departmentDetail (department) {
      this.getDepartment({ departmentId: department.id, params: { include: 'branch' } })
      this.$router.push({ name: 'department-detail', params: { id: department.id } })
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
 -->

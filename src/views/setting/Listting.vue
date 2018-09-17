<!-- <template>
  <v-layout ref="laylout" column fill-height>
    <v-toolbar dense color="white" flat>
      <v-btn v-if="canAccess('setting.create')" class="mr-3" icon color="primary" @click="$router.push({name: 'setting-create'})">
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
      api-url="settings"
      v-if="dataViewHeight"
      :viewHeight="dataViewHeight"
      :params="params"
      :ref="dataViewName"
      >
      <template slot-scope="{items}">
        <v-list three-line>
          <template v-for="(item, index) in items.data">
            <div style="padding-left:30px" @click="SettingDetail">
            <v-list-tile-title v-if="item.slug=='name'">{{ item.value }}</v-list-tile-title>
            <v-list-tile-sub-title v-if="item.slug==='email'">{{ item.value }}</v-list-tile-sub-title>
            </div>
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
export default {
  name: 'SettingListting',
  components: {
    DataView,
    NoData
  },
  data: () => ({
    dataViewHeight: 0,
    dataViewName: 'setting',
    params: {
      q: ''
    }
  }),
  methods: {
    ...mapActions('Setting',['getSetting']),
    SettingDetail () {
      this.$router.push({ name: 'setting-detail'})
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
<style>
td{
  padding:10px;
}
</style>
 -->

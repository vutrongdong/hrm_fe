  <template>
  <v-layout ref="laylout" column fill-height>
    <v-toolbar dense color="white" flat>
      <v-btn v-if="canAccess('user.create')" class="mr-3" icon color="primary" @click="$router.push({name: 'user-create'})">
        <v-icon>add</v-icon>
      </v-btn>
    </v-toolbar>
    <v-flex xs12 class="border-e0-top">
      <data-view
      :name="dataViewName"
      api-url="users"
      v-if="dataViewHeight"
      :viewHeight="dataViewHeight"
      :params="params"
      :ref="dataViewName"
      >
      <template slot-scope="{items}">
        <v-list three-line>
          <template v-for="(item, index) in items.data">
            <v-list-tile
            :key="'item' + item.id"
            avatar
            @click="userDetail(item)"
            :inactive="item.id === $route.params.id"
            :class="item.id === $route.params.id && 'grey lighten-2'"
            >
            <v-list-tile-avatar>
              <img :src="item.avatar_url">
            </v-list-tile-avatar>
            <v-list-tile-content>
              <v-list-tile-title>{{ item.name }}</v-list-tile-title>
              <v-list-tile-sub-title class="text--primary">{{ item.phone }}</v-list-tile-sub-title>
              <v-list-tile-sub-title>{{ item.email }}</v-list-tile-sub-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-icon v-if="item.status" color="green lighten-1">check</v-icon>
              <v-icon v-else color="grey lighten-1">lock</v-icon>
            </v-list-tile-action>
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
</v-layout>
</template>
<script>
import DataView from '@/components/DataView/DataView'
import NoData from '@/components/NoData'
import { mapActions } from 'vuex'
export default{
  name: 'UserListting',
  components: {
    DataView,
    NoData
  },
  data: () => ({
    dataViewHeight: 0,
    dataViewName: 'user',
    params: {
      q: '',
      include: 'roles'
    }
  }),
  methods: {
    ...mapActions('User', ['getUser']),
    userDetail (user) {
      this.getUser({ userId: user.id, params: { include: 'roles,departments,positions' } })
      this.$router.push({ name: 'user-detail', params: { id: user.id } })
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

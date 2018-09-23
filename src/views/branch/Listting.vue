<template>
  <v-layout ref="laylout" column fill-height>
    <v-flex xs12 class="border-e0-top">
      <data-view
      :name="dataViewName"
      api-url="branches"
      v-if="dataViewHeight"
      :viewHeight="dataViewHeight"
      :params="params"
      :ref="dataViewName"
      >
      <template slot-scope="{items}">
        <v-list subheader style="margin-left:15px">
          <v-toolbar dense color="white" flat>
            <v-spacer></v-spacer>
            <h3>Danh sách chi nhánh</h3>
            <v-spacer></v-spacer>
            <v-btn v-if="canAccess('branch.create')"
            class="mr-5" icon color="primary"
            @click="$router.push({name: 'branch-create'})">
            <v-icon>add</v-icon>
          </v-btn>

        </v-toolbar>
        <v-data-table
        id="dong"
        :items="items.data"
        hide-actions
        expand
        hide-headers
        class="elevation-1"
        >
        <template slot="items" slot-scope="props">
          <th :class='"class"+props.index'>STT</th>
          <th :class='"class"+props.index'>Tên thông tin</th>
          <th :class='"class"+props.index'>Email</th>
          <th :class='"class"+props.index'>Mã số thuế</th>
          <th :class='"class"+props.index'>Địa chỉ</th>
          <tr
          :key="'item' + props.item.id"
          avatar
          @click="branchDetail(props.item)"
          :inactive="props.item.id === $route.params.id"
          :class="props.item.id === $route.params.id && 'grey lighten-2'"
          >
          <td v-if="isIndex">{{ props.index + 1 }}</td>
          <td style="text-transform: capitalize">
            <img  style="margin: 0px 15px 0px 0px" width="35px" v-if="!isIndex" src="http://ytevietmy.com/public/img/icon-company2.png">{{ props.item.name }}
          </td>
          <td v-if="isIndex">{{ props.item.email }}</td>
          <td v-if="isIndex">{{ props.item.tax_number }}</td>
          <td v-if="isIndex">{{ props.item.address }}</td>
        </tr>
      </template>
    </v-data-table>
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
    name: 'BranchListting',
    components: {
      DataView,
      NoData
    },
    props: {
      type: {
        type: String,
        default: 'index'
      }
    },
    data: () => ({
      dataViewHeight: 0,
      dataViewName: 'branch',
      params: {
        q: ''
      }
    }),
    computed: {
      isIndex () {
        return this.type === 'index'
      }
    },
    methods: {
      ...mapActions('Branch', ['getBranchs']),
      branchDetail (branch) {
        this.getBranchs({ branchId: branch.id, params: { include: 'branch' } })
        this.$router.push({ name: 'branch-detail', params: { id: branch.id } })
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
<style scoped>
thead{
  border-top: 1px solid red !important;
}
th{
  display: none;
}
</style>

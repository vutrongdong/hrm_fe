<template>
  <v-layout ref="laylout" column fill-height>
    <v-toolbar dense color="white" flat>
      <v-btn v-if="canAccess('branch.create')" class="mr-3" icon color="primary" @click="$router.push({name: 'branch-create'})">
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
      api-url="branches"
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
            @click="branchDetail(item)"
            :inactive="item.id === $route.params.id"
            :class="item.id === $route.params.id && 'grey lighten-2'"
            >
            <v-list-tile-content>
              <v-list-tile-title>{{ item.name }}</v-list-tile-title>
              <v-list-tile-sub-title>{{ item.email }}-{{ item.phone }}</v-list-tile-sub-title>
            </v-list-tile-content>
            <v-divider
            :key="'div' + index + item.id"
            v-if="index + 1 < items.data.length"
            ></v-divider>
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
export default {
 name: 'BranchListting',
 components:{
  DataView,
  NoData
},
data: () => ({
  dataViewHeight: 0,
  dataViewName: 'branch',
  params: {
    q:''
  }
}),
methods:{
  ...mapActions('branch',['getBranch']),
  branchDetail(branch){
    this.getBranch({ branchId:branch.id})
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
<style>
td{
  padding:10px;
}
</style>

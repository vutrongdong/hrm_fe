<template>
   <v-layout ref="laylout" column fill-height>
    <v-toolbar dense color="white" flat>
      <v-btn v-if="canAccess('position.create')" class="mr-3" icon color="primary" @click="$router.push({name: 'position-create'})">
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
          api-url="positions"
          v-if="dataViewHeight"
          :viewHeight="dataViewHeight"
          :params="params"
          :ref="dataViewName"
        >
          <template slot-scope="{items}">
            <v-list three-line>
              <template v-for="(position, index) in items.data">
                <v-list-tile
                  :key="'position' + position.id"
                  avatar
                  ripple
                  @click="positionDetail(position)"
                  :inactive="position.id === $route.params.id"
                  :class="position.id === $route.params.id && 'grey lighten-2'"
                >
                  <v-list-tile-content>
                    <v-list-tile-title>{{ position.name }}</v-list-tile-title>
                    <v-list-tile-sub-title class="text--primary">{{ position.status }}</v-list-tile-sub-title>
                  </v-list-tile-content>
                </v-list-tile>
                <v-divider
                  :key="'div' + index + position.id"
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
import { mapActions } from 'vuex'
  export default{
     name: 'PositionListting',
  components: {
    DataView
  },
  data: () => ({
    dataViewHeight: 0,
    dataViewName: 'position',
    params: {
      include: 'position',
      q: ''
    }
  }),
  methods: {
    ...mapActions('Position', ['setPosition']),
    positionDetail (position) {
      this.setPosition({ position })
      this.$router.push({name: 'position-detail', params: {id: position.id}})
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 49
    console.log(this.dataViewHeight)
    console.log(this.$refs)
    let query = {...this.$route.query}
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


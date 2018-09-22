<template>
  <v-layout ref="laylout" column fill-height>
    <v-toolbar dense color="white" flat>
      <v-btn v-if="canAccess('plan.create')" class="mr-3" icon color="primary" @click="$router.push({name: 'plan-create'})">
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
          api-url="plans"
          v-if="dataViewHeight"
          :viewHeight="dataViewHeight"
          :params="params"
          :ref="dataViewName"
      >
        <template slot-scope="{items}">
            <v-list three-line>
              <template v-for="(plan, index) in items.data">
                <v-list-tile
                  :key="'plan' + plan.id"
                  avatar
                  ripple
                  @click="planDetail(plan)"
                  :inactive="plan.id === $route.params.id"
                  :class="plan.id === $route.params.id && 'grey lighten-2'"
                >
                <v-list-tile-content>
                    <v-list-tile-title>Title : {{plan.title}}</v-list-tile-title>
                    <v-list-tile-title>Content : {{plan.content}}</v-list-tile-title>
                </v-list-tile-content>
                <v-list-tile-action>
                    <v-icon v-if="plan.status" color="green lighten-1">check</v-icon>
                    <v-icon v-else color="grey lighten-1">lock</v-icon>
                </v-list-tile-action>
                </v-list-tile>
                <v-divider
                :key="'div' + index + plan.id"
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
  name: 'PlanListting',
  components: {
    DataView
  },
  data: () => ({
    dataViewHeight: 0,
    dataViewName: 'plan',
    params: {
      include: 'details',
      q: ''
    }
  }),
  methods: {
    ...mapActions('Plan', ['setPlan', 'getPlan']),
    planDetail (plan) {
      // this.setPlan({ plan })
      this.getPlan({ planId: plan.id, params: { include: 'Details' } })
      this.$router.push({ name: 'plan-detail', params: { id: plan.id } })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 49
    console.log(this.dataViewHeight)
    console.log(this.$refs)
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

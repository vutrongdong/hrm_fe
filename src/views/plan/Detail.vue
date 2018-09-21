<template>
    <v-layout ref="laylout" row fill-height>
     <v-flex xs4>
      <listting></listting>
    </v-flex>
    <v-flex xs8 class="border-e0-left">
      <v-toolbar dense color="white" flat>
           <v-toolbar-title>{{ $t('title.plan.detail') }}: {{planDetail.title}}</v-toolbar-title>
           <v-spacer></v-spacer>
           <v-menu :nudge-width="100" offset-y>
             <v-btn icon slot="activator">
                <v-icon>more_vert</v-icon>
             </v-btn>
              <v-list>
            <v-list-tile
              v-for="item in 10"
              :key="item"
            >
              <v-list-tile-title v-text="item"></v-list-tile-title>
            </v-list-tile>
          </v-list>
           </v-menu>
            <v-btn v-if="canAccess('plan.update')" icon  @click="$router.push({name: 'plan-edit', params: {id: $route.params.id}})">
              <v-icon>edit</v-icon>
            </v-btn>
            <v-btn v-if="canAccess('plan.delete')" icon @click="removeConfirm()">
          <v-icon>delete</v-icon>
        </v-btn>
        <v-btn icon @click="$router.push({name: 'plan'})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-container fluid id="" class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}" >
            <p>Title: {{ planDetail.title }} </p>
            <p>Content: {{planDetail.content}} </p>
            <div>
                status:
                <v-icon v-if="planDetail.status" color="green lighten-1">check</v-icon>
                <v-icon v-else color="grey lighten-1">lock</v-icon>
            </div>
      </v-container>
    </v-flex>
        <dialog-confirm v-model="dialogDelete" @input="remove" />

    </v-layout>
</template>
<script>
import listting from './Listting'
import DialogConfirm from '@/components/DialogConfirm'
import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'PlanDetail',
  components: {
    listting,
    DialogConfirm
  },
  data () {
    return {
      dataViewHeight: 0,
      dialogDelete: false
    }
  },
  computed: {
    ...mapGetters('Plan', ['planDetail'])
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Plan', ['getPlan', 'deletePlan']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    removeConfirm () {
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deletePlan({
          id: this.$route.params.id,
          cb: (response) => {
            this.removeDataviewEntry({
              name: 'plan',
              data: this.planDetail,
              key: 'id'
            })
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.$router.push({ name: 'plan' })
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
  created () {
    this.setMiniDrawer(true)
    if (!this.planDetail.id) {
      this.getPlan({ planId: this.$route.params.id, params: { include: 'details' } })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }
}
</script>

<template>
     <div id="app">
      <v-app id="inspire">
        <div>
           <v-toolbar flat color="white">
               <v-spacer></v-spacer>
               <h3>Danh sách kế hoạch tuyển dụng</h3>
               <v-spacer></v-spacer>
            <router-link v-bind:to="{path: '/plan/create'}">
               <v-btn  class="mr-5" icon color="primary"  v-if="canAccess('plan.create')">
                    <v-icon>add</v-icon>
               </v-btn>
            </router-link>
           </v-toolbar>
            <v-data-table
                v-if="Array.isArray(planDetail)"
                :headers="headers"
                :items="planDetail"
                hide-actions
                expand
                class="elevation-1"
                >
              <template slot="items" slot-scope="props">
                  <td style="text-transform: capitalize">{{ props.item.title }}</td>
                  <td>{{ props.item.content }}</td>
                  <td>{{props.item.status_txt }}</td>
                  <td id="action"><router-link  v-bind:to="{name: 'plan-edit', params: {id: props.item.id}}"> <v-icon v-if="canAccess('candidate.update')" class="mr-6"  color="green"> edit</v-icon></router-link></td>
                  <td id="action"><v-icon v-if="canAccess('plan.delete')" icon @click="removeConfirm(props.item.id)" color="red"> delete </v-icon></td>
            </template>
            </v-data-table>
              <dialog-confirm v-model="dialogDelete" @input="remove" />
        </div>
      </v-app>
    </div>
</template>
<script type="text/javascript">
import DialogConfirm from '@/components/DialogConfirm'
import { mapActions, mapGetters } from 'vuex'
export default{
  components: {
    DialogConfirm
  },
  data: () => ({
    idPlan: null,
    dialogDelete: false,
    dialog: false,
    headers: [
      { text: 'Tên kế hoạch', sortable: false },
      { text: 'Nội dung', sortable: false },
      { text: 'Trạng thái', sortable: false },
      { text: 'Sửa', sortable: false },
      { text: 'Xóa', sortable: false }
    ]
  }),
  computed: {
    ...mapGetters('Plan', ['planDetail']),
    ...mapGetters(['isFetchingApi'])
  },
  created () {
    this.fetchPlan()
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Plan', ['fetchPlan', 'deletePlan']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    removeConfirm (id) {
      this.idPlan = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deletePlan({
          id: this.idCandidate,
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
  }
}
</script>


<template>
     <div id="app">
      <v-app id="inspire">
        <div>
           <v-toolbar flat color="white">
               <v-spacer></v-spacer>
               <h3>Danh sách kế hoạch tuyển dụng</h3>
               <v-spacer></v-spacer>
               <v-btn  class="mr-5" @click="$router.push({name: 'plan-create'})"
               icon color="primary"  v-if="canAccess('plan.create')">
                    <v-icon>add</v-icon>
               </v-btn>
           </v-toolbar>
           <v-container>
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
                  <td> {{props.item.date_start}} </td>
                  <td> {{props.item.date_end}} </td>
                  <td>{{props.item.status_txt }}</td>
                  <td id="action">
                   <v-icon style="margin-right: 15px" v-if="canAccess('candidate.update')" class="mr-6"
                         @click="$router.push({name: 'plan-edit', params: {id: props.item.id}})"
                     color="green"> edit</v-icon>

                <v-icon v-if="canAccess('plan.delete')"
                 icon @click="removeConfirm(props.item.id)"
                 color="red"> delete </v-icon>
                  </td>
            </template>
            </v-data-table>
            </v-container>
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
      { text: 'Ngày bắt đầu', sortable: false},
      {text: 'Ngày kết thúc', sortable: false},
      { text: 'Trạng thái', sortable: false },
      { text: 'Hành động', sortable: false }
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

<template>
  <!--    <div id="app">
      <v-app id="inspire">
   -->      <div>
           <v-toolbar flat color="white">
               <v-spacer></v-spacer>
               <h3>Danh sách ứng cử viên</h3>
               <v-spacer></v-spacer>
               <v-btn class="mr-5" icon
                  @click="$router.push({name: 'candidate-create'})"
               color="primary" v-if="canAccess('candidate.create')">
                    <v-icon>add</v-icon>
               </v-btn>
           </v-toolbar>
               <v-container>
                <v-data-table
                    v-if="Array.isArray(candidateDetail)"
                    :headers="headers"
                    :items="candidateDetail"
                    hide-actions
                    expand
                    class="elevation-1"
                >
                  <template slot="items" slot-scope="props">
                      <td style="text-transform: capitalize">{{ props.item.name }}</td>
                      <td>{{ props.item.email }}</td>
                      <td>{{props.item.phone}}</td>
                      <td v-for="(plan, index) in planDetail" v-if="plan.id == props.item.plan_id" :key='index'> {{plan.title}} </td>
                      <td v-for="(position, index) in positionDetail" v-if="position.id == props.item.position_id" :key='index'> {{position.name}} </td>
                      <td id="action">
                      <v-icon v-if="canAccess('candidate.update')"  class="mr-6"
                        @click="$router.push({name: 'candidate-edit', params: {id: props.item.id}})"
                       style="margin-right:15px;" color="green">
                       edit
                      </v-icon>
                      <v-icon v-if="canAccess('candidate.delete')"
                      icon @click="removeConfirm(props.item.id)" color="red">
                      delete
                      </v-icon>
                      <v-icon v-if="canAccess('candidate.view')" class="mr-6" @click="editItem(props.item,props.item.id)" color="green">view</v-icon>
                      </td>
                </template>
                </v-data-table>
              </v-container>
              <dialog-confirm v-model="dialogDelete" @input="remove" />
        </div>
  <!--     </v-app>
    </div> -->
</template>
<script type="text/javascript">
import DialogConfirm from '@/components/DialogConfirm'
import { mapActions, mapGetters } from 'vuex'
export default{
  components: {
    DialogConfirm
  },
  data: () => ({
    idCandidate: null,
    dialogDelete: false,
    dialog: false,
    headers: [
      { text: 'Tên ứng viên', sortable: false },
      { text: 'Email', sortable: false },
      { text: 'Số điện thoại', sortable: false },
      { text: 'Kế hoạch', sortable: false },
      { text: 'Chức danh', sortable: false },
      { text: 'Hành động', sortable: false }
    ]
  }),
  computed: {
    ...mapGetters('Candidate', ['candidateDetail']),
    ...mapGetters(['isFetchingApi']),
    ...mapGetters('Position', ['positionDetail']),
    ...mapGetters('Plan', ['planDetail'])
  },
  created () {
    this.fetchCandidate()
    this.fetchPosition()
    this.fetchPlan()
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Candidate', ['fetchCandidate', 'deleteCandidate']),
    ...mapActions('Plan', ['fetchPlan']),
    ...mapActions('Position', ['fetchPosition']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    removeConfirm (id) {
      this.idCandidate = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteCandidate({
          id: this.idCandidate,
          cb: (response) => {
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.fetchCandidate()
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

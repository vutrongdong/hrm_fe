<template>
  <!--    <div id="app">
      <v-app id="inspire">
   -->      <div>
           <v-toolbar flat color="white">
               <v-spacer></v-spacer>
               <h3>Danh sách ứng cử viên</h3>
               <v-spacer></v-spacer>
            <router-link v-bind:to="{path: '/candidate/create'}">
               <v-btn class="mr-5" icon color="primary" v-if="canAccess('candidate.create')">
                    <v-icon>add</v-icon>
               </v-btn>
            </router-link>
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
                      <td id="action">
                      <router-link  v-bind:to="{name: 'candidate-edit', params: {id: props.item.id}}">
                      <v-icon v-if="canAccess('candidate.update')" class="mr-6" style="margin-right:15px;" color="green">
                       edit
                      </v-icon>
                      </router-link>
                      <v-icon v-if="canAccess('candidate.delete')" icon @click="removeConfirm(props.item.id)" color="red">
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
      { text: 'Hành động', sortable: false }
    ]
  }),
  computed: {
    ...mapGetters('Candidate', ['candidateDetail']),
    ...mapGetters(['isFetchingApi'])
  },
  created () {
    this.fetchCandidate()
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Candidate', ['fetchCandidate', 'deleteCandidate']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    removeConfirm (id) {
      this.idPosition = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteCandidate({
          id: this.idCandidate,
          cb: (response) => {
            this.removeDataviewEntry({
              name: 'candidate',
              data: this.candidateDetail,
              key: 'id'
            })
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.$router.push({ name: 'candidate' })
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

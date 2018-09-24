<template>
     <div id="app">
      <v-app id="inspire">
        <div>
           <v-toolbar flat color="white">
               <v-spacer></v-spacer>
               <h3>Danh sách ứng cử viên</h3>
               <v-spacer></v-spacer>
            <router-link v-bind:to="{path: '/candidate/create'}">
               <v-btn  class="mr-5" icon color="primary"  v-if="canAccess('candidate.create')">
                    <v-icon>add</v-icon>
               </v-btn>
            </router-link>
           </v-toolbar>
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
                  <td id="action"><router-link  v-bind:to="{name: 'candidate-edit', params: {id: props.item.id}}"> <v-icon v-if="canAccess('candidate.update')" class="mr-6"  color="green"> edit</v-icon></router-link></td>
                  <td id="action"><v-icon v-if="canAccess('candidate.delete')" icon @click="removeConfirm(props.item.id)" color="red"> delete </v-icon></td>
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
    idCandidate: null,
    dialogDelete: false,
    dialog: false,
    headers: [
      { text: 'Tên ứng viên', sortable: false },
      { text: 'Email', sortable: false },
      { text: 'Số điện thoại', sortable: false },
      { text: 'Sửa', sortable: false },
      { text: 'Xóa', sortable: false }
    ],
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
    ...mapActions('Candidate', ['fetchCandidate','deleteCandidate']),
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
    },
  }
}
</script>
<style scope>
p span{
  padding: 7px;
  margin-top:-25px;
  float: right;
  margin-right:10px;
}
h3{
  clear:both;
}
tr td{
  padding-left:70px !important;
}
tr th{
  padding-left:70px !important;
  font-size: 16px !important;
  color: black !important;
}
</style>

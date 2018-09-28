<template>
  <div id="app">
      <v-app id="inspire">
        <div>
          <v-toolbar flat color="white">
               <v-spacer></v-spacer>
               <h3>Danh sách hợp đồng</h3>
               <v-spacer></v-spacer>
               <v-btn class="mr-5" icon color="primary"
               @click="$router.push({name: 'contract-create'})"
                v-if="canAccess('contract.create')">
                    <v-icon>add</v-icon>
               </v-btn>
          </v-toolbar>
              <v-container>
                <v-data-table
                   v-if="Array.isArray(contractDetail)"
                    :headers="headers"
                    :items="contractDetail"
                    hide-actions
                    expand
                    class="elevation-1"
                >
               <template slot="items" slot-scope="props">
                  <td>{{ props.index + 1 }}</td>
                  <td style="width: 200px"> {{props.item.title}} </td>
                  <td> {{props.item.type_txt}} </td>
                  <td> {{ props.item.status_txt }} </td>
                  <td> {{props.item.user_name}} </td>
                  <td> {{props.item.date_sign}} </td>
                  <td> {{props.item.date_expiration}} </td>
                  <td id="action">
                      <v-icon
                      v-if="canAccess('contract.update')"
                      @click="$router.push({name: 'contract-edit', params: {id: props.item.id}})"
                      class="mr-6" style="margin-right:15px;" color="green">
                       edit
                      </v-icon>

                      <v-icon v-if="canAccess('contract.delete')"
                       icon @click="removeConfirm(props.item.id)" color="red">
                      delete
                      </v-icon>
                  </td>
               </template>
              </v-data-table>
              </v-container>

        </div>
          <dialog-confirm v-model="dialogDelete" @input="remove" />
      </v-app>
    </div>
</template>
<script>
import DialogConfirm from '@/components/DialogConfirm'
import { mapActions, mapGetters } from 'vuex'
export default{
  components: {
    DialogConfirm
  },
  data: () => ({
    idContract: null,
    dialogDelete: false,
    dialog: false,
    headers: [
      { text: 'STT', sortable: false },
      { text: 'Tiêu đề', sortable: false },
      { text: 'Loại hợp đồng', sortable: false },
      { text: 'Trạng thái', sortable: false },
      { text: 'Tên nhân viên', sortable: false },
      { text: 'Ngày ký hợp đồng', sortable: false },
      { text: 'Ngày hết hạn hợp đồng', sortable: false},
      { text: 'Hành động', sortable: false }
    ]
  }),
  computed: {
    ...mapGetters('Contracts', ['contractDetail']),
    ...mapGetters(['isFetchingApi'])
  },
  created () {
    this.fetchContract()
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Contracts', ['fetchContract', 'deleteContract']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    removeConfirm (id) {
      this.idContract = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteContract({
          id: this.idContract,
          cb: (response) => {
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.fetchContract()
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

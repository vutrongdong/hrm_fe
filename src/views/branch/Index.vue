<template>
  <v-layout ref="laylout" column fill-height>
    <v-toolbar dense color="white" flat>
      <v-spacer></v-spacer>
      <h3>Danh sách chi nhánh</h3>
      <v-spacer></v-spacer>
      <v-btn v-if="canAccess('branch.create')"
      class="mr-5" icon color="primary"
      @click="$router.push({name: 'branch-create'})">
      <v-icon>add</v-icon>
    </v-btn>
  </v-toolbar>
  <v-flex xs12 class="border-e0-top">
    <v-container>
     <v-data-table
     v-if="Array.isArray(branchAll)"
     :items="branchAll"
     hide-actions
     expand
     :headers="title"
     class="elevation-1"
     >
     <template slot="items" slot-scope="props">
      <tr>
        <td style="text-transform: capitalize">{{ props.item.name }} </td>
        <td style="text-transform: capitalize">{{ props.item.email }}</td>
        <td style="text-transform: capitalize">{{ props.item.tax_number }}</td>
        <td style="text-transform: capitalize">{{ props.item.address }}</td>
        <td style="text-transform: capitalize">{{ props.item.status_txt }}</td>
        <td id="action">
         <v-icon v-if="canAccess('branch.update')" class="mr-6" @click="$router.push({name: 'branch-edit', params: {id: props.item.id}})" color="green"> edit</v-icon>
         <v-icon style="margin-left:10px" v-if="canAccess('branch.delete')" icon @click="removeConfirm(props.item.id)" color="red"> delete </v-icon>
       </td>
     </tr>
   </template>
 </v-data-table>
 <dialog-confirm v-model="dialogDelete" @input="remove()" />
</v-container>
</v-flex>
</v-layout>
</template>
<script>
import DialogConfirm from '@/components/DialogConfirm'
import { mapActions, mapGetters } from 'vuex'
export default {
  components: {
    DialogConfirm
  },
  data: () => ({
    idBranch: null,
    dialogDelete: false,
    title: [
      { text: 'Tên chi nhánh', sortable: false },
      { text: 'Email', sortable: false },
      { text: 'Mã sô thuế', sortable: false },
      { text: 'Địa chỉ', sortable: false },
      { text: 'Trạng thái', sortable: false },
      { text: 'Hành động', sortable: false }
    ]
  }),
  computed: {
    ...mapGetters('Branch', ['branchAll'])
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Branch', ['getBranch', 'deleteBranch']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    removeConfirm (id) {
      this.idBranch = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteBranch({
          id: this.idBranch,
          cb: (response) => {
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.getBranch()
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
    this.getBranch()
  }
}
</script>

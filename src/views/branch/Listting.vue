<template>
  <v-layout ref="laylout" column fill-height>
    <v-flex xs12 class="border-e0-top">
      <data-view
      :name="dataViewName"
      api-url="branches"
      v-if="dataViewHeight"
      :viewHeight="dataViewHeight"
      :params="params"
      :ref="dataViewName"
      >
      <template slot-scope="{items}">
        <v-list subheader style="margin-left:15px">
          <v-toolbar dense color="white" flat>
            <v-spacer></v-spacer>
            <h3>Danh sách chi nhánh</h3>
            <v-btn v-if="canAccess('branch.create')"
            class="mr-0" icon color="primary"
            @click="$router.push({name: 'branch-create'})">
            <v-icon>add</v-icon>
          </v-btn>
          <v-spacer></v-spacer>

        </v-toolbar>
        <v-data-table
        :items="items.data"
        hide-actions
        expand
        :headers="title"
        class="elevation-1"
        >
        <template slot="items" slot-scope="props">
          <tr>
            <td style="text-transform: capitalize">{{ props.item.name }}
            </td>
            <td style="text-transform: capitalize">{{ props.item.email }}</td>
            <td style="text-transform: capitalize">{{ props.item.tax_number }}</td>
            <td style="text-transform: capitalize">{{ props.item.address }}</td>
            <td style="text-transform: capitalize">{{ props.item.status_txt }}</td>
            {{branchDetail}}
            <td id="action">
             <v-icon v-if="canAccess('branch.update')" class="mr-6" @click="$router.push({name: 'branch-edit', params: {id: props.item.id}})" color="green"> edit</v-icon>
             <v-icon style="margin-left:10px" v-if="canAccess('branch.delete')" icon @click="removeConfirm(props.item.id)" color="red"> delete </v-icon>
           </td>
         </tr>
       </template>
     </v-data-table>
     <dialog-confirm v-model="dialogDelete" @input="remove()" />
   </v-list>
 </template>
</data-view>
</v-flex>
</v-layout>
</template>
<script>
import DialogConfirm from '@/components/DialogConfirm'
import DataView from '@/components/DataView/DataView'
import NoData from '@/components/NoData'
import { mapActions } from 'vuex'
export default {
  name: 'BranchListting',
  components: {
    DataView,
    NoData,
    DialogConfirm
  },
  props: {
    type: {
      type: String,
      default: 'index'
    }
  },
  data: () => ({
    dialogDelete: false,
    idBranch: null,
    title: [
      { text: 'Tên chi nhánh', sortable: false },
      { text: 'Email', sortable: false },
      { text: 'Mã sô thuế', sortable: false },
      { text: 'Địa chỉ', sortable: false },
      { text: 'Trạng thái', sortable: false },
      { text: 'Hành động', sortable: false }
    ],
    dataViewHeight: 0,
    dataViewName: 'branch',
    params: {
      q: ''
    }
  }),
  computed: {
    isIndex () {
      return this.type === 'index'
    }
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Branch', ['getBranchs', 'deleteBranch']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    branchDetail (branch) {
      this.getBranchs({ branchId: branch.id, params: { include: 'branch' } })
      this.$router.push({ name: 'branch-detail', params: { id: branch.id } })
    },
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
            this.FetchSetting()
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
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 49
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
<style scoped>
thead{
  border-top: 1px solid red !important;
}
th{
  display: none;
}
</style>

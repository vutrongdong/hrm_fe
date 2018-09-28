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
<!--      <v-data-table
     v-if="Array.isArray(branchAll)"
     :items="branchAll"
     hide-actions
     expand
     :headers="title"
     class="elevation-1"
     > -->
     <DataView
     :name="dataViewName"
     api-url="branches"
     v-if="dataViewHeight"
     :viewHeight="dataViewHeight"
     :params="params"
     :ref="dataViewName"
     >
     <template slot="items" slot-scope="props">
      <tr>
        <td style="text-transform: capitalize">{{ props.item.name }} </td>
        <td style="text-transform: capitalize">{{ props.item.email }}</td>
        <td style="text-transform: capitalize">{{ props.item.tax_number }}</td>
        <td style="text-transform: capitalize">{{ props.item.address }}</td>
        <td style="text-transform: capitalize">{{ props.item.status_txt }}</td>
        <td id="action">
          <v-icon style="margin-right:15px" v-if="canAccess('branch.view')" class="mr-6" @click="detailConfirm(props.item.id)" color="green">far fa-eye</v-icon>
          <v-icon v-if="canAccess('branch.update')" class="mr-6" @click="$router.push({name: 'branch-edit', params: {id: props.item.id}})" color="green"> edit</v-icon>
          <v-icon style="margin-left:10px" v-if="canAccess('branch.delete')" icon @click="removeConfirm(props.item.id)" color="red"> delete </v-icon>
        </td>
      </tr>
    </template>
  </DataView>
  <!--   </v-data-table> -->
  <v-dialog v-model="dialogDetail" width="700">
    <v-card>
      <v-card-title class="headline grey lighten-2" primary-title >
        <p style="width:100%;text-transform:uppercase"  class="text-md-center">{{ branchDetail.name }}</p>
      </v-card-title>
      <!-- content -->
      <v-card-text id="detailBranch">
        <v-container>
          <v-layout row>
            <v-flex sm5>
              <img style="border:1px solid gray" width="100%" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkzg43WKhLRqXMgK81QQilVmHO0qcC2pu424_k5cAUV0TasgY3-Q" alt="">
            </v-flex>
            <v-flex sm7 id="info-branch" style="padding-left:10px;">
              <p> - Tên : {{ branchDetail.name }}</p>
              <p v-if="branchDetail.address"> - Địa chỉ : {{ branchDetail.address }}</p>
              <p v-if="branchDetail.phone"> - Số điện thoại : {{ branchDetail.phone }}</p>
              <p v-if="branchDetail.tax_number"> - Mã số thuế : {{ branchDetail.tax_number }}</p>
              <p v-if="branchDetail.website"> - Website : {{ branchDetail.website }}</p>
              <p v-if="branchDetail.email"> - Email : {{ branchDetail.email }}</p>
              <p v-if="branchDetail.facebook"> - Facebook : {{ branchDetail.facebook }}</p>
              <p v-if="branchDetail.instagram"> - Instagram : {{ branchDetail.instagram }}</p>
              <p v-if="branchDetail.zalo"> - Zalo : {{ branchDetail.zalo }}</p>
              <p v-if="branchDetail.description"> - Mô tả : {{ branchDetail.description }}</p>
              <p v-if="branchDetail.about"> - Thông tin : {{ branchDetail.about }}</p>
              <p v-if="branchDetail.bank"> - Tài khoản ngân hàng : {{ branchDetail.bank }}</p>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card-text>
      <!-- end content -->
      <v-divider></v-divider>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="primary" flat @click="dialogDetail = false">
          <v-icon>close</v-icon>
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
  <dialog-confirm v-model="dialogDelete" @input="remove" />
</v-container>
</v-flex>
</v-layout>
</template>
<script>
import DataView from '@/components/DataView/DataView'
import DialogConfirm from '@/components/DialogConfirm'
import { mapActions, mapGetters } from 'vuex'
export default {
  components: {
    DataView,
    DialogConfirm
  },
  data: () => ({
    dataViewHeight: 0,
    dataViewName: 'branch',
    params: {
      q: '',
      include: ''
    },
    idBranch: null,
    dialogDetail: false,
    dialogDelete: false,
    title: [
    { text: 'Tên chi nhánh', sortable: false },
    { text: 'Email', sortable: false },
    { text: 'Mã sô thuế', sortable: false },
    { text: 'Địa chỉ', sortable: false },
    { text: 'Trạng thái', sortable: false },
    { text: 'Các hành động', sortable: false }
    ]
  }),
  computed: {
    ...mapGetters('Branch', ['branchAll', 'branchDetail'])
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Branch', ['getBranchs', 'getBranch', 'deleteBranch']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    detailConfirm (id) {
      this.dialogDetail = true
      this.getBranch({
        branchId: id,
        params: { include: '' }
      })
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
            this.getBranchs()
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
    this.getBranchs()
  },
  mounted(){
    this.dataViewHeight = this.$refs.laylout.clientHeight - 49
    let query = {...this.$route.query}
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
#detailBranch .container .layout #info-branch p{
  margin-bottom: 0rem;
}
</style>

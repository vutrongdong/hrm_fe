<template>
     <div id="app">
      <v-app id="inspire">
        <div>
           <v-toolbar flat color="white">
               <v-spacer></v-spacer>
               <h3>Danh sách bộ phận trong công ty</h3>
               <v-spacer></v-spacer>
               <v-dialog v-model="dialog" max-width="500px">
                  <v-btn slot="activator" class="mr-5" icon color="primary" v-if="canAccess('department.create')">
                    <v-icon>add</v-icon>
                  </v-btn>
                   <v-card>
                      <v-card-title>
                        <span class="headline">{{ formTitle }}</span>
                      </v-card-title>
                        <v-card-text id="formSub">
                <v-container grid-list-md>
                  <v-layout wrap>
                    <!-- name -->
                    <v-flex xs12 sm6 md12>
                      <v-text-field
                      placeholder="nhập tên"
                      :error-messages="errors.has('name') ? errors.collect('name') : []"
                      v-validate="'required'"
                      :data-vv-as="$t('label.name')"
                      name="name"
                      :label="$t('label.name') + '*'"
                      v-model="department.name"> </v-text-field>
                    </v-flex>
                    <!-- value -->
                    <!-- status -->
                    <v-flex xs12 sm6 md12>
                        <label style="margin-top:10px">Trạng Thái</label>
                        <v-flex row>
                          <v-checkbox
                          @change="status_txt"
                          :label="status"
                          class="checkbox"
                          style="margin-left:20px;margin-top:0px"
                          name="status"
                          v-model="department.status">
                        </v-checkbox>
                            </v-flex>
                      </v-flex>
                   <!-- branch_id -->
                    <v-flex xs12 sm6 md12>
                       <v-select v-validate="'required'"
                      :error-messages="errors.has('branch_id') ? errors.collect('branch_id') : []"
                      :data-vv-as="$t('label.branch_id')"
                      name="branch_id"
                      v-model="department.branch_id"
                       :label="$t('label.branch_id')"
                       :items="branchAll"
                       v-if="Array.isArray(branchAll)"
                       item-value="id"
                       item-text="name"
                       placeholder="Xin vui lòng nhập vào chi nhánh "
                 >
                     </v-select>
                  </v-flex>
                </v-layout>
              </v-container>
            </v-card-text>
               <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" flat @click.native="close">Hủy bỏ</v-btn>
              <v-btn color="blue darken-1" flat @click.native="submitForm"><span v-if="editedIndex!==-1">Lưu lại</span><span v-else>Thêm mới</span></v-btn>
            </v-card-actions>
                   </v-card>
               </v-dialog>

           </v-toolbar>
              <v-container>
                  <v-data-table
                    v-if="Array.isArray(departmentDetail)"
                    :headers="headers"
                    :items="departmentDetail"
                    hide-actions
                    expand
                    class="elevation-1"
                    >
                  <template slot="items" slot-scope="props">
                      <td> {{props.index + 1}} </td>
                      <td style="text-transform: capitalize">{{ props.item.name }}</td>
                      <td>{{ props.item.status_txt }}</td>
                      <td v-for="(branch , index) in branchAll" :key='index' v-if="branch.id === props.item.branch_id"> {{branch.name}} </td>
                      <td id="action">
                      <v-icon v-if="canAccess('department.update')" class="mr-6" @click="editItem(props.item,props.item.id)" color="green"> edit</v-icon>
                      <v-icon v-if="canAccess('department.delete')" icon @click="removeConfirm(props.item.id)" color="red"> delete </v-icon>
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
    idDepartment: null,
    dialogDelete: false,
    status: 'Hiển thị',
    dialog: false,
    headers: [
      { text: 'STT', sortable: false },
      { text: 'Tên bộ phận', sortable: false },
      { text: 'Trạng thái', sortable: false },
      { text: 'Tên chi nhánh', sortable: false },
      { text: 'Action', sortable: false }
    ],
    editedIndex: -1,
    department: {
      name: '',
      status:0,
      branch_id: ''
    },
    defaultItem: {
      status: 0
    }
  }),
  computed: {
    ...mapGetters('Branch', ['branchAll']),
    formTitle () {
      return this.editedIndex === -1 ? 'Thêm bộ phận' : 'Sửa bộ phận'
    },
    ...mapGetters('Department', ['departmentDetail']),
    ...mapGetters(['isFetchingApi'])
  },
  watch: {
    dialog (val) {
      val || this.close()
    }
  },
  created () {
    this.fetchDepartment()
    this.getBranchs()
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Department', ['fetchDepartment', 'deleteDepartment', 'updateDepartment']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Department', ['createDepartment']),
    ...mapActions('Branch', ['getBranchs']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    editItem (item, id) {
      this.idDepartment = id
      this.editedIndex = this.departmentDetail.indexOf(item)
      this.department = Object.assign({}, item)
      this.dialog = true
    },
    removeConfirm (id) {
      this.idDepartment = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteDepartment({
          id: this.idDepartment,
          cb: (response) => {
            this.removeDataviewEntry({
              name: 'position',
              data: this.departmentDetail,
              key: 'id'
            })
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.fetchDepartment()
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
    status_txt () {
      if (this.department.status) {
        this.status = 'Hiển thị'
      } else {
        this.status = 'Không hiển thị'
      }
    },
    close () {
      this.dialog = false
      setTimeout(() => {
        this.department = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      }, 300)
    },
    submitForm () {
      if (this.editedIndex === -1) {
        this.createDepartment({
          department: this.department,
          cb: (response) => {
            this.dialog = false
            setTimeout(() => {
              this.department = Object.assign({}, this.defaultItem)
              this.editedIndex = -1
            }, 300)
            this.showNotify({
              color: 'success',
              text: 'Thành công'
            })
            this.fetchDepartment()
          }
        })
      } else {
        this.updateDepartment({
          id: this.idDepartment,
          department: this.department,
          cb: (response) => {
            this.fetchDepartment()
            this.showNotify({
              color: 'success',
              text: 'Thành công'
            })
            this.dialog = false
            setTimeout(() => {
              this.position = Object.assign({}, this.defaultItem)
              this.editedIndex = -1
            }, 300)
          }
        })
      }
    }
  }
}
</script>
<style>
</style>

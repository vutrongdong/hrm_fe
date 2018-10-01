<template>
  <v-layout ref="laylout" column fill-height>
    <div ref="header">
      <v-toolbar height="60px" color="white" flat>
        <v-layout row wrap>
          <v-flex md1 xs3 :class="isMini">
            <!--  <v-tooltip bottom> -->
            <v-tooltip bottom>
              <v-btn slot="activator" v-if="canAccess('department.create')"
              class="mr-3 mt-3" icon color="primary"
              @click="openDialog">
              <v-icon>add</v-icon
                ></v-btn>
                <span>Thêm mới</span>
              </v-tooltip>
              <!--  <span>Thêm mới</span> -->
              <!-- </v-tooltip> -->
            </v-flex>
            <v-flex xs5 class="mt-1 mr-2" :class="isMini && 'full-flex-basic'">
              <v-text-field
              hide-details
              single-line
              placeholder="Nhập tên phòng ban"
              v-model="params.q"
              @keyup="changeSearch"
              clearable
              ></v-text-field>
            </v-flex>
            <v-flex xs5 class='mt-1' :class="isMini && 'd-none'">
              <v-autocomplete
              v-if="Array.isArray(branchAll)"
              :items="branchAll"
              item-value="id"
              item-text="name"
              v-model="params.branch_id"
              @change="filter"
              placeholder="Xin vui lòng nhập tên chi nhánh"
              >
            </v-autocomplete>
          </v-flex>

          <!--dialog-->
          <v-dialog v-model="dialog" max-width="500px">
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
                    <label>Trạng thái</label>
                    <v-checkbox
                    @change="status_txt"
                    :label="status"
                    class="checkbox"
                    style="margin-top:0px"
                    name="status"
                    v-model="department.status">
                  </v-checkbox>
                </v-flex>
                <!--branch_id-->
                <v-flex xs12>
                  <label>Tên chi nhánh</label>
                  <v-autocomplete
                  v-if="Array.isArray(branchAll)"
                  :items="branchAll"
                  item-value="id"
                  item-text="name"
                  v-model="department.branch_id"
                  placeholder="Xin vui lòng nhập tên chi nhánh"
                  >
                </v-autocomplete>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" flat @click.native="close">Hủy bỏ</v-btn>
          <v-btn color="blue darken-1" flat @click.native="submitForm">
            <span v-if="editTitle==-2">Lưu lại</span><span v-else>Thêm mới</span></v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-layout>
    <v-layout slot="extension" v-if="!isMini">
      <v-flex sm2 class="text-bold text-uppercase">
        STT
      </v-flex>
      <v-flex sm3 class="text-bold text-uppercase">
        tên phòng ban
      </v-flex>
      <v-flex sm3 class="text-bold text-uppercase">
        tên chi nhánh
      </v-flex>
      <v-flex sm2 class="text-bold text-uppercase">
        trạng thái
      </v-flex>
      <v-flex sm2 class="text-bold text-uppercase">
        hành động
      </v-flex>
    </v-layout>
  </v-toolbar>
</div>
<v-flex xs12 class="border-e0-top">
  <data-view
  :name="dataViewName"
  api-url="departments"
  v-if="dataViewHeight"
  :viewHeight="dataViewHeight"
  :params="params"
  :ref="dataViewName"
  >
  <template slot-scope="{items}">
    <v-list>
      <template v-for="(item, index) in items.data">
       <v-layout class="pa-2" :key="index">
        <v-flex sm2 class="ml-3" sm1 :class="isMini && 'd-none'">
          {{ index + 1 }}
        </v-flex>
        <v-flex sm3 :class="isMini && 'd-none'">
          {{ item.name }}
        </v-flex>
        <v-flex class="mr-1" sm3 :class="isMini && 'd-none'">
          {{ item.branch_name }}
        </v-flex>
        <v-flex sm2 :class="isMini && 'd-none'">
          {{ item.status_txt }}
        </v-flex>
        <v-flex sm2 :class="isMini && 'd-none'">
          <v-tooltip bottom>
            <v-btn slot="activator" class="ma-0" v-if="canAccess('department.update')" icon @click="editItem(item,item.id)">
              <v-icon class='theme--light teal--text'>edit</v-icon>
            </v-btn>
            <span>Sửa</span>
          </v-tooltip>
          <v-tooltip bottom>
            <v-btn slot="activator" class="ma-0" v-if="canAccess('department.delete')" icon @click.stop="removeConfirm(item.id)">
              <v-icon class="theme--light pink--text">delete</v-icon>
            </v-btn>
            <span>Xóa</span>
          </v-tooltip>
        </v-flex>
      </v-layout>
      <v-divider
      :key="'div' + index + item.id"
      v-if="index + 1 < items.data.length"
      ></v-divider>
    </template>
  </v-list>
</template>
</data-view>
</v-flex>
<dialog-confirm v-model="dialogDelete" @input="remove" />
</v-layout>
</template>
<script>
import DialogConfirm from '@/components/DialogConfirm'
import { debounce } from 'lodash'
import DataView from '@/components/DataView/DataView'
import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'UserListting',
  props: {
    isMini: {
      type: Boolean,
      default: false
    }
  },
  components: {
    DataView,
    DialogConfirm
  },
  data: () => ({
    dataViewHeight: 0,
    dataViewName: 'department',
    idDepartment: null,
    dialogDelete: false,
    dialog: false,
    editedIndex: -1,
    editTitle: -1,
    status: 'Không hiển thị',
    department: {
      name: '',
      status: 0,
      branch_id: ''
    },
    params: {
      q: '',
      branch_id: ''
    },
    defaultItem: {
    }
  }),
  computed: {
    formTitle () {
      return this.editTitle === -1 ? 'Thêm phòng ban' : 'Sửa phòng ban'
    },
    ...mapGetters('Branch', ['branchAll']),
    ...mapGetters('Department', ['departmentDetail']),
    ...mapGetters(['isFetchingApi'])
  },
  watch: {
    dialog (val) {
      val || this.close()
    }
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Department', ['fetchDepartment', 'createDepartment', 'deleteDepartment', 'updateDepartment']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    ...mapActions('Branch', ['getBranchs']),
    /// status
    status_txt () {
      if (this.department.status) {
        this.status = 'Hiển thị'
      } else {
        this.status = 'Không hiển thị'
      }
    },
    // dialog
    openDialog () {
      this.editTitle = -1
      this.dialog = true
    },
    // end dialog
    close () {
      this.dialog = false
      setTimeout(() => {
        this.department = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      }, 300)
    },
    // đổ dữ liệu from edit
    editItem (item, id) {
      this.editTitle = -2
      this.idDepartment = id
      this.editedIndex = this.departmentDetail.indexOf(item)
      this.department = Object.assign({}, item)
      this.dialog = true
    },
    submitForm () {
      if (this.editedIndex === -1) {
        let department = Object.assign({}, this.department)
        department.status = department.status ? 1 : 0
        this.createDepartment({
          department: department,
          cb: (response) => {
            this.dialog = false
            setTimeout(() => {
              console.log('data department :', department)
              this.editedIndex = -1
            }, 300)
            this.showNotify({
              color: 'success',
              text: 'Thành công'
            })
            this.filter()
          }
        })
      } else {
        let department = Object.assign({}, this.department)
        department.status = department.status ? 1 : 0
        this.updateDepartment({
          id: this.idDepartment,
          department: department,
          cb: (response) => {
            this.fetchDepartment()
            this.showNotify({
              color: 'success',
              text: 'Thành công'
            })
            this.dialog = false
            setTimeout(() => {
              console.log('data department :', department)
              this.editedIndex = -1
            }, 300)
            this.filter()
          }
        })
      }
    },
    /// screach
    changeSearch: debounce(function () {
      this.filter()
    }, 500),
    filter () {
      this.$refs[this.dataViewName].$emit('reload')
    },
    // xóa department
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
              name: 'department',
              data: this.departmentDetail,
              key: 'id'
            })
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.filter()
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
    this.dataViewHeight = this.$refs.laylout.clientHeight - 168
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
  },
  created () {
    this.getBranchs()
    this.fetchDepartment()
  }
}
</script>
<style scoped>
  .v-toolbar__extension{
    height: 66px !important;
  }
  .v-input.v-text-field{
    margin-top: 0px !important;
  }
</style>

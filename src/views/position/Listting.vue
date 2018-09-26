<template>
     <div id="app">
      <v-app id="inspire">
        <div>
           <v-toolbar flat color="white">
               <v-spacer></v-spacer>
               <h3>Chức vụ trong công ty</h3>
               <v-spacer></v-spacer>
               <v-dialog v-model="dialog" max-width="500px">
                  <v-btn slot="activator" class="mr-5" icon color="primary">
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
                      v-model="position.name"> </v-text-field>
                    </v-flex>
                    <!-- value -->
                    <!-- status -->
                    <v-flex xs12 sm6 md12>
                      <label>Trạng thái</label>
                      <v-checkbox
                      v-validate="'required'"
                      style="margin-top:0px"
                      :error-messages="errors.has('status') ? errors.collect('status') : []"
                      :data-vv-as="$t('label.status')"
                      name="status"
                      v-model="position.status">
                    </v-checkbox>
                     <span style="position: absolute ; top: 63%; left: 15%;" v-if="position.status">Hiển thị</span>
                     <span style="position: absolute ; top: 63%; left: 15%;" v-else>Không hiển thị</span>
                  </v-flex>
                </v-layout>
              </v-container>
            </v-card-text>
               <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" flat @click.native="close">Hủy bỏ</v-btn>
              <v-btn color="blue darken-1" flat @click.native="submitForm">
              <span v-if="editedIndex!==-1">Lưu lại</span><span v-else>Thêm mới</span></v-btn>
            </v-card-actions>
                   </v-card>
               </v-dialog>
           </v-toolbar>
            <v-container>
            <v-data-table
                v-if="Array.isArray(positionDetail)"
                :headers="headers"
                :items="positionDetail"
                hide-actions
                expand
                class="elevation-1"
                >
              <template slot="items" slot-scope="props">
                  <td>{{props.index + 1}} </td>
                  <td style="text-transform: capitalize">{{ props.item.name }}</td>
                  <td>{{ props.item.status_txt }}</td>
                  <td id="action">
                  <v-icon v-if="canAccess('position.update')" style="margin-right: 15px" class="mr-6" @click="editItem(props.item,props.item.id)" color="green"> edit</v-icon>
                  <v-icon v-if="canAccess('position.delete')" icon @click="removeConfirm(props.item.id)" color="red"> delete </v-icon>
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
    idPosition: null,
    dialogDelete: false,
    dialog: false,
    headers: [
      { text: 'STT', sortable: false },
      { text: 'Tên chức danh', sortable: false },
      { text: 'Trạng thái', sortable: false },
      { text: 'Hành động', sortable: false }
    ],
    editedIndex: -1,
    position: {
      status: false,
      name: ''
    },
    defaultItem: {
      status: false
    }
  }),
  computed: {
    formTitle () {
      return this.editedIndex === -1 ? 'Thêm chức danh' : 'Sửa chức danh'
    },
    ...mapGetters('Position', ['positionDetail']),
    ...mapGetters(['isFetchingApi'])
  },
  watch: {
    dialog (val) {
      val || this.close()
    }
  },
  created () {
    this.fetchPosition()
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Position', ['fetchPosition', 'deletePosition', 'updatePosition']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Position', ['createPosition']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    editItem (item, id) {
      this.idPosition = id
      this.editedIndex = this.positionDetail.indexOf(item)
      this.position = Object.assign({}, item)
      this.dialog = true
    },
    removeConfirm (id) {
      this.idPosition = id
      this.dialogDelete = true
    },
    remove (confirm) {
      this.deletePosition({
        id: this.idPosition,
        cb: (response) => {
          this.removeDataviewEntry({
            name: 'position',
            data: this.positionDetail,
            key: 'id'
          })
          this.$store.dispatch('showNotify', {
            text: this.$t('alert.success'),
            color: 'success'
          })
          this.dialogDelete = false
          this.fetchPosition()
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
    },
    close () {
      this.dialog = false
      setTimeout(() => {
        this.position = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      }, 300)
    },
    submitForm () {
      if (this.editedIndex === -1) {
        this.createPosition({
          position: this.position,
          cb: (response) => {
            this.dialog = false
            setTimeout(() => {
              this.position = Object.assign({}, this.defaultItem)
              this.editedIndex = -1
            }, 300)
            this.showNotify({
              color: 'success',
              text: 'Thành công'
            })
            this.fetchPosition()
          }
        })
      } else {
        this.updatePosition({
          id: this.idPosition,
          position: this.position,
          cb: (response) => {
            this.fetchPosition()
            this.showNotify({
              color: 'success',
              text: 'Thành công'
            })
            this.dialog = false
            setTimeout(() => {
              this.setting = Object.assign({}, this.defaultItem)
              this.editedIndex = -1
            }, 300)
          }
        })
      }
    }
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
  font-size: 28px;
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

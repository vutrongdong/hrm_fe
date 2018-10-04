<template>
  <v-layout ref="laylout" column fill-height>
    <div ref="header">
      <v-toolbar height="50px" color="white" flat>
        <v-layout row wrap>
          <v-flex md1 xs3 :class="isMini">
           <!--  <v-tooltip bottom> -->
           <v-tooltip bottom>
            <v-btn slot="activator" v-if="canAccess('position.create')"
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
            placeholder="Nhập tên chức danh"
            v-model="params.q"
            @keyup="changeSearch"
            clearable
            ></v-text-field>
          </v-flex>
          <!--dialog-->
          <v-dialog v-model="dialog" max-width="500px">
           <v-card>
            <v-card-title>
              <span class="headline" width="100%" style="margin:0 auto">{{ formTitle }}</span>
            </v-card-title>
            <v-card-text id="formSub">
              <v-container grid-list-md>
                <v-layout wrap>
                  <!-- name -->
                  <v-flex xs12 sm6 md12>
                    <v-text-field
                    placeholder="Nhập tên chức danh"
                    :error-messages="errors.has('name_position') ? errors.collect('name_position') : []"
                    v-validate="'required'"
                    :data-vv-as="$t('label.name_position')"
                    :label="$t('label.name_position')"
                    class="input-required"
                    name="name_position"
                    v-model="position.name"> </v-text-field>
                  </v-flex>
                  <!-- value -->
                  <!-- status -->
                  <v-flex xs12 sm6 md12>
                    <label class="title-position">Trạng thái</label>
                    <v-checkbox
                    @change="status_txt"
                    :label="status"
                    class="checkbox"
                    style="margin-top:0px"
                    name="status"
                    v-model="position.status">
                  </v-checkbox>
                </v-flex>
              </v-layout>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue darken-1" flat @click.native="submitForm">
              <span v-if="editTitle==-2">Lưu lại</span><span v-else>Thêm mới</span></v-btn>
              <v-btn color="blue darken-1" flat @click.native="reset">Thiết lập lại</v-btn>
              <v-btn color="blue darken-1" flat @click.native="close">Hủy bỏ</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-layout>
      <v-layout slot="extension" v-if="!isMini">
        <v-flex sm1 class="text-bold text-uppercase">
          STT
        </v-flex>
        <v-flex sm8 class="text-bold text-uppercase">
          tên chức danh
        </v-flex>
        <v-flex sm2 class="text-bold text-uppercase">
          trạng thái
        </v-flex>
        <v-flex sm1 class="text-bold text-uppercase">
          hành động
        </v-flex>
      </v-layout>
    </v-toolbar>
  </div>
  <v-flex xs12 class="border-e0-top">
    <data-view
    :name="dataViewName"
    api-url="positions"
    v-if="dataViewHeight"
    :viewHeight="dataViewHeight"
    :params="params"
    :ref="dataViewName"
    >
    <template slot-scope="{items}">
      <v-list>
        <template v-for="(item, index) in items.data">
          <v-layout class="pa-2" :key="'index'+index">
            <v-flex sm1 class="ml-3" :class="isMini && 'd-none'">
              {{ index + 1 }}
            </v-flex>
            <v-flex sm8 :class="isMini && 'd-none'">
              {{ item.name }}
            </v-flex>
            <v-flex sm2 :class="isMini && 'd-none'">
             <v-tooltip bottom sm12>
              <v-switch
              @click.native.stop
              @change="changeStatus(item.id)"
              class='ml-3'
              name="status"
              slot="activator"
              v-model="item.status"
              ></v-switch>
              <span v-if="item.status">Hiển thị</span>
              <span v-else>Không hiển thị</span>
            </v-tooltip>
          </v-flex>
          <v-flex sm1 :class="isMini && 'd-none'">
            <v-tooltip bottom>
              <v-btn slot="activator" class="ma-0" v-if="canAccess('position.update')" icon @click="editItem(item,item.id)">
                <v-icon class='theme--light teal--text'>edit</v-icon>
              </v-btn>
              <span>Sửa</span>
            </v-tooltip>
            <v-tooltip bottom>
              <v-btn slot="activator" class="ma-0" v-if="canAccess('position.delete')" icon @click.stop="removeConfirm(item.id)">
                <v-icon class="theme--light pink--text">delete</v-icon>
              </v-btn>
              <span>Xóa</span>
            </v-tooltip>
          </v-flex>
        </v-layout>
        <v-divider
        :key="'div' + item.id"
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
<script type="text/javascript">
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
    dataViewName: 'position',
    idPosition: null,
    dialogDelete: false,
    status: 'Hiển thị',
    dialog: false,
    editedIndex: -1,
    editTitle: -1,
    position: {
      status: true,
      name: ''
    },
    params: {
      q: ''
    },
    defaultItem: {
    }
  }),
  computed: {
    formTitle () {
      return this.editTitle === -1 ? 'Thêm chức danh' : 'Sửa chức danh'
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
    ...mapActions('Position', ['fetchPosition', 'deletePosition', 'updatePosition', 'updateStatusPosition']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Position', ['createPosition']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    // update status
    changeStatus (idPosition) {
      this.updateStatusPosition({
        id: idPosition,
        cb: (response) => {
          this.showNotify({
            color: 'success',
            text: 'Thành công'
          })
        }
      })
    },
    // reset form
    reset () {
      this.position.name = ''
      this.position.status = true
    },
    // dialog
    openDialog () {
      this.editTitle = -1
      this.position.status = true
      this.dialog = true
    },
    // show data edit
    editItem (item, id) {
      this.editTitle = -2
      this.idPosition = id
      this.editedIndex = this.positionDetail.indexOf(item)
      this.position = Object.assign({}, item)
      this.status_txt()
      this.dialog = true
    },
    // remove position
    removeConfirm (id) {
      this.idPosition = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deletePosition({
          id: this.idPosition,
          cb: (response) => {
            this.removeDataviewEntry({
              name: 'position',
              data: this.idPosition,
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
    },
    /// close dialog
    close () {
      this.dialog = false
      setTimeout(() => {
        this.position = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      }, 300)
    },
    status_txt () {
      if (this.position.status) {
        this.status = 'Hiển thị'
      } else {
        this.status = 'Không hiển thị'
      }
    },
    submitForm () {
      // add data
      if (this.editTitle === -1) {
        let position = Object.assign({}, this.position)
        position.status = position.status ? 1 : 0
        this.createPosition({
          position: position,
          cb: (response) => {
            this.dialog = false
            setTimeout(() => {
              console.log('data position :', position)
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
        // edit data
        let position = Object.assign({}, this.position)
        position.status = position.status ? 1 : 0
        console.log('data update position', position)
        this.updatePosition({
          id: this.idPosition,
          position: position,
          cb: (response) => {
            this.showNotify({
              color: 'success',
              text: 'Thành công'
            })
            this.dialog = false
            setTimeout(() => {
              console.log('data position :', position)
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
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 104
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
  .v-input.v-text-field{
    margin-top: 0px;
  }
  .title-position{
    color: #67757c;
    -webkit-transform: translateY(-25px) translateX(-12px);
    transform: translateY(-25px) translateX(-12px);
    top: 0;
  }

</style>

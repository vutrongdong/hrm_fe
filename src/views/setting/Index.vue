<template>
  <v-layout ref="laylout" column fill-height>
   <div ref="header">
    <v-toolbar height="50px" color="white" flat>
      <v-layout row wrap>
        <v-tooltip bottom>
          <v-btn slot="activator" v-if="canAccess('setting.create')"
          class="mr-5" icon color="primary"
          @click="addSetting">
          <v-icon>add</v-icon>
        </v-btn>
        <span>Thêm mới</span>
      </v-tooltip>
      <h2 style="margin-top:10px;">Thông tin công ty</h2>
    </v-layout>
    <v-layout slot="extension" v-if="!isMini">
      <v-flex sm1 class="text-bold text-uppercase">
        STT
      </v-flex>
      <v-flex sm2 class="text-bold text-uppercase">
        Tên
      </v-flex>
      <v-flex sm5 class="text-bold text-uppercase">
        Giá trị
      </v-flex>
      <v-flex sm2 class="text-bold text-uppercase mr-1">
        Trạng thái
      </v-flex>
      <v-flex sm2 class="text-bold text-uppercase mr-1">
        Hành động
      </v-flex>
    </v-layout>
  </v-toolbar>
</div>
<v-flex>
  <v-dialog v-model="dialog" max-width="500px">
    <v-card class="pa-0">
      <v-card-title class="pa-2">
        <span class="headline mt-1" width="100%" style="margin:0 auto">{{ formTitle }}</span>
      </v-card-title>
      <!-- form edit -->
      <v-card-text id="formSub">
        <v-container fluid class="white scroll-y border-e0-top pt-0">
          <v-layout wrap>
            <!-- name -->
            <v-flex xs12 sm6 md12>
              <v-text-field
              placeholder="Nhập tên"
              :error-messages="errors.has('name') ? errors.collect('name') : []"
              v-validate="'required'"
              :data-vv-as="$t('label.name')"
              name="name"
              :label="$t('label.name') + '*'"
              v-model="setting.name"> </v-text-field>
            </v-flex>
            <!-- slug -->
            <v-flex xs12 sm6 md12>
              <v-text-field
              placeholder="Nhập slug"
              v-validate="'required'"
              :error-messages="errors.has('slug') ? errors.collect('slug') : []"
              :data-vv-as="$t('label.slug')"
              name="slug"
              :label="$t('label.slug')+ '*'"
              v-model="setting.slug"> </v-text-field>
            </v-flex>
            <!-- value -->
            <v-flex xs12 sm6 md12>
              <v-text-field
              placeholder="Nhập giá trị"
              v-validate="'required'"
              :error-messages="errors.has('value') ? errors.collect('value') : []"
              :data-vv-as="$t('label.value')"
              name="value"
              :label="$t('label.value')+ '*'"
              v-model="setting.value"> </v-text-field>
            </v-flex>
            <!-- status -->
            <v-flex xs12 sm6 md12>
              <label>Trạng thái</label>
              <v-checkbox
              v-validate="'required'"
              style="margin-top:0px"
              :error-messages="errors.has('status') ? errors.collect('status') : []"
              :data-vv-as="$t('label.status')"
              name="status"
              v-model="setting.status">
            </v-checkbox>
            <span v-if="setting.status" class='status'>Hiển thị</span>
            <span v-else class='status'>Không hiển thị</span>
          </v-flex>
        </v-layout>
      </v-container>
    </v-card-text>
    <!-- end form edit -->
    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="blue darken-1" flat @click.native="close">Hủy bỏ</v-btn>
      <v-btn color="blue darken-1" flat @click.native="submitForm"><span v-if="editedIndex!==-1">Lưu lại</span><span v-else>Thêm mới</span></v-btn>
    </v-card-actions>
  </v-card>
</v-dialog>
</v-flex>
<v-flex xs12 class="border-e0-top">
  <data-view
  :name="dataViewName"
  api-url="settings"
  v-if="dataViewHeight"
  :viewHeight="dataViewHeight"
  :params="params"
  :ref="dataViewName"
  >
  <template slot-scope="{items}">
    <v-list three-line>
      <template v-for="(item, index) in items.data">
        <v-layout class="pa-2">
          <v-flex class="ml-3" sm1 :class="isMini && 'd-none'">
            {{ index + 1 }}
          </v-flex>
          <v-flex sm2 :class="isMini && 'd-none'">
            {{ item.name }}
          </v-flex>
          <v-flex class="mr-1" sm5 :class="isMini && 'd-none'">
            {{ item.value }}
          </v-flex>
          <v-flex sm2 :class="isMini && 'd-none'">
            <v-tooltip bottom sm12>
              <v-switch
              @click.native.stop="changeStatus(item.id)"
              class='ml-3'
              name="status"
              slot="activator"
              v-model="item.status"
              ></v-switch>
              <span v-if="item.status">Hiển thị</span>
              <span v-else>Không hiển thị</span>
            </v-tooltip>
          </v-flex>
          <v-flex sm2 :class="isMini && 'd-none'">
            <v-tooltip bottom>
              <v-btn slot="activator" class="ma-0" v-if="canAccess('setting.update')" icon @click="editItem(item,item.id)">
                <v-icon class='theme--light teal--text'>edit</v-icon>
              </v-btn>
              <span>Sửa</span>
            </v-tooltip>
            <v-tooltip bottom>
              <v-btn slot="activator" class="ma-0" v-if="canAccess('setting.delete')" icon @click.stop="removeConfirm(item.id)">
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
import { debounce } from 'lodash'
import DataView from '@/components/DataView/DataView'
import DialogConfirm from '@/components/DialogConfirm'
import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'setingIndex',
  components: {
    DataView,
    DialogConfirm
  },
  props: {
    isMini: {
      type: Boolean,
      default: false
    }
  },
  data: () => ({
    dataViewHeight: 0,
    dataViewName: 'setting',
    params: {
      q: ''
    },
    idSetting: null,
    dialogDelete: false,
    dialog: false,
    editedIndex: -1,
    setting: {
      status: true
    },
    defaultItem: {
      status: true
    }
  }),
  computed: {
    formTitle () {
      return this.editedIndex === -1 ? 'Thêm thông tin' : 'Sửa thông tin'
    },
    ...mapGetters('Setting', ['settingDetail']),
    ...mapGetters(['isFetchingApi'])
  },
  created () {
    this.FetchSetting()
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 148
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
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Setting', ['FetchSetting', 'deleteSetting', 'updateSetting','updateStatusSetting']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Setting', ['createSetting']),
    addSetting () {
      this.dialog = true
    },
    editItem (item, id) {
      this.idSetting = id
      this.editedIndex = 1
      this.setting = Object.assign({}, item)
      this.dialog = true
    },
    changeStatus (idSetting) {
      this.updateStatusSetting({
        id: idSetting
      })
    },
    changeSearch: debounce(function () {
      this.filter()
    }, 500),
    filter () {
      this.$refs[this.dataViewName].$emit('reload')
    },
    removeConfirm (id) {
      this.idSetting = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteSetting({
          id: this.idSetting,
          cb: (response) => {
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.$refs[this.dataViewName].$emit('reload')
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
    close () {
      this.dialog = false
      setTimeout(() => {
        this.setting = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      }, 300)
    },
    submitForm () {
      if (this.editedIndex === -1) {
        this.createSetting({
          setting: this.setting,
          cb: (response) => {
            this.dialog = false
            setTimeout(() => {
              this.setting = Object.assign({}, this.defaultItem)
              this.editedIndex = -1
            }, 300)
            this.showNotify({
              color: 'success',
              text: 'Thành công'
            })
            this.$refs[this.dataViewName].$emit('reload')
          }
        })
      } else {
        this.updateSetting({
          id: this.idSetting,
          setting: this.setting,
          cb: (response) => {
            this.$refs[this.dataViewName].$emit('reload')
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
<style scoped>
span.status{
  position: absolute;
  bottom: 118px;
  left:70px;
}
</style>

<template>
  <div id="app" ref="laylout">
    <v-app id="inspire">
      <div>
        <v-toolbar flat color="white">
          <v-spacer></v-spacer>
          <h3>Thiết lập thông tin công ty</h3>
          <v-spacer></v-spacer>
          <v-dialog v-model="dialog" max-width="500px">
            <v-btn slot="activator" class="mr-5" icon color="primary">
              <v-icon>add</v-icon>
            </v-btn>
            <v-card>
              <v-card-title>
                <span class="headline">{{ formTitle }}</span>
              </v-card-title>
              <!-- form edit -->
              <v-card-text id="formSub">
                <v-container grid-list-md class="white scroll-y border-e0-top">
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
                      v-model="setting.name"> </v-text-field>
                    </v-flex>
                    <!-- value -->
                    <v-flex xs12 sm6 md12>
                      <v-text-field
                      placeholder="nhập gía trị"
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
      </v-toolbar>
      <v-container>
        <v-data-table
        v-if="Array.isArray(settingDetail)"
        :headers="headers"
        :items="settingDetail"
        hide-actions
        expand
        class="elevation-1"
        >
        <template slot="items" slot-scope="props">
          <td> {{ props.index + 1 }}</td>
          <td style="text-transform: capitalize">{{ props.item.name }}</td>
          <td style="text-transform: capitalize">{{ props.item.value }}</td>
          <td>{{ props.item.status_txt }}</td>
          <td id="action"> <v-icon v-if="canAccess('setting.update')" class="mr-6" @click="editItem(props.item,props.item.id)" color="green"> edit</v-icon>
            <v-icon style="margin-left:10px" v-if="canAccess('setting.delete')" icon @click="removeConfirm(props.item.id)" color="red"> delete </v-icon>
          </td>
        </template>
      </v-data-table>
    </v-container>
    <dialog-confirm v-model="dialogDelete" @input="remove" />
  </div>
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
    idSetting: null,
    dialogDelete: false,
    dialog: false,
    headers: [
      { text: 'STT', sortable: false },
      { text: 'Tên thông tin', sortable: false },
      { text: 'Giá trị', sortable: false },
      { text: 'Trạng Thái', sortable: false },
      { text: 'Hành động', sortable: false }
    ],
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
  watch: {
    dialog (val) {
      val || this.close()
    }
  },
  created () {
    this.FetchSetting()
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Setting', ['FetchSetting', 'deleteSetting', 'updateSetting']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Setting', ['createSetting']),
    editItem (item, id) {
      this.idSetting = id
      this.editedIndex = this.settingDetail.indexOf(item)
      this.setting = Object.assign({}, item)
      this.dialog = true
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
            this.FetchSetting()
          }
        })
      } else {
        this.updateSetting({
          id: this.idSetting,
          setting: this.setting,
          cb: (response) => {
            this.FetchSetting()
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

<template>
  <v-layout ref="laylout" row fill-height>
   <v-flex xs4>
    <listting :is-mini="true" />
  </v-flex>
  <v-flex xs8 class="border-e0-left">
    <v-toolbar dense color="white" flat>
      <v-toolbar-title>{{ $t('title.user.detail') }}: {{userDetail.name}}</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-tooltip bottom>
        <v-btn slot='activator' v-if="canAccess('user.update')" icon @click="$router.push({name: 'user-edit', params: {id: $route.params.id}})">
          <v-icon>edit</v-icon>
        </v-btn>
        <span>Sửa</span>
      </v-tooltip>
      <v-tooltip bottom>
        <v-btn slot="activator" v-if="canAccess('user.delete')" icon @click="removeConfirm">
          <v-icon>delete</v-icon>
        </v-btn>
        <span>Xóa</span>
      </v-tooltip>
      <v-tooltip bottom>
        <v-btn slot="activator" icon @click="$router.push({name: 'user'})">
          <v-icon>close</v-icon>
        </v-btn>
        <span>Đóng</span>
      </v-tooltip>
    </v-toolbar>
    <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
      <v-layout row>
        <v-flex md5 sm5 xs5>
          <img v-if="userDetail.image" src="userDetail.image" alt="">
          <img width="100%" src="https://demo1.sinnovasoft.com/Content/images/empty.png" alt="">
        </v-flex>
        <v-flex md7 sm7 xs7 style="padding-left:10px;" id="info-user">
          <p v-if="userDetail.code"> - Mã nhân viên : {{ userDetail.code }}</p>
          <p v-if="userDetail.name"> - Tên nhân viên : {{ userDetail.name }}</p>
          <p> - Thư điện tử : {{ userDetail.email }}</p>
          <p v-if='userDetail.qualification'> - Trình độ chuyên môn : {{ userDetail.qualification }}</p>
          <p v-if='userDetail.address'> - Địa chỉ : {{ userDetail.address }}</p>
          <p v-if="userDetail.phone"> - Số điện thoại: {{ userDetail.phone }}</p>
          <p v-if="userDetail.gender_txt"> - Giới tính: {{ userDetail.gender_txt }}</p>
          <p v-if="userDetail.date_of_birth"> - Ngày sinh: {{ userDetail.date_of_birth }}</p>
          <p v-if="userDetail.status_txt"> - Trạng thái: {{ userDetail.status_txt }}</p>
        </v-flex>
      </v-layout>
      <v-flex xs12 v-if="userDetail.departments">
        <h3>Vị trí , chức vụ của nhân viên</h3>
        <v-data-table
        :headers="headersPosition"
        :items="userDetail.departments.data"
        hide-actions
        class="elevation-1 mt-2"
        >
        <template slot="items" slot-scope="props">
          <td>{{ props.item.name }}</td>
          <td>{{ props.item.branch_name }}</td>
          <td>{{ props.item.position_name }}</td>
        </template>
      </v-data-table>
    </v-flex>
    <v-flex class="mt-4" xs12 v-if="userDetail.contracts">
      <h3>Hợp đồng nhân viên</h3>
      <v-data-table
      id="tableContract"
      :headers="headersContract"
      :items="userDetail.contracts.data"
      hide-actions
      class="elevation-1 mt-2"
      >
      <template slot="items" slot-scope="props">
        <td colspan="2">{{ props.item.title }}</td>
        <td>{{ props.item.type_txt }}</td>
        <td>{{ props.item.status_txt }}</td>
        <td>{{ props.item.date_sign }}</td>
        <td>{{ props.item.date_effective }}</td>
        <td>{{ props.item.date_expiration }}</td>
        <td colspan="2" style="padding:2px;">
          <v-tooltip bottom class="ml-3">
            <v-btn style="margin:0px;" slot='activator' v-if="canAccess('user.update')" icon @click="editContract(props.item,props.item.id)">
              <v-icon size="19px">edit</v-icon>
            </v-btn>
            <span>Sửa</span>
          </v-tooltip>
          <v-tooltip bottom>
            <v-btn style="margin: 0px;" slot="activator" v-if="canAccess('user.delete')" icon @click="removeConfirm(props.item.id)">
              <v-icon size="19px">delete</v-icon>
            </v-btn>
            <span>Xóa</span>
          </v-tooltip>
        </td>
      </template>
    </v-data-table> </v-flex>
  </v-container>
  <v-dialog v-model="dialogEditContract" max-width="500px">
    <v-card>
      <v-card-title>
        <span class="headline">{{ formTitle }}</span>
      </v-card-title>
      <!-- form edit -->
      <v-card-text id="formSub">
        <v-container grid-list-md class="white scroll-y border-e0-top">
          <v-layout row wrap>
            <v-flex xs6 class="pr-2">
              <!-- title contract -->
              <v-text-field
              placeholder="Nhập tiêu đề hợp đồng"
              :error-messages="errors.has('title') ? errors.collect('title') : []"
              :data-vv-as="$t('label.title')"
              name="title"
              :label="$t('label.title') + ' * '"
              v-model="user.contracts.title"> </v-text-field>
              <!-- type contract -->
              <v-select
              :error-messages="errors.has('type') ? errors.collect('type') : []"
              :data-vv-as="$t('label.type')"
              name="type"
              :label="$t('label.type')"
              v-model="user.contracts.type"
              :items="typeContract"
              item-value="value"
              item-text="name"> </v-select>
              <!-- status contract-->
              <v-select
              :error-messages="errors.has('status') ? errors.collect('status') : []"
              :data-vv-as="$t('label.status')"
              name="status"
              :label="$t('label.status')"
              v-model="user.contracts.status"
              :items="statusContract"
              item-value="value"
              item-text="name"> </v-select>
            </v-flex>
            <v-flex xs6 class="pl-2">
              <!-- date_sign -->
              <template>
                <v-menu
                ref="dateSign"
                :close-on-content-click="false"
                v-model="dateSign"
                :nudge-right="40"
                lazy transition="scale-transition"
                offset-y
                full-width
                min-width="290px">
                <v-text-field
                placeholder="Nhập ngày ký"
                slot="activator"
                v-model="user.contracts.date_sign"
                label="Ngày ký"
                readonly > </v-text-field>
                <v-date-picker
                ref="picker"
                v-model="user.contracts.date_sign"
                :max="new Date().toISOString().substr(0, 10)"
                min="1950-01-01"
                @change="save"> </v-date-picker> </v-menu>
              </template>
              <!-- date_effective -->
              <template>
                <v-menu
                ref="dateEffective"
                :close-on-content-click="false"
                v-model="dateEffective"
                :nudge-right="40"
                lazy transition="scale-transition"
                offset-y
                full-width
                min-width="290px">
                <v-text-field
                placeholder="Ngày có hiệu lực"
                slot="activator"
                v-model="user.contracts.date_effective"
                label="Ngày có hiệu lực"
                readonly > </v-text-field>
                <v-date-picker
                ref="picker"
                v-model="user.contracts.date_effective"
                :max="new Date().toISOString().substr(0, 10)"
                min="1950-01-01"
                @change="save"> </v-date-picker> </v-menu>
              </template>
              <!-- date_expiration -->
              <template>
                <v-menu
                ref="dateExpiration"
                :close-on-content-click="false"
                v-model="dateExpiration"
                :nudge-right="40"
                lazy transition="scale-transition"
                offset-y
                full-width
                min-width="290px">
                <v-text-field
                placeholder="Ngày có hết hạn"
                slot="activator"
                v-model="user.contracts.date_expiration"
                label="Ngày có hết hạn"
                readonly > </v-text-field>
                <v-date-picker
                ref="picker"
                v-model="user.contracts.date_expiration"
                :max="new Date().toISOString().substr(0, 10)"
                min="1950-01-01"
                @change="save"> </v-date-picker> </v-menu>
              </template>
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
<dialog-confirm v-model="dialogDelete" @input="remove" />
</v-layout>
</template>

<script>
import Listting from './Listting'
import { mapActions, mapGetters } from 'vuex'
import DialogConfirm from '@/components/DialogConfirm'
export default{
  name: 'UserDetail',
  components: {
    Listting,
    DialogConfirm
  },
  data () {
    return {
      user:{
        contracts:''
      },
      typeContract: [
      { name: 'Học việc', value: 0 },
      { name: 'Cộng tác viên', value: 1 },
      { name: 'Thử việc', value: 2 },
      { name: 'Có thời hạn', value: 3 },
      { name: 'Không thời hạn', value: 4 },
      { name: 'Khác', value: 5 }
      ],
      statusContract: [
      { name: 'Tiêu chuẩn', value: 0 },
      { name: 'Chấm dứt', value: 1 },
      { name: 'Gia hạn', value: 2 }
      ],
      // tiêu đề của bảng chi nhánh phòng ban , chức vụ
      headersPosition: [
      { text: 'Chi nhánh', value: 'branch', sortable: false },
      { text: 'Phòng ban', value: 'department', sortable: false },
      { text: 'Chức vụ', value: 'position', sortable: false }
      ],
      // tiêu đề của bảng hợp đồng
      headersContract: [
      { text: 'Tên hợp đồng', value: 'title', sortable: false },
      { text: '', sortable: false },
      { text: 'Loại hợp đồng', value: 'type', sortable: false },
      { text: 'Trạng thái', value: 'status', sortable: false },
      { text: 'Ngày đăng kí', value: 'date_sign', sortable: false },
      { text: 'Ngày bắt đầu', value: 'date_effective', sortable: false },
      { text: 'Ngày kêt thúc', value: 'date_expiration', sortable: false },
      { text: 'Hành động', value: 'action', sortable: false }
      ],
      dataViewHeight: 0,
      dialogEditContract: false,
      dialogDelete: false,
      dateSign: false,
      dateEffective: false,
      dateExpiration: false,
      editedIndex: -1,
    }
  },
  computed: {
    //title of form Contract modal
    formTitle () {
      return this.editedIndex === -1 ? 'Thêm thông tin' : 'Sửa thông tin'
    },
    ...mapGetters('User', ['userDetail']),
    ...mapGetters('Contracts', ['contractDetail'])
  },
  watch: {
    dateSign (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    },
    dateEffective (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    },
    dateExpiration (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    },
    dataUser (val) {
      this.user = val
    }
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Contracts', ['getContract','updateContract','deleteContract']),
    ...mapActions('User', ['getUser', 'deleteUser']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    removeConfirm () {
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteUser({
          id: this.$route.params.id,
          cb: (response) => {
            this.removeDataviewEntry({
              name: 'user',
              data: this.userDetail,
              key: 'id'
            })
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.$router.push({ name: 'user' })
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
    save (date) {
      this.$refs.dateSign.save(date)
      this.$refs.dateEffective.save(date)
      this.$refs.dateExpiration.save(date)
    },
    editContract (item, id) {
      this.getContract(
        {contractId: id}
        )
      console.log("contract",contractDetail)
      // this.idSetting = id
      this.editedIndex = 1
      this.setting = Object.assign({}, item)
      this.dialogEditContract = true
    },
  },
  created () {
    this.setMiniDrawer(true)
    if (!this.userDetail.id) {
      this.getUser({ userId: this.$route.params.id, params: { include: 'roles,departments,contracts' } })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 50
  }
}
</script>

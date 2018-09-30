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
      :headers="headersContract"
      :items="userDetail.contracts.data"
      hide-actions
      class="elevation-1 mt-2"
      >
      <template slot="items" slot-scope="props">
        <td>{{ props.item.title }}</td>
        <td>{{ props.item.type_txt }}</td>
        <td>{{ props.item.status_txt }}</td>
        <td>{{ props.item.date_sign }}</td>
        <td>{{ props.item.date_effective }}</td>
        <td>{{ props.item.date_expiration }}</td>
      </template>
    </v-data-table> </v-flex>
  </v-container>
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
      // tiêu đề của bảng chi nhánh phòng ban , chức vụ
      headersPosition: [
        { text: 'Chi nhánh', value: 'branch', sortable: false },
        { text: 'Phòng ban', value: 'department', sortable: false },
        { text: 'Chức vụ', value: 'position', sortable: false }
      ],
      // tiêu đề của bảng hợp đồng
      headersContract: [
        { text: 'Tên hợp đồng', value: 'title', sortable: false },
        { text: 'Loại hợp đồng', value: 'type', sortable: false },
        { text: 'Trạng thái', value: 'status', sortable: false },
        { text: 'Ngày đăng kí', value: 'status', sortable: false },
        { text: 'Ngày bắt đầu', value: 'status', sortable: false },
        { text: 'Ngày kêt thúc', value: 'status', sortable: false }
      ],
      dataViewHeight: 0,
      dialogDelete: false
    }
  },
  computed: {
    ...mapGetters('User', ['userDetail'])
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
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
    }
  },
  created () {
    console.log(this.userDetail.departments)
    this.setMiniDrawer(true)
    if (!this.userDetail.id) {
      this.getUser({ userId: this.$route.params.id, params: { include: 'roles,departments,contracts' } })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 96
  }
}
</script>

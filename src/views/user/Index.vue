  <template>
    <v-layout ref="laylout" column fill-height>
      <v-toolbar dense color="white" flat>
        <v-spacer></v-spacer>
        <h3>Danh sách nhân viên</h3>
        <v-spacer></v-spacer>
        <v-btn v-if="canAccess('user.create')"
        class="mr-5" icon color="primary"
        @click="$router.push({name: 'user-create'})">
        <v-icon>add</v-icon>
      </v-btn>
    </v-toolbar>
    <v-flex xs12 class="border-e0-top">
      <v-container>
        <v-data-table
        v-if="Array.isArray(userAll)"
        :items="userAll"
        hide-actions
        expand
        :headers="title"
        class="elevation-1"
        >
        <template slot="items" slot-scope="props">
          <tr>
            <td style="text-transform: capitalize">{{ props.item.name }} </td>
            <td style="text-transform: capitalize">{{ props.item.code }} </td>
            <td style="text-transform: capitalize">{{ props.item.email }}</td>
            <td style="text-transform: capitalize">{{ props.item.address }}</td>
            <td style="text-transform: capitalize">{{ props.item.gender_txt }}</td>
            <td style="text-transform: capitalize">{{ props.item.status_txt }}</td>
            <td id="action">
              <v-icon style="margin-right:15px" v-if="canAccess('user.view')" class="mr-6" @click="detailConfirm(props.item.id)" color="green">far fa-eye</v-icon>
              <v-icon v-if="canAccess('user.update')" class="mr-6" @click="$router.push({name: 'user-edit', params: {id: props.item.id}})" color="green"> edit</v-icon>
              <v-icon style="margin-left:10px" v-if="canAccess('user.delete')" icon @click="removeConfirm(props.item.id)" color="red"> delete </v-icon>
            </td>
          </tr>
        </template>
      </v-data-table>
      <div class="text-xs-center">
        <v-dialog v-model="dialogDetail" width="550">
          <v-card>
            <v-card-title style="text-transform:uppercase" class="headline grey lighten-2" primary-title >
              <p style="width:100%;"  class="text-md-center" v-if="userDetail.name">{{ userDetail.name }}</p>

            </v-card-title>
            <!-- content -->
            <v-card-text id="detailUser">
              <v-container>
                <v-layout row>
                  <v-flex md5 sm5 xs5>
                    <img style="border:1px solid gray" width="100%" src="https://cdn.dep365.com/wp-content/uploads/2017/11/lam-hotgirl-anh-khong-kho-voi-5-meo-chup-hinh-nay-2.jpg" alt="">
                  </v-flex>
                  <v-flex md7 sm7 xs7 style="padding-left:10px;" id="info-user">
                    <p v-if="userDetail.code"> - Mã nhân viên : {{ userDetail.code }}</p>
                    <p v-if="userDetail.name"> - Tên nhân viên : {{ userDetail.name }}</p>
                    <p v-if='userDetail.qualification'> - Trình độ chuyên môn : {{ userDetail.qualification }}</p>
                    <p v-if='userDetail.address'> - Địa chỉ : {{ userDetail.address }}</p>
                    <p v-if="userDetail.phone"> - Số điện thoại: {{ userDetail.phone }}</p>
                    <p v-if="userDetail.gender_txt"> - Giới tính: {{ userDetail.gender_txt }}</p>
                    <p v-if="userDetail.date_of_birth"> - Ngày sinh: {{ userDetail.date_of_birth }}</p>
                    <p v-if="userDetail.status_txt"> - Trạng thái: {{ userDetail.status_txt }}</p>
                  </v-flex>
                </v-layout>
                <v-layout row v-if="userDetail.departments">
                  <v-flex style="margin-top:40px;">
                    <p row style="margin-top:-20px;">
                      <v-flex md12 sm12 xs12>
                        <p v-for='department in userDetail.departments.data' style="margin-left:15px;" :key="'department' + department.id">
                          <v-chip color="green" text-color="white" v-if="department.branch">{{ department.branch.data.name }}</v-chip>
                          <v-chip color="orange" text-color="white">{{ department.name }}</v-chip>
                          <v-chip color="teal" text-color="white">{{ department.position_name }}</v-chip>
                        </p>
                      </v-flex>
                    </p>
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
      </div>
      <dialog-confirm v-model="dialogDelete" @input="remove" />
    </v-container>
  </v-flex>
</v-layout>
</template>
<script>
import DialogConfirm from '@/components/DialogConfirm'
import { mapActions, mapGetters } from 'vuex'
export default{
  components: {
    DialogConfirm
  },
  data: () => ({
    idUser: null,
    dialogDetail: false,
    dialogDelete: false,
    title: [
      { text: 'Tên', sortable: false },
      { text: 'Mã nhân viên', sortable: false },
      { text: 'Email', sortable: false },
      { text: 'Địa chỉ', sortable: false },
      { text: 'Giới tính', sortable: false },
      { text: 'Trạng thái', sortable: false },
      { text: 'Các hành động', sortable: false }
    ]
  }),
  computed: {
    ...mapGetters('User', ['userDetail', 'userAll'])
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('User', ['getUsers', 'getUser', 'deleteUser']),
    detailConfirm (id) {
      this.dialogDetail = true
      this.getUser({
        userId: id,
        params: { include: 'departments.branch' }
      })
    },

    removeConfirm (id) {
      this.idUser = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteUser({
          id: this.idUser,
          cb: (response) => {
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.getUsers({ params: { include: 'departments.branch' } })
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
    this.getUsers({ params: { include: 'departments.branch' } })
  }
}
</script>
<style scoped>
#detailUser .container .layout #info-user p{
  margin-bottom: 0rem;
}
</style>

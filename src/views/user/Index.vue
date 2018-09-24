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
        v-if="Array.isArray(userDetail)"
        :items="userDetail"
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
<!--           <td>
            <p v-if="props.item.departments">
              <p v-for="department in props.item.departments.data" color="green" text-color="white">{{ department.branch.data.name }} => {{ department.name }}=>{{ department.position_name }}</p>
            </p>
          </td> -->
          <td style="text-transform: capitalize">{{ props.item.status_txt }}</td>
          <td id="action">
           <v-icon v-if="canAccess('user.update')" class="mr-6" @click="$router.push({name: 'user-edit', params: {id: props.item.id}})" color="green"> edit</v-icon>
           <v-icon style="margin-left:10px" v-if="canAccess('user.delete')" icon @click="removeConfirm(props.item.id)" color="red"> delete </v-icon>
         </td>
       </tr>
     </template>
   </v-data-table>
   <dialog-confirm v-model="dialogDelete" @input="remove()" />
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
    dialogDelete: false,
    title: [
      { text: 'Tên', sortable: false },
      { text: 'Mã nhân viên', sortable: false },
      { text: 'Email', sortable: false },
      { text: 'Địa chỉ', sortable: false },
      { text: 'Giới tính', sortable: false },
      { text: 'Trạng thái', sortable: false },
      { text: 'Hành động', sortable: false }
    ]
  }),
  computed: {
    ...mapGetters('User', ['userDetail'])
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('User', ['getUsers', 'deleteUser']),
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
            this.getUsers()
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

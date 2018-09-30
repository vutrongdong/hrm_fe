<template>
  <v-layout ref="laylout" column fill-height>
    <div ref="header">
      <v-toolbar height="50px" color="white" flat>
        <v-layout row wrap>
          <v-flex xs2 :class="isMini">
            <v-tooltip bottom>
              <v-btn slot="activator" v-if="canAccess('user.create')" class="mr-3 mt-3" icon color="primary" @click="$router.push({name: 'user-create'})">
                <v-icon>add</v-icon>
              </v-btn>
              <span>Thêm mới</span>
            </v-tooltip>
          </v-flex>
          <v-flex xs5 class="mt-1" :class="isMini && 'full-flex-basic'">
            <v-text-field
            hide-details
            single-line
            placeholder="Nhập tên, sđt, email ..."
            v-model="params.q"
            @keyup="changeSearch"
            clearable
            ></v-text-field>
          </v-flex>
          <v-flex xs5 class='mt-1' :class="isMini && 'd-none'">
            <v-select
            class='ml-2'
            @change="filter"
            placeholder="Hợp đồng"
            item-text="title"
            item-value="id"
            :items="contractDetail"
            v-model="params.contract_id"
            menu-props="auto"
            hide-details
            single-line
            ></v-select>
          </v-flex>
        </v-layout>
        <v-layout slot="extension" row wrap v-if="!isMini">
          <v-flex xs4 class="pt-0" :class="isMini && 'd-none'">
            <v-select
            class='ml-2'
            @change="changeBranch"
            placeholder="Chọn chi nhánh"
            :items="branchAll"
            item-text="name"
            item-value="id"
            v-model="params.branch_id"
            menu-props="auto"
            hide-details
            single-line
            ></v-select>
          </v-flex>
          <v-flex xs4 :class="isMini && 'd-none'">
            <v-select
            :disabled = "!departmentActiveByBranch"
            class='ml-2'
            @change="ChangeDepartment"
            :placeholder="placeholderDepartment"
            :items="departments"
            item-text="name"
            item-value="id"
            v-model="params.department_id"
            menu-props="auto"
            hide-details
            single-line
            ></v-select>
          </v-flex>
          <v-flex xs4 :class="isMini && 'd-none'">
            <v-select
            :disabled = "!positionActiveByDepartment"
            class='ml-2'
            @change="filter"
            :placeholder="placeholderPosition"
            :items="positionAll"
            item-text="name"
            item-value="id"
            v-model="params.position_id"
            menu-props="auto"
            hide-details
            single-line
            ></v-select>
          </v-flex>
        </v-layout>
      </v-toolbar>
      <v-toolbar height="45px" color="white" flat v-if="!isMini">
        <v-layout>
          <v-flex sm1 class="text-bold text-uppercase">
            STT
          </v-flex>
          <v-flex sm1 class="text-bold text-uppercase">
            Hình ảnh
          </v-flex>
          <v-flex sm3 class="text-bold text-uppercase">
            Tên nhân viên
          </v-flex>
          <v-flex sm2 class="text-bold text-uppercase">
            Phòng ban
          </v-flex>
          <v-flex sm2 class="text-bold text-uppercase">
            Chức vụ
          </v-flex>
          <v-flex sm2 class="text-bold text-uppercase">
            Hợp Đồng
          </v-flex>
          <v-flex sm1 class="text-bold text-uppercase mr-3">
            Hành động
          </v-flex>
        </v-layout>
      </v-toolbar>
    </div>
    <v-flex xs12 class="border-e0-top">
      <data-view
      :name="dataViewName"
      api-url="users"
      v-if="dataViewHeight"
      :viewHeight="dataViewHeight"
      :params="params"
      :ref="dataViewName"
      >
      <template slot-scope="{items}">
        <v-list three-line>
          <template v-for="(item, index) in items.data">
            <v-list-tile
            :key="'item' + item.id"
            avatar
            @click="userDetail(item)"
            :inactive="item.id === $route.params.id"
            :class="item.id === $route.params.id && 'grey lighten-2'"
            >
            <v-layout class="pa-2">
              <v-flex sm1 :class="isMini && 'd-none'">
                {{index + 1}}
              </v-flex>
              <v-flex sm1 :class="isMini && 'd-none'">
                <img width="80%" src="https://demo1.sinnovasoft.com/Content/images/empty.png" alt="">
              </v-flex>
              <!-- imfomation -->
              <v-flex sm3 :class="isMini && 'full-flex-basic full-max-width'">
                {{ item.name}} - {{item.gender_txt}}
                <v-list-tile-sub-title class="text--primary" v-if="item.email" :class="isMini && 'd-none'">
                  <v-icon size="16px">email</v-icon>
                  {{ item.email }}
                </v-list-tile-sub-title>
                <v-list-tile-sub-title class="text--primary" v-if="item.phone" :class="isMini && 'd-none'">
                  <v-icon size="16px">phone</v-icon>
                  {{ item.phone }}
                </v-list-tile-sub-title>
              </v-flex>
              <!-- end infomation -->
              <v-flex sm2 :class="isMini && 'd-none'" >
                <v-flex :key="index" v-for="(department, index) in item.departments.data">
                  {{ department.name }}
                  <!-- phòng IT -->
                </v-flex>
              </v-flex>
              <v-flex sm2 :class="isMini && 'd-none'" >
                <v-flex :key="index" v-for="(department, index) in item.departments.data">
                  <!-- Giám đốc -->
                  {{ department.position_name }}
                </v-flex>
              </v-flex>
              <v-flex>
                <v-flex v-if='item.contracts' sm2 :class="isMini && 'd-none'" >
                  <v-flex :key="index" v-for="(contract, index) in item.contracts.data">
                    {{ contract.title }}
                  </v-flex>
                </v-flex>
              </v-flex>
              <v-flex sm1 :class="isMini && 'd-none'">
                <v-tooltip bottom>
                  <v-btn slot="activator" class="ma-0" v-if="canAccess('user.update')" icon @click.stop="$router.push({name: 'user-edit', params: {id: item.id}})">
                    <v-icon class='theme--light teal--text'>edit</v-icon>
                  </v-btn>
                  <span>Sửa</span>
                </v-tooltip>
                <v-tooltip bottom>
                  <v-btn slot="activator" class="ma-0" v-if="canAccess('user.delete')" icon @click.stop="removeConfirm(item.id)">
                    <v-icon class="theme--light pink--text">delete</v-icon>
                  </v-btn>
                  <span>Xóa</span>
                </v-tooltip>
              </v-flex>
            </v-layout>
          </v-list-tile>
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
    placeholderPosition: 'Chọn phòng ban trước !',
    placeholderDepartment: 'Chọn chi nhánh trước !',
    departmentActiveByBranch: false,
    positionActiveByDepartment: false,
    dialogDelete: false,
    dataViewHeight: 0,
    dataViewName: 'user',
    departments: [],
    idUser: null,
    params: {
      q: '',
      branch_id: '',
      department_id: '',
      position_id: '',
      include: 'roles,departments,contracts'
    }
  }),
  computed: {
    ...mapGetters('Branch', ['branchAll']),
    ...mapGetters('Department', ['departmentByBranch']),
    ...mapGetters('Position', ['positionAll']),
    ...mapGetters('Contracts', ['contractDetail'])
  },
  methods: {
    ...mapActions('Dataview', ['removeDataviewEntry']),
    ...mapActions('User', ['getUser', 'deleteUser']),
    ...mapActions('Branch', ['getBranchForUser']),
    ...mapActions('Department', ['getDepartmentForUser']),
    ...mapActions('Contracts', ['fetchContract']),
    ...mapActions('Position', ['fetchPosition']),
    userDetail (user) {
      this.getUser({ userId: user.id, params: { include: 'roles,departments' } })
      this.$router.push({ name: 'user-detail', params: { id: user.id } })
    },
    changeSearch: debounce(function () {
      this.filter()
    }, 500),
    // lọc chi phòng ban theo chi nhánh
    changeBranch: debounce(function (value) {
      this.placeholderDepartment = 'Chọn phòng ban'
      this.departmentActiveByBranch = true
      this.getDepartmentForUser({
        branchId: value,
        params: { include: 'departments' },
        cb: () => {
          console.log(this.departments)
          this.departments = this.departmentByBranch
        }
      })
      this.filter()
    }, 500),
    ChangeDepartment: debounce(function () {
      this.placeholderPosition = 'Chọn chức vụ'
      this.positionActiveByDepartment = true
      this.filter()
    }, 500),
    filter () {
      this.$refs[this.dataViewName].$emit('reload')
    },
    // xóa user
    removeConfirm (id) {
      this.idUser = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteUser({
          id: this.idUser,
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
    this.dataViewHeight = this.$refs.laylout.clientHeight - 210
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
    this.getBranchForUser()
    this.fetchPosition()
    this.fetchContract()
  }
}
</script>
<style scoped>
.v-toolbar__content{
  height: 80px !important;
}
</style>

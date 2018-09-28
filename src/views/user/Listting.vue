<template>
  <v-layout ref="laylout" column fill-height>
    <div ref="header">
      <v-toolbar dense color="white" flat>
        <v-btn v-if="canAccess('user.create')" class="mr-3 mt-3" icon color="primary" @click="$router.push({name: 'user-create'})">
          <v-icon>add</v-icon>
        </v-btn>
        <v-flex xs3>
          <v-text-field
          hide-details
          single-line
          placeholder="Nhập tên, sđt, email ..."
          v-model="params.q"
          @keyup="changeSearch"
          clearable
          ></v-text-field>
        </v-flex>
        <v-flex xs3>
          <v-select
          class='ml-2'
          @change="changeBranch"
          placeholder="Chi nhánh"
          :items="branchAll"
          item-text="name"
          item-value="id"
          v-model="params.branch_id"
          menu-props="auto"
          hide-details
          single-line
          ></v-select>
        </v-flex>
        <v-flex xs3>
          <v-select
          :disabled = "!departmentActiveByBranch"
          class='ml-2'
          @change="filter"
          placeholder="Phòng ban"
          :items="departments"
          item-text="name"
          item-value="id"
          v-model="params.department_id"
          menu-props="auto"
          hide-details
          single-line
          ></v-select>
        </v-flex>
        <v-flex xs3>
          <v-select
          class='ml-2'
          @change="filter"
          placeholder="Chức vụ"
          :items="branchAll"
          item-text="name"
          item-value="id"
          v-model="params.position"
          menu-props="auto"
          hide-details
          single-line
          ></v-select>
        </v-flex>
        <v-layout slot="extension" v-if="!isMini">
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
          <v-flex sm1 class="text-bold text-uppercase">
            Ngày sinh
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
              <v-flex sm2 :class="isMini && 'd-none'" v-if="item.departments.data">
                <v-flex v-for="department in item.departments.data">
                  {{ department.name }}
                </v-flex>
              </v-flex>
              <v-flex sm2 :class="isMini && 'd-none'" v-if="item.departments.data">
                <v-flex v-for="department in item.departments.data">
                  {{ department.position_name }}
                </v-flex>
              </v-flex>
              <v-flex sm2 :class="isMini && 'd-none'">
                {{ item.date_of_birth }}hợp đồng
              </v-flex>
              <v-flex sm1 :class="isMini && 'd-none'">
                {{ item.date_of_birth }}ngày sinh
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
</v-layout>
</template>

<script>
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
    DataView
  },
  data: () => ({
    departmentActiveByBranch: false,
    dataViewHeight: 0,
    dataViewName: 'user',
    departments: [],
    params: {
      q: '',
      branch_id: '',
      department_id: '',
      position_id: '',
      include: 'roles,departments'
    }
  }),
  computed:{
    ...mapGetters('Branch', ['branchAll']),
    ...mapGetters('Department', ['departmentByBranch'])
  },
  methods: {
    ...mapActions('User', ['getUser']),
    ...mapActions('Branch', ['getBranchForUser']),
    ...mapActions('Department', ['getDepartmentForUser']),
    userDetail (user) {
      this.getUser({ userId: user.id, params: { include: 'roles,departments' } })
      this.$router.push({name: 'user-detail', params: {id: user.id}})
    },
    changeSearch: debounce(function () {
      this.filter()
    }, 500),
    // lọc chi phòng ban theo chi nhánh
    changeBranch: debounce(function (value) {
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
    filter () {
      this.$refs[this.dataViewName].$emit('reload')
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 99
    let query = {...this.$route.query}
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
  created(){
    this.getBranchForUser()
  }
}
</script>

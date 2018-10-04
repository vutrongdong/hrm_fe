<template>
  <v-layout row wrap align-center style="margin-top: 20px;">
    <!-- branch,department,position -->
    <v-flex row wrap sm12>
      <h3>Chi nhánh, phòng ban, chức vụ
        <v-tooltip right>
          <v-btn slot="activator" class="mr-3"
          icon color="primary"
          @click="addDepartment">
          <v-icon>add</v-icon> </v-btn>
          <span>Thêm chức vụ</span>
        </v-tooltip></h3>
      </v-flex>
      <v-layout row wrap :key="index" v-for="(department, index) in user.departments">
        <v-flex md4>
          <v-tooltip bototm>
            <v-select
            slot="activator"
            v-model="user.departments[index].branch_id"
            label="Chi nhánh"
            :items="branchAll"
            item-text="name"
            item-value="id"
            :error-messages="errors.has('branch_id') ? errors.collect('branch_id') : []"
            name="branch_id"
            placeholder="Chi nhánh"
            single-line
            @change= "changeBranch"
            ></v-select>
            <span>Chọn chi nhánh</span>
          </v-tooltip>
        </v-flex>
        <v-spacer></v-spacer>
        <!-- department -->
        <v-flex md4 id="position">
          <v-tooltip bottom>
            <v-select
            slot="activator"
            v-model="user.departments[index].department_id"
            label="Phòng ban"
            :disabled="!departmentActive"
            :items="getDepartmentByBranch(user.departments[index].branch_id)"
            item-text="name"
            item-value="id"
            :error-messages="errors.has ('department_id') ? errors.collect('department_id') : []"
            name="department_id"
            placeholder="Phòng ban"
            single-line
            @change="changeDepartment"></v-select>
            <span>Chọn phòng ban</span>
          </v-tooltip>
        </v-flex>
        <v-spacer></v-spacer>
        <!-- postion -->
        <v-flex md3>
          <v-tooltip bottom>
            <v-select
            slot="activator"
            v-model="user.departments[index].position_id"
            :items="positionAll"
            :disabled="!positionActive"
            item-text="name"
            item-value="id"
            :error-messages="errors.has('position_id') ? errors.collect('position_id') : []"
            name="position_id"
            placeholder="Chức vụ"
            single-line
            @change="changePosition"></v-select>
            <span>Chọn chức vụ</span>
          </v-tooltip>
        </v-flex>
        <v-tooltip bottom>
          <v-btn slot="activator"
          style="margin-top:10px;"
          icon color="error"
          @click="deleteDepartment(index)">
          <v-icon>delete</v-icon>
        </v-btn>
        <span>Xóa</span>
      </v-tooltip>
    </v-layout>
  </v-layout>
</template>
<script>
import { filter } from 'lodash'
import { mapGetters, mapActions } from 'vuex'
export default {
  name: 'UserFormSub',
  data () {
    return {
      departments: [],
      departmentActive: false,
      positionActive: false,
      user: {
        departments: []
      }
    }
  },
  props: {
    index: {
      type: Number,
      default: 0
    },
    dataUser: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  watch: {
    dataUser (val) {
      this.setInitData()
    }
  },
  computed: {
    ...mapGetters('Branch', ['branchAll']),
    ...mapGetters('Department', ['departmentByBranch']),
    ...mapGetters('Position', ['positionAll'])
  },
  methods: {
    ...mapActions(['fetchApi']),
    ...mapActions('Position', ['fetchPosition']),
    ...mapActions('Branch', ['getBranchForUser']),
    ...mapActions('Department', ['getDepartmentForUser']),
    addDepartment () {
      this.user.departments.push({})
    },
    deleteDepartment (index) {
      this.user.departments.splice(index, 1)
      this.emitDepartment()
    },
    changeBranch () {
      // nếu branch thay đổi thì select box của department không bị disable
      this.departmentActive = true
    },
    changeDepartment () {
      this.positionActive = true
      this.emitDepartment()
    },
    getDepartmentByBranch (branchId) {
      let array = []
      if (this.departments.length) {
        array = filter(this.departments, function (o) { return parseInt(o.branch_id) === parseInt(branchId) })
      }
      return array
    },
    changePosition () {
      this.emitDepartment()
    },
    // thực hiện emit khi có sự thay đổi về dữ liệu
    emitDepartment () {
      this.$emit('positionAndDepartment', this.user.departments)
    },
    setInitData () {
      let dataUser = { ...this.dataUser }
      this.user = { ...this.user, ...dataUser }
      // nếu mảng dataUser.departments không có gía trị thì push thêm một mảng rỗng
      if (this.dataUser.departments.data) {
        this.departmentActive = true
        this.positionActive = true
        this.user.departments = this.dataUser.departments.data.length ? this.user.departments.data : [{}]
        if (this.user.departments.length) {
          this.user.departments.map((item) => {
            item.department_id = item.id
            return item
          })
        }
      }
    }
  },
  mounted () {
    if (!this.dataUser.departments.data) {
      this.user.departments.push({})
    }
  },
  created () {
    this.fetchApi({
      url: 'departments',
      method: 'GET',
      params: {
        limit: -1
      },
      success: (response) => {
        this.departments = response.data
        // console.log("fadf",response.data)
      }
    })
    this.getBranchForUser()
    this.fetchPosition()
    !!this.dataUser && this.setInitData()
  }
}
</script>

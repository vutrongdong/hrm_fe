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
          <label>Chi nhánh</label>
          <v-select
          v-model="user.departments[index].branch_id"
          label="Chi nhánh"
          v-if="Array.isArray(branchAll)"
          :items="branchAll"
          item-text="name"
          item-value="id"
          :error-messages="errors.has('branch_id') ? errors.collect('branch_id') : []"
          name="branch_id"
          placeholder="Thuộc chi nhánh"
          single-line
          @change= "changeBranch"
          ></v-select>
        </v-flex>
        <v-spacer></v-spacer>
        <!-- department -->
        <!-- :items="getBranch(user.departments[index].branch_id)" -->
        <v-flex md4>
          <label>Phòng ban</label>
          <v-select
          v-model="user.departments[index].id"
          label="Phòng ban"
          :disabled="!departmentActive"
          :items="departmentByBranch"
          item-text="name"
          item-value="id"
          :error-messages="errors.has ('department_id') ? errors.collect('department_id') : []"
          name="department_id"
          placeholder="Thuộc phòng ban"
          single-line
          @change="changeDepartment"></v-select>
        </v-flex>
        <v-spacer></v-spacer><v-flex md3>
          <!-- postion -->
          <label>Chức vụ</label>
          <v-select
          v-model="user.departments[index].position_id"
          :items="positionAll"
          :disabled="!positionActive"
          item-text="name"
          item-value="id"
          :error-messages="errors.has('position_id') ? errors.collect('position_id') : []"
          name="position_id"
          placeholder="Vị trí"
          single-line
          @change="changePosition"></v-select></v-flex>
          <v-tooltip bottom>
            <v-btn slot="activator" style="margin-top:35px;"
            icon color="error"
            @click="deleteDepartment(index)">
            <v-icon>delete</v-icon></v-btn>
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
      objectDepartment: {
        branch_id: null,
        department_id: null,
        position_id: null
      },
      departments: [],
      departmentActive: false,
      positionActive: false,
      valDepartment: null,
      valPosition: null,
      user: {
        departments: [
          {
            branch_id: null,
            department_id: null,
            position_id: null
          }
        ]
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
      console.log(1223, this.user)
      this.user.departments.push({
        branch_id: null,
        department_id: null,
        position_id: null
      })
    },
    deleteDepartment (index) {
      this.user.departments.splice(index, 1)
    },
    changeBranch (value) {
      // nếu branch thay đổi thì select box của department không bị disable
      this.departmentActive = true
      if (this.dataUser.departments.data) {
        let array = [...this.user.departments]
        let filters = filter(array, function (object) { return object.branch_id = value })
        return filters
      } else {
        this.getDepartmentForUser({
          branchId: value,
          params: { include: 'departments' },
          cb: () => {
            this.departments = this.departmentByBranch
          }
        })
      }
    },
    getBranch (value) {
      let array = [...this.user.departments]
      let filters = filter(array, function (object) { return object.branch_id = value })
      return filters
    },
    changeDepartment (value) {
      this.valDepartment = value
      this.positionActive = true
    },
    changePosition (value) {
      this.valPosition = value
      this.objectDepartment['department_id'] = this.valDepartment
      this.objectDepartment['position_id'] = this.valPosition
      this.$emit('positionAndDepartment', this.objectDepartment)
    },
    setInitData () {
      // nếu department thay đổi thì select box của //
      let dataUser = { ...this.dataUser }
      this.user = { ...this.user, ...dataUser }
      // nếu mảng dataUser.departments không có gía trị thì push thêm một mảng rỗng
      if (this.dataUser.departments.data) {
        this.user.departments = this.dataUser.departments.data.length ? this.user.departments.data : [
          {
            branch_id: null,
            department_id: null,
            position_id: null
          }
        ]
      } else {
        this.user.departments.push({})
      }
    }
  },
  mounted () {
    this.fetchApi({
      url: 'departments',
      method: 'GET',
      params: {
        limit: -1
      },
      success: (response) => {
        this.departments = response.data
      }
    })
    this.getDepartmentForUser({
      branchId: 5,
      params: { include: 'departments' },
      cb: () => {
        this.departments = this.departmentByBranch
      }
    })
  },
  created () {
    this.getBranchForUser()
    this.fetchPosition()
    !!this.dataUser && this.setInitData()
    if (this.$route.params.id) {
      if (this.dataUser.departments.data[this.index]) {
        this.departmentActive = true
        this.positionActive = true
      }
    }
  }
}
</script>

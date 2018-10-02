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
        <v-flex md4 id="position">
          <label>Phòng ban</label>
          <v-select
          v-model="user.departments[index].department_id"
          label="Phòng ban"
          :disabled="!departmentActive"
          :items="departments[user.departments[index].branch_id]"
          item-text="name"
          item-value="department_id"
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
            <v-icon>delete</v-icon>
          </v-btn>
          <span>Xóa</span>
        </v-tooltip>
      </v-layout>
    </v-layout>
  </template>
<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  name: 'UserFormSub',
  data () {
    return {
      departments: {},
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
    // dataUser (val) {
    //   this.user = val
    // }
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
    changeBranch (value) {
      // nếu branch thay đổi thì select box của department không bị disable
      this.departmentActive = true
    },
    changeDepartment (value) {
      this.positionActive = true
      this.emitDepartment()
    },
    changePosition (value) {
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
      } else {
        this.user.departments.push({})
      }
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
        const items = response.data
        items.forEach(item => {
          if (!this.departments[item.branch_id]) {
            this.departments[item.branch_id] = []
          }
          this.departments[item.branch_id].push(item)
        })
      }
    })
    this.getBranchForUser()
    this.fetchPosition()
    !!this.dataUser && this.setInitData()
  }
}
</script>

 <template>
  <v-layout row wrap align-center style="margin-top: 20px;">
    <!-- branch -->
    <v-flex md4>
      <label>Chi nhánh</label>
      <v-select
      v-model="objectDepartment.branch_id"
      label="Chi nhánh"
      v-if="Array.isArray(branchAll)"
      :items="branchAll"
      item-text="name"
      item-value="id"
      :error-messages="errors.has('branch_id') ? errors.collect('branch_id') : []"
      name="branch_id"
      placeholder="Thuộc chi nhánh"
      single-line
      @change="changeBranch"
      ></v-select>
    </v-flex>
    <v-spacer></v-spacer>
    <!-- department -->
    <v-flex md4>
      <label>Phòng ban</label>
      <v-select
      v-model="objectDepartment.department_id"
      label="Phòng ban"
      :disabled="!departmentActive"
      :items="departments"
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
      <label>Bộ phận</label>
      <v-select
      v-model="objectDepartment.position_id"
      v-if="Array.isArray(positionAll)"
      :items="positionAll"
      :disabled="!positionActive"
      item-text="name"
      item-value="id"
      :error-messages="errors.has('position_id') ? errors.collect('position_id') : []"
      name="position_id"
      placeholder="Vị trí"
      single-line
      @change="changePosition"></v-select></v-flex>
      <v-btn style="margin-top:15px;"
      icon color="error"
      @click="$emit('delete')">
      <v-icon>delete</v-icon></v-btn>
    </v-layout>
  </template>
<script>
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
      user: {}
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
      console.log(val)
      this.user = val
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
    changeBranch (value) {
      this.departmentActive = true
      this.getDepartmentForUser({
        branchId: value,
        params: { include: 'departments' },
        cb: () => {
          this.departments = this.departmentByBranch
        }
      })
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
      let dataUser = { ...this.dataUser }
      this.user = { ...this.user, ...dataUser }
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
      branchId: 1,
      params: { include: 'departments' },
      cb: () => {
        this.departments = this.departmentByBranch
      }
    })
  },
  created () {
    // this.getBranchForUser()
    this.fetchPosition()
    !!this.dataUser && this.setInitData()
    if (this.$route.params.id) {
      if (this.dataUser.departments.data[this.index]) {
        this.departmentActive = true
        this.positionActive = true
        this.objectDepartment.department_id = this.dataUser.departments.data[this.index].id
        this.objectDepartment.branch_id = this.dataUser.departments.data[this.index].branch_id
        this.objectDepartment.position_id = this.dataUser.departments.data[this.index].position_id
      }
    }
  }
}
</script>

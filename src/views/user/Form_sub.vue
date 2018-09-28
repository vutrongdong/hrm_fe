 <template>
  <v-layout row wrap align-center style="margin-top: 20px;">
    <!-- branch,department,position -->
    <h3>Chi nhánh, phòng ban, vị trí
      <v-btn class="mr-3"
      icon color="primary"
      @click="Add">
      <v-icon>add</v-icon> </v-btn> </h3>
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

          ></v-select>
        </v-flex>
        <v-spacer></v-spacer>
        <!-- department -->
        <v-flex md4>
          <label>Phòng ban</label>
          <v-select
          v-model="user.departments[index].id"
          label="Phòng ban"
          :disabled="!departmentActive"
          :items="getBranch(user.departments[index].branch_id)"
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
          <label>Vị trí</label>
          <v-select
          v-model="user.departments[index].position_id"
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
          <v-btn style="margin-top:35px;"
          icon color="error"
          @click="Delete(index)">
          <v-icon>delete</v-icon></v-btn>
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
    Add () {
      this.user.departments.push({
        branch_id: null,
        department_id: null,
        position_id: null
      })
    },
    Delete (index) {
      this.user.departments.splice(index, 1)
    },
    changeBranch (value) {
      let array = [...this.user.departments]
      let filters = filter(array, function (object) { return object.branch_id = value })
      return filters
      // this.getDepartmentForUser({
      //   branchId: value,
      //   params: { include: 'departments' },
      //   cb: () => {
      //     this.departments = this.departmentByBranch
      //   }
      // })
    },
    getBranch (value) {
      let array = [...this.user.departments]
      let filters = filter(array, function (object) { return object.branch_id = value })
      return filters
    },
    changeDepartment (value) {
      // this.valDepartment = value
      // this.positionActive = true
    },
    changePosition (value) {
      // this.valPosition = value
      // this.objectDepartment['department_id'] = this.valDepartment
      // this.objectDepartment['position_id'] = this.valPosition
      // this.$emit('positionAndDepartment', this.objectDepartment)
    },
    setInitData () {
      let dataUser = { ...this.dataUser }
      this.user = { ...this.user, ...dataUser }
      this.user.departments = this.dataUser.departments.data
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

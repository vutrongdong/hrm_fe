<template>
  <v-container style="margin-top:-35px">
    <v-layout row wrap align-center>
      <!-- branch -->
      <v-flex md4>
        <v-select
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
        <v-select
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
        <v-select
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
        <v-btn style="margin-top:-5px;"
        icon color="error"
        @click="$emit('delete')">
        <v-icon>delete</v-icon></v-btn>
    </v-layout>
  </v-container>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  name: 'UserFormSub',
  data () {
    return {
      object: {
        id: Date.now()
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
    dataUser: {
      type: Object,
      default: () => {
        return {
          departments: []
        }
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
    ...mapActions('Position', ['positionForUser']),
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
      this.object['department_id'] = this.valDepartment
      this.object['position_id'] = this.valPosition
      this.$emit('positionAndDepartment', this.object)
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
    if (this.$route.params.id) {
      this.departmentActive = true
      this.positionActive = true
    }
    this.getBranchForUser()
    this.positionForUser()
    !!this.dataUser && this.setInitData()
  }
}
</script>

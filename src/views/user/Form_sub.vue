<template>
  <v-container fluid style="margin-top:-35px">
    <v-layout row wrap align-center>
      <v-flex md3>
        <v-select
        v-if="Array.isArray(branchAll)"
        :items="branchAll"
        item-text="name"
        item-value="id"
        :error-messages="errors.has('branch_id') ? errors.collect('branch_id') : []
        " name= "branch_id"
        placeholder="Thuộc chi nhánh"
        single-line
        @change="changedBranch"
        ></v-select>
      </v-flex>
      <v-spacer></v-spacer>

    <v-flex md3>
        <v-select
        :items="departments"
        :disabled="!departments"
        item-text="name"
        item-value="id"
        :error-messages="errors.has ('department_id') ? errors.collect('department_id') : []"
        name="department_id"
        placeholder="Thuộc phòng ban"
        single-line
        @change="changeDepartment"> </v-select>
    </v-flex>
    <v-spacer></v-spacer>

    <v-flex md3>
     <v-select
     v-if="Array.isArray(positionAll)"
     :items="positionAll"
     item-text="name"
     item-value="id"
     :error-messages="errors.has('position_id') ? errors.collect('position_id') : []"
     name="position_id"
     placeholder="Vị trí"
     single-line
     @change="changePosition"></v-select>
   </v-flex>
   <v-spacer></v-spacer>
   <v-btn style="margin-top:-5px;" icon color="error" @click="$emit('delete')"><v-icon>delete</v-icon></v-btn>
   <v-btn class="mr-3" style="margin-top:-5px;" icon color="primary" @click="$emit('add')">
    <v-icon>add</v-icon>
  </v-btn>
  <v-spacer></v-spacer>
</v-layout>
</v-container>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  name: 'UserFormSub',
  data () {
    return {
      user: {
      },
      departments: []
    }
  },
  props: {
    dataUser: {
      type: Object,
      default: () => {
        return {
        }
      }
    },
    id: {
      type: Number,
      require: true
    }
  },
  computed: {
    ...mapGetters('Branch', ['branchAll']),
    ...mapGetters('Department', ['departmentByBranch']),
    ...mapGetters('Position', ['positionAll'])
  },
  methods: {
    ...mapActions(['fetchApi']),
    ...mapActions('Position', ['PositionForUser']),
    ...mapActions('Branch', ['getBranchForUser']),
    ...mapActions('Department', ['getDepartmentForUser']),
    changedBranch (value) {
      this.getDepartmentForUser({
        branch_id: value,
        params: { include: 'departments' },
        cb: () => {
          this.departments = this.departmentByBranch
        }
      })
    },
    changeDepartment (value) {
      this.$emit('changeDepartment', value)
    },
    changePosition (value) {
      this.$emit('changePosition', value)
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
        this.department_user = response.data
      }
    })
  },
  created () {
    this.getBranchForUser()
    this.PositionForUser()
    !!this.dataUser && this.setInitData()
  }
}
</script>

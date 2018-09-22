<template>
  <v-container fluid style="margin-top:-35px">
    <v-layout row wrap align-center>
<<<<<<< HEAD
      <!-- branch -->
=======
>>>>>>> origin/dev
      <v-flex md3>
        <v-select
        v-if="Array.isArray(branchAll)"
        :items="branchAll"
        item-text="name"
        item-value="id"
<<<<<<< HEAD
        :error-messages="errors.has('branch_id') ? errors.collect('branch_id') : []"
        name="branch_id"
        placeholder="Thuộc chi nhánh"
        single-line
        @change="changeBranch"
        ></v-select>
      </v-flex>
      <v-spacer></v-spacer>
      <!-- department -->
      <v-flex md3>
        <v-select
        :disabled="!departmentActive"
        :items="departments"
=======
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
>>>>>>> origin/dev
        item-text="name"
        item-value="id"
        :error-messages="errors.has ('department_id') ? errors.collect('department_id') : []"
        name="department_id"
        placeholder="Thuộc phòng ban"
        single-line
<<<<<<< HEAD
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
        <v-spacer></v-spacer>
        <v-btn style="margin-top:-5px;"
        icon color="error"
        @click="$emit('delete')">
        <v-icon>delete</v-icon></v-btn>
        <v-btn class="mr-3"
        style="margin-top:-5px;"
        icon color="primary"
        @click="add">
        <v-icon>add</v-icon>
      </v-btn>
      <v-spacer></v-spacer>
    </v-layout>
  </v-container>
=======
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
>>>>>>> origin/dev
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  name: 'UserFormSub',
  data () {
    return {
<<<<<<< HEAD
      departments: [],
      departmentActive: false,
      positionActive: false,
      valDepartment: null,
      valPosition: null
=======
      user: {
      },
      departments: []
>>>>>>> origin/dev
    }
  },
  props: {
    dataUser: {
      type: Object,
      default: () => {
        return {
<<<<<<< HEAD
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
      branch_id: value,
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
    let object = {}
    object['department_id'] = this.valDepartment
    object['position_id'] = this.valPosition
    this.$emit('positionAndDepartment', object)
  },
  setInitData () {
    let dataUser = { ...this.dataUser }
    this.user = { ...this.user, ...dataUser }
  },
  add(){
    this.$emit('add')
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
},
mounted(){
  this.getDepartmentForUser({
    branch_id:1,
    params: { include: 'departments' },
    cb: () => {
      this.departments = this.departmentByBranch
    }
  })
},
created () {
  if(this.$route.params.id){
    this.departmentActive=true,
    this.positionActive=true
  }
  this.getBranchForUser()
  this.positionForUser()
  !!this.dataUser && this.setInitData()
}
=======
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
>>>>>>> origin/dev
}
</script>

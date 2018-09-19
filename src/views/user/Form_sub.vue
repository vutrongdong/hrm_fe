<template>
  <v-container fluid style="margin-top:-35px">
    <v-layout row wrap align-center>
      <v-flex md3>
        <v-select v-if="Array.isArray(branchAll)" :items="branchAll"item-text="name"item-value="id" :error-messages="errors.has('branch_id') ? errors.collect('branch_id') : []"name="branch_id" placeholder="Thuộc chi nhánh"single-line @change="changedBranch"> </v-select>
      </v-flex>
      <v-spacer></v-spacer>
      <v-flex md3>
        {{ DepartmentByBranch }}
        <!-- v-if="Array.isArray(DepartmentByBranch)" -->
   <!--      <v-select  v-model="department_user.department_id":items="branchAll" item-text="name" item-value="id" :error-messages="errors.has('department_id') ? errors.collect('department_id') : []"name="department_id" placeholder="Thuộc phòng ban" single-line > </v-select> -->

        <!-- <v-select v-else v-model="department_user.department_id" item-text="name" item-value="id" name="department_id" placeholder="Chọn chi nhánh trước" single-line disabled > </v-select> -->
      </v-flex>
    </v-flex>
    <v-spacer></v-spacer>
    <v-flex md3>
     <v-select v-if="Array.isArray(positionAll)" v-model="department_user.position_id":items="positionAll"item-text="name" item-value="id" :error-messages="errors.has('position_id') ? errors.collect('position_id') : []" name="position_id" placeholder="Vị trí"single-line > </v-select>
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
  data () {
    return {
      department_user:{
        department_id:'',
        position_id:''
      },
    }
  },
  props:{
    DepartmentUser: {
      type: Array,
      default: () => {
        return {
          department_id:'',
          position_id:''
        }
      }
    }
  },
  computed: {
    ...mapGetters('Branch', ['branchAll','DepartmentByBranch']),
    ...mapGetters('Position', ['positionAll'])
  },
  methods:{
    ...mapActions('Position', ['PositionForUser']),
    ...mapActions('Branch', ['getBranchForUser','getDepartmentForUser']),
    changedBranch(value){

      this.getDepartmentForUser({
        branch_id: value
        // params: { include: 'departments' }
      })
    }
  },
  mounted(){
   // this.getDepartmentForUser()
  },
  created () {
    this.getBranchForUser()
    this.PositionForUser()
  }
}
</script>

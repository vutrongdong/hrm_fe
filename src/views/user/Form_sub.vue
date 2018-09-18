<template>
  <v-container fluid style="margin-top:-35px">
    <v-layout row wrap align-center>
      <v-flex md5>
        <v-select v-if="Array.isArray(departmentAll)" v-model="user.department_id":items="departmentAll"item-text="name"item-value="id" v-validate="'required'" :error-messages="errors.has('department_id') ? errors.collect('department_id') : []"name="department_id" placeholder="Trực thuộc phòng ban"single-line > </v-select>
      </v-flex>
      <v-spacer></v-spacer>
      <v-flex md5>
       <v-select v-if="Array.isArray(positionAll)" v-model="user.position_id":items="positionAll"item-text="name" item-value="id" v-validate="'required'" :error-messages="errors.has('department_id') ? errors.collect('department_id') : []" name="department_id" placeholder="Vị trí"single-line > </v-select>
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
      user:{},
    }
  },
  computed: {
    ...mapGetters('Department', ['departmentAll']),
    ...mapGetters('Position', ['positionAll'])
  },
  methods:{
    ...mapActions('Department', ['DepartmentForUser']),
    ...mapActions('Position', ['PositionForUser'])
  },
  created () {
    this.DepartmentForUser()
    this.PositionForUser()
  }
}
</script>

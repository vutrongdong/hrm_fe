<template>
  <v-container fluid style="margin-top:-35px">
    <v-layout row wrap align-center>
      <v-flex md3>
        <v-select
        v-if="Array.isArray(departmentAll)"
        :items="departmentAll"
        item-text="name"
        item-value="id"
        :error-messages="errors.has('branch_id') ? errors.collect('branch_id') : []
        " name= "branch_id"
        placeholder="Thuộc chi nhánh"
        label="ngày nộp đơn"
        single-line
        ></v-select>
      </v-flex>
      <v-spacer></v-spacer>
    <v-flex md3>
        <v-select
         v-if="Array.isArray(positionAll)"
        :items="positionAll"
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
    <!--  <v-select
     v-if="Array.isArray(positionAll)"
     :items="positionAll"
     item-text="name"
     item-value="id"
     :error-messages="errors.has('position_id') ? errors.collect('position_id') : []"
     name="position_id"
     placeholder="Vị trí"
     single-line
     @change="changePosition"></v-select> -->
        <v-text-field
        :error-messages="errors.has('content') ? errors.collect('content') : []"
        v-validate="'required|min:3'"
        :data-vv-as="$t('label.content')"
         name="content"
        :label="$t('label.content') + ' *'"
          >
        </v-text-field>
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
      plan: {
        plan_id: ''

      },
      departments: []
    }
  },
  props: {
    dataPlan: {
      type: Array,
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
    ...mapGetters('Department', ['departmentAll']),
    ...mapGetters('Position', ['positionAll'])
  },
  methods: {
    ...mapActions(['fetchApi']),
    ...mapActions('Position', ['PositionForUser']),
    ...mapActions('Department', ['departmentForPlan']),
    changeDepartment (value) {
      this.$emit('changeDepartment', value)
    },
    changePosition (value) {
      this.$emit('changePosition', value)
    },
    setInitData () {
      let dataPlan = { ...this.dataPlan }
      this.plan = { ...this.plan, ...dataPlan }
    }
  },
  created () {
    this.departmentForPlan()
    this.PositionForUser()
    !!this.dataUser && this.setInitData()
  }
}
</script>

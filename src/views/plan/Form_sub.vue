<template>
    <v-container>
    <v-layout row wrap align-center>
      <!-- branch -->
      <v-flex md3 style="margin-right: 26px;">
        <label><b> Chức vụ </b></label>
        <v-select
        v-if="Array.isArray(positionAll)"
        :items="positionAll"
        item-text="name"
        item-value="id"
        :error-messages="errors.has('position_id') ? errors.collect('position_id') : []"
        name="position_id"
        placeholder="Thuộc vi tri"
        :label="$t('label.position_id') + ' *'"
        single-line
        @change="changePosition"
        ></v-select>
        </v-flex>

         <v-flex md3 style="margin-right: 26px;">
          <label><b> Bộ phận </b></label>
        <v-select
        v-if="Array.isArray(departmentDetail)"
        :items="departmentDetail"
        item-text="name"
        item-value="id"
        :error-messages="errors.has('position_id') ? errors.collect('position_id') : []"
        name="position_id"
        placeholder="Thuộc vi tri"
        :label="$t('label.position_id') + ' *'"
        single-line
        @change="changeDepartment"
        ></v-select>
        </v-flex>
        <v-flex md3 style="margin-right: 26px;">
          <label><b> số lượng </b></label>
         <v-text-field
          :error-messages="errors.has('quantity') ? errors.collect('quantity') : []"
          v-validate="'required'"
          :data-vv-as="$t('label.quantity')"
          name="quantity"
          v-model="quantity"
          @change="changeQuantity"
          >
        </v-text-field>
        </v-flex>

        <v-btn style="margin-top:-5px;"
        icon color="error"
        @click="$emit('delete')">
        <v-icon>delete</v-icon></v-btn>
    </v-layout>
  </v-container>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
export default{
  name: 'PlanFormSub',
  data () {
    return {
      object: {
        id: Date.now()
      },
      quantity: '',
      departments: [],
      departmentActive: false,
      positionActive: false,
      quantityActive: false,
      valDepartment: null,
      valPosition: null,
      valQuantity: null,
      plan: {}
    }
  },
  props: {
    dataPlan: {
      type: Object,
      default: () => {
        return {
          departments: []
        }
      }
    }
  },
  computed: {
    ...mapGetters('Department', ['departmentDetail']),
    ...mapGetters('Position', ['positionAll'])
  },
  methods: {
    ...mapActions(['fetchApi']),
    ...mapActions('Department', ['fetchDepartment']),
    ...mapActions('Position', ['fetchPosition']),
    changePosition (value) {
      this.valPosition = value
      this.positionActive = true
    },
    changeQuantity (value) {
      this.valQuantity = this.quantity
      console.log('data', this.valQuantity)
      this.quantityActive = true
    },
    changeDepartment (value) {
      this.valDepartment = value
      this.object['department_id'] = this.valDepartment
      this.object['position_id'] = this.valPosition
      this.object['quantity'] = this.valQuantity
      this.$emit('positionAndDepartment', this.object)
    },
    setInitData () {
      let dataPlan = {...this.dataPlan}
      this.plan = {...this.plan, ...dataPlan}
    }

  },
  created () {
    if (this.$route.params.id) {
      this.departmentActive = true
      this.positionActive = true
    }
    this.fetchDepartment()
    this.fetchPosition()
    !!this.dataPlan && this.setInitData()
  }

}
</script>
<style type="text/css" scope>
  .v-input.v-text-field{
        margin-top: -3px;
  }
</style>

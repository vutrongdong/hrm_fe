<template>
  <v-form @submit.prevent="validateBeforeSubmit">
    <v-text-field
      :error-messages="errors.has('name') ? errors.collect('name') : []"
      v-validate="'required|min:3'"
      :data-vv-as="$t('label.name')"
      name="name"
      :label="$t('label.name') + ' *'"
      v-model="position.name">
    </v-text-field>
    <v-select v-validate="'required'"
              :error-messages="errors.has('status') ? errors.collect('status') : []"
               :data-vv-as="$t('label.status')" name="status" :label="$t('label.status')"
                v-model="position.status" :items="items" item-value="id" item-text="name">
    </v-select>
    <v-flex xs12 text-xs-center>
      <v-btn
        :loading="isFetchingApi"
        :disabled="isFetchingApi"
        color="primary"
        type="submit"
        >
        <template v-if="isCreate">
          <v-icon left>add</v-icon> {{$t('control.create')}}
        </template>
        <template v-else>
          <v-icon left>save</v-icon> {{$t('control.save')}}
        </template>
      </v-btn>
    </v-flex>
  </v-form>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import { map, chain } from 'lodash'
export default{
  name: 'RoleForm',
  computed: {
    ...mapGetters(['isFetchingApi', 'allPermission']),
    isCreate () {
      return this.type === 'create'
    }
  },
  props: {
    type: {
      type: String,
      default: 'create'
    },
    dataPosition: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  data () {
    return {
      position: {
        name: '',
        status: ''
      },
      items: [
        {
          'id': '',
          'name': '-- Su lua chon ---'
        },
        {
          'id': 1,
          'name': 'Hiển thị'
        },
        {
          'id': 0,
          'name': 'Không hiển thị'
        }
      ]
    }
  },
  methods: {
    ...mapActions(['fetchApi']),
    setInitData () {
      let dataPosition = { ...this.dataPosition }
      this.position = { ...this.position, ...dataPosition }
    },
    validateBeforeSubmit () {
      this.$validator.validateAll().then(result => {
        if (result) {
          let submitData = { ...this.position }
          this.$emit('submit', submitData)
        } else {
          this.$store.dispatch('showNotify', {
            text: this.$t('alert.invalid'),
            color: 'warning'
          })
        }
      })
    }
  },
  created () {
    !!this.dataPosition && this.setInitData()
  }
}
</script>

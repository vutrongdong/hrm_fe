<template>
    <v-layout ref="laylout" column fill-height>
      <div ref="header">
          <v-toolbar dense color="white" flat>
             <v-btn v-if="canAccess('department.create')"
               class="mr-3 mt-3" icon
               color="primary"
               @click="$router.push({name: 'department-create'})">
          <v-icon>add</v-icon>
        </v-btn>
                    <v-flex xs6>
                      <v-text-field
                        class="pa-2"
                        hide-details
                        single-line
                        placeholder="Xin vui lòng nhập tên phòng ban"
                        clearable
                      ></v-text-field>
              </v-flex>
              <v-flex xs6>
                       <v-autocomplete
                       class="pa-3"
                       v-if="Array.isArray(branchAll)"
                       :items="branchAll"
                       item-value="id"
                       item-text="name"
                       placeholder="Xin vui lòng chọn phòng ban"
                      >
                      </v-autocomplete>
              </v-flex>
          </v-toolbar>
    </div>

    </v-layout>
</template>
<script type="text/javascript">
import { debounce } from 'lodash'
import DataView from '@/components/DataView/DataView'
import DialogConfirm from '@/components/DialogConfirm'
import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'DepartmentListting',
  props: {
    isBoolean: {
      type: Boolean,
      default: false
    }
  },
  components: {
    DataView,
    DialogConfirm
  },
  data: () => ({
    idDepartment: null,
    dataViewHeight: 0,
    dialogDelete: false,
    dataViewName: 'departments',
    params: {
      q: ''
    }
  }),

  computed: {
      ...mapGetters('Branch', ['branchAll']),
      ...mapGetters(['isFetchingApi'])
  },
  created () {
    this.getBranchs()
  },
  methods: {
        ...mapActions('Branch',['getBranchs'])
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 90
    let query = { ...this.$route.query }
    if (query.hasOwnProperty('reload')) {
      this.$nextTick(() => {
        this.$refs[this.dataViewName].$emit('reload')
      })
      delete query.reload
      this.$router.replace({
        query: query
      })
    }
  }

}
</script>

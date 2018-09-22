<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs12 class="border-e0-left">
      <data-view
      :name="dataViewName"
      api-url="settings"
      v-if="dataViewHeight"
      :viewHeight="dataViewHeight"
      :params="params"
      :ref="dataViewName"
      >
      <template slot-scope="{items}">
        <v-toolbar dense color="white" flat>
          <h1>{{ $t('title.setting.detail') }} công ty</h1>
          <v-spacer></v-spacer>
          <v-menu :nudge-width="100" offset-y>
        </v-menu>
        <v-btn v-if="canAccess('setting.create')" class="mr-3" icon color="primary" @click="$router.push({name: 'setting-create'})">
          <v-icon>add</v-icon>
        </v-btn>
        <v-text-field
        hide-details
        single-line
        ></v-text-field>
        <v-btn icon @click="$router.push({name: 'setting'})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-list three-line>
        <template v-for="(item) in items.data">
          <div style="padding-left:30px;padding-top:12px;display:block;" :key="item.id">
            <p style="text-transform:capitalize;width:100%">{{ item.name }} : {{ item.value }} : {{item.id}}
              <span>
               <v-btn v-if="canAccess('setting.update')" icon @click="$router.push({name: 'setting-edit', params: {id: item.id}})">
                <v-icon style="float:right;position:absolute">edit</v-icon>
              </v-btn>
              <v-btn v-if="canAccess('setting.delete')" icon @click="removeConfirm(item)">
                <v-icon>delete</v-icon>
              </v-btn>
            </span>
          </p>
        <hr>
        </div>
      </template>
    </v-list>
  </template>
</data-view>
</v-flex>
</v-layout>
</template>
<script>
import DataView from '@/components/DataView/DataView'
import Listting from './Listting'
import { mapActions, mapGetters } from 'vuex'
import DialogConfirm from '@/components/DialogConfirm'
export default{
  name: 'settingDetail',
  components: {
    DataView,
    Listting,
    DialogConfirm
  },
  data () {
    return {
      dataViewName: 'setting',
      dataViewHeight: 0,
      dialogDelete: false,
      params: {
        q: ''
      }
    }
  },
  computed: {
    ...mapGetters('Setting', ['settingDetail'])
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Setting', ['FetchSetting', 'deleteSetting']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    removeConfirm (item) {
      console.log('data', item)
      // swal({
      //   title: 'Xác nhận',
      //   text: 'Bạn chắc chắn muốn xóa bản ghi này',
      //   buttons: true,
      //   dangerMode: true
      // })
      //   .then((willDelete) => {
      //     if (willDelete) {
      //       console.log('data 1', item)
      //       this.deleteSetting({
      //         id: item.id,
      //         cb: (response) => {
      //           this.removeDataviewEntry({
      //             name: 'setting',
      //             data: item,
      //             key: 'id'
      //           })
      //           this.$store.dispatch('showNotify', {
      //             text: this.$t('alert.success'),
      //             color: 'success'
      //           })
      //         },
      //         error: (error) => {
      //           if (error.status === 404) {
      //             this.$store.dispatch('showNotify', {
      //               text: this.$t('alert.not-found'),
      //               color: 'warning'
      //             })
      //           }
      //         }
      //       })
      //     }
      //   })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
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
<style scope>
p span{
  padding: 7px;
  margin-top:-25px;
  float: right;
  margin-right:10px;
}
h3{
  clear:both;
}
</style>

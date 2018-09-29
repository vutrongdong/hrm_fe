<template>
  <v-layout ref="laylout" column fill-height>
    <div ref="header">
      <v-toolbar dense color="white" flat>
        <v-btn v-if="canAccess('position.create')"
               class="mr-3 mt-3" icon
               color="primary"
               @click="$router.push({name: 'position-create'})">
          <v-icon>add</v-icon>
        </v-btn>
            <v-flex xs12>
                      <v-text-field
                        hide-details
                        single-line
                        placeholder=""
                        v-model="params.q"
                        @keyup="changeSearch"
                        clearable
                      ></v-text-field>
            </v-flex>
              </v-toolbar>
          </div>
        <v-flex xs12 class="border-e0-top">
             <data-view
                 :name="dataViewName"
                 api-url="positions"
                 v-if="dataViewHeight"
                 :viewHeight="dataViewHeight"
                 :params="params"
                 :ref="dataViewName"
             >
               <template slot-scope="{items}">
                  <v-list>
                    <v-layout row wrap pt-10>
                      <template v-for=" (item, index) in items.data">
                          <v-flex xs3 mb-15  style="margin-bottom: 13px;padding: 10px">
                            <v-card>
                              <v-card-title><h4>{{ item.name }}</h4></v-card-title>
                              <v-divider></v-divider>
                              <v-list dense>
                               <v-list-tile>
                                  <v-list-tile-content>STT :</v-list-tile-content>
                                  <v-list-tile-content class="align-end">{{ index+1 }}</v-list-tile-content>
                                </v-list-tile>

                                 <v-list-tile>
                                  <v-list-tile-content>Chức vụ :</v-list-tile-content>
                                  <v-list-tile-content class="align-end">{{ item.name }}</v-list-tile-content>
                                </v-list-tile>
                                <v-list-tile>
                                  <v-list-tile-content>Trạng thái :</v-list-tile-content>
                                  <v-list-tile-content class="align-end">{{ item.status_txt }}</v-list-tile-content>
                                </v-list-tile>

                                <v-list-tile>
                                  <v-list-tile-content>Hành động:</v-list-tile-content>
                                  <v-list-tile-content class="align-end">
                                            <v-icon v-if="canAccess('position.update')" class="mr-6"  @click="$router.push({name: 'position-edit', params: {id: item.id}})" color="green"> edit</v-icon>
                                            <v-icon v-if="canAccess('position.delete')" icon @click="removeConfirm(item.id)" color="red"> delete </v-icon>
                                </v-list-tile-content>
                                </v-list-tile>
                              </v-list>
                            </v-card>
                          </v-flex>
                      </template>
                      </v-layout>
                  </v-list>
               </template>
             </data-view>
                <dialog-confirm v-model="dialogDelete" @input="remove" />
        </v-flex>
     </v-layout>
</template>
<script type="text/javascript">
import { debounce } from 'lodash'
import DataView from '@/components/DataView/DataView'
import DialogConfirm from '@/components/DialogConfirm'
import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'PositionListting',
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
    idPosition: null,
    dataViewHeight: 0,
    dialogDelete: false,
    dataViewName: 'positions',
    params: {
      q: ''
    }
  }),
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Position', ['getPositon','deletePosition','fetchPosition']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    filter(){
        this.$refs[this.dataViewName].$emit('reload')
    },
    changeSearch : debounce(function(){
        this.filter()
    },500),
    removeConfirm(id){
        this.idPosition = id
        this.dialogDelete = true
    },
    remove(confirm){
        if (confirm) {
        this.deletePosition({
          id: this.idPosition,
          cb: (response) => {
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
          },
          error: (error) => {
            if (error.status === 404) {
              this.$store.dispatch('showNotify', {
                text: this.$t('alert.not-found'),
                color: 'warning'
              })
            }
          }
        })
      }
    }
  },

  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 49
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

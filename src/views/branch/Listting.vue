<template>
  <v-layout ref="laylout" column fill-height>
   <div ref="header">
    <v-toolbar height="50px" color="white" flat>
      <v-layout row wrap>
          <v-tooltip bottom>
            <v-btn slot="activator" v-if="canAccess('branch.create')" class="mr-3 mt-2" icon color="primary" @click="$router.push({name: 'branch-create'})">
              <v-icon>add</v-icon>
            </v-btn>
            <span>Thêm mới</span>
          </v-tooltip>
          <h2 style="margin-top: 10px;">Danh sách chi nhánh</h2>
      </v-layout>
      <v-layout slot="extension" v-if="!isMini">
        <v-flex sm1 class="text-bold text-uppercase">
          STT
        </v-flex>
        <v-flex sm4 class="text-bold text-uppercase">
          Tên chi nhánh
        </v-flex>
        <v-flex sm3 class="text-bold text-uppercase">
          Địa chỉ
        </v-flex>
        <v-flex sm2 class="text-bold text-uppercase">
          Trạng thái
        </v-flex>
        <v-flex sm2 class="text-bold text-uppercase mr-1">
          Hành động
        </v-flex>
      </v-layout>
    </v-toolbar>
  </div>
  <v-flex xs12 class="border-e0-top">
    <data-view
    :name="dataViewName"
    api-url="branches"
    v-if="dataViewHeight"
    :viewHeight="dataViewHeight"
    :params="params"
    :ref="dataViewName"
    >
    <template slot-scope="{items}">
      <v-list three-line>
        <template v-for="(item, index) in items.data">
          <v-list-tile
          :key="'item' + item.id"
          avatar
          @click="branchDetail(item)"
          :inactive="item.id === $route.params.id"
          :class="item.id === $route.params.id && 'grey lighten-2'"
          >
          <v-layout class="pa-2">
            <v-flex sm1 :class="isMini && 'd-none'">
              {{index + 1}}
            </v-flex>
            <v-flex sm4 :class="isMini && 'full-flex-basic full-max-width'">
              {{ item.name}}
              <v-list-tile-sub-title class="text--primary" v-if="item.email" :class="isMini && 'd-none'">
                <v-icon size="16px">email</v-icon>
                {{ item.email }}
              </v-list-tile-sub-title>
              <v-list-tile-sub-title class="text--primary" v-if="item.phone" :class="isMini && 'd-none'">
                <v-icon size="16px">phone</v-icon>
                {{ item.phone }}
              </v-list-tile-sub-title>
            </v-flex>
            <v-flex sm3 :class="isMini && 'd-none'">
              {{ item.address }}
            </v-flex>
            <v-flex sm2 :class="isMini && 'd-none'">
              <v-tooltip bottom sm12>
                <v-switch
                @click.native.stop="changeStatus(item.id)"
                class='ml-3'
                name="status"
                slot="activator"
                v-model="item.status"
                ></v-switch>
                <span v-if="item.status">Chi nhánh chính</span>
                <span v-else>Chi nhánh phụ</span>
              </v-tooltip>
            </v-flex>
            <v-flex sm2 :class="isMini && 'd-none'">
              <v-tooltip bottom>
                <v-btn slot="activator" class="ma-0" v-if="canAccess('branch.update')" icon @click.stop="$router.push({name: 'branch-edit', params: {id: item.id}})">
                  <v-icon class='theme--light teal--text'>edit</v-icon>
                </v-btn>
                <span>Sửa</span>
              </v-tooltip>
              <v-tooltip bottom>
                <v-btn slot="activator" class="ma-0" v-if="canAccess('branch.delete')" icon @click.stop="removeConfirm(item.id)">
                  <v-icon class="theme--light pink--text">delete</v-icon>
                </v-btn>
                <span>Xóa</span>
              </v-tooltip>
            </v-flex>
          </v-layout>
        </v-list-tile>
        <v-divider
        :key="'div' + index + item.id"
        v-if="index + 1 < items.data.length"
        ></v-divider>
      </template>
    </v-list>
    <dialog-confirm v-model="dialogDelete" @input="remove" />
</template>
</data-view>
</v-flex>
</v-layout>
</template>
<script>
import { debounce } from 'lodash'
import DialogConfirm from '@/components/DialogConfirm'
import DataView from '@/components/DataView/DataView'
import { mapActions } from 'vuex'
export default {
  name: 'BranchListting',
  components: {
    DataView,
    DialogConfirm
  },
  props: {
    type: {
      type: String,
      default: 'index'
    },
    isMini: {
      type: Boolean,
      default: false
    }
  },
  data: () => ({
    branch: {
      status: 1
    },
    dialogDelete: false,
    idBranch: null,
    title: [
      { text: 'Tên chi nhánh', sortable: false },
      { text: 'Email', sortable: false },
      { text: 'Mã sô thuế', sortable: false },
      { text: 'Địa chỉ', sortable: false },
      { text: 'Trạng thái', sortable: false },
      { text: 'Hành động', sortable: false }
    ],
    dataViewHeight: 0,
    dataViewName: 'branch',
    params: {
      q: ''
    }
  }),
  computed: {
    isIndex () {
      return this.type === 'index'
    }
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    ...mapActions('Branch', ['getBranch', 'getBranchs', 'deleteBranch', 'updateStatusBranch']),
    ...mapActions(['showNotify', 'setMiniDrawer']),
    branchDetail (branch) {
      this.getBranch({ branchId: branch.id })
      this.$router.push({ name: 'branch-detail', params: { id: branch.id } })
    },
    changeSearch: debounce(function () {
      this.filter()
    }, 500),
    filter () {
      this.$refs[this.dataViewName].$emit('reload')
    },
    changeStatus (idBranch) {
      this.updateStatusBranch({
        id: idBranch
      })
    },
    removeConfirm (id) {
      this.idBranch = id
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteBranch({
          id: this.idBranch,
          cb: (response) => {
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.$refs[this.dataViewName].$emit('reload')
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
    this.dataViewHeight = this.$refs.laylout.clientHeight - 176
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
<style scoped>
.v-toolbar__extension{
  height: 43px;
}
</style>

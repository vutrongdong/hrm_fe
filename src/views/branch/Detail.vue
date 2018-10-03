<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs4>
      <listting type="detail" :is-mini="true" />
    </v-flex>
    <v-flex xs8 class="border-e0-left">
      <v-toolbar dense color="white" flat>
        <v-toolbar-title>{{ $t('title.branch.detail') }}: {{branchDetail.name}}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-menu :nudge-width="100" offset-y>
          <v-list>
            <v-list-tile
            v-for="item in 10"
            :key="item"
            >
            <v-list-tile-title v-text="item"></v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu>
      <v-tooltip bottom>
        <v-btn slot="activator" v-if="canAccess('branch.update')" icon @click="$router.push({name: 'branch-edit', params: {id: $route.params.id}})">
          <v-icon>edit</v-icon>
        </v-btn>
        <span>Sửa</span>
      </v-tooltip>
      <v-tooltip bottom>
        <v-btn slot="activator" v-if="canAccess('branch.delete')" icon @click="removeConfirm()">
          <v-icon>delete</v-icon>
        </v-btn>
        <span>Xóa</span>
      </v-tooltip>
      <v-tooltip bottom>
        <v-btn slot="activator" icon @click="$router.push({name: 'branch'})" >
          <v-icon>close</v-icon>
        </v-btn>
        <span>Đóng</span>
      </v-tooltip>
    </v-toolbar>
    <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
      <v-layout row wrap>
        <v-flex sm5>
          <img style="border:1px solid gray" width="100%" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkzg43WKhLRqXMgK81QQilVmHO0qcC2pu424_k5cAUV0TasgY3-Q" alt="">
        </v-flex>
        <v-flex xs7 class="pl-2" id="infoBranch">
          <p> - Tên: {{branchDetail.name}}</p>
          <p> - Số điện thoại: {{branchDetail.phone}}</p>
          <p> - Địa chỉ: {{branchDetail.address}}</p>
          <p> - Website: {{branchDetail.website}}</p>
          <p> - Email: {{branchDetail.email}}</p>
          <p> - Facebook: {{branchDetail.facebook}}</p>
          <p> - Zalo: {{branchDetail.zalo}}</p>
          <p> - Mã số thuế: {{branchDetail.tax_number}}</p>
          <p> - Ngân hàng: {{branchDetail.bank}}</p>
          <p> - Loại: {{ branchDetail.type_txt }}</p>
        </v-flex>
      </v-layout>
      <v-flex class="mt-4">
        <h3 class='mr-2'> Mô tả công ty: </h3><p style="margin-top: 3px;clear:both;" v-html="branchDetail.description"></p>
        <h3 class='mr-2'>Thông tin công ty:</h3><span v-html="branchDetail.about"></span>
      </v-flex>
    </v-container>
  </v-flex>
  <dialog-confirm v-model="dialogDelete" @input="remove" />
</v-layout>
</template>
<script>
import Listting from './Listting'
import { mapActions, mapGetters } from 'vuex'
import DialogConfirm from '@/components/DialogConfirm'
export default{
  name: 'BranchDetail',
  components: {
    Listting,
    DialogConfirm
  },
  data () {
    return {
      dataViewHeight: 0,
      dialogDelete: false
    }
  },
  computed: {
    ...mapGetters('Branch', ['branchDetail'])
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Branch', ['getBranch', 'deleteBranch']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    removeConfirm () {
      this.dialogDelete = true
    },
    remove (confirm) {
      if (confirm) {
        this.deleteBranch({
          id: this.$route.params.id,
          cb: (response) => {
            this.removeDataviewEntry({
              name: 'branch',
              data: this.branchDetail,
              key: 'id'
            })
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
  created () {
    this.setMiniDrawer(true)
    if (!this.branchDetail.id) {
      this.getBranch({ branchId: this.$route.params.id })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 50
  }
}
</script>
<style>
#infoBranch p{
  margin-bottom: 10px;
}
</style>

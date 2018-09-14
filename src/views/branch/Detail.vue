<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs4>
      <listting />
    </v-flex>
    <v-flex xs12 class="border-e0-left">
      <v-toolbar dense color="white" flat>
        <v-toolbar-title>{{ $t('title.branch.detail') }}: {{branchDetail.name}}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-menu :nudge-width="100" offset-y>
          <v-btn icon slot="activator">
            <v-icon>more_vert</v-icon>
          </v-btn>
          <v-list>
            <v-list-tile
            v-for="item in 10"
            :key="item"
            >
            <v-list-tile-title v-text="item"></v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu>
      <v-btn v-if="canAccess('branch.update')" icon @click="$router.push({name: 'branch-edit', params: {id: $route.params.id}})">
        <v-icon>edit</v-icon>
      </v-btn>
      <v-btn v-if="canAccess('branch.delete')" icon @click="removeConfirm()">
        <v-icon>delete</v-icon>
      </v-btn>
      <v-btn icon @click="$router.push({name: 'branch'})">
        <v-icon>close</v-icon>
      </v-btn>
    </v-toolbar>
    <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
      <p>Tên: {{branchDetail.name}}</p>
      <p>Mô tả : {{branchDetail.description }}</p>
      <p>Thông tin : {{branchDetail.about }}</p>
      <p>Số điện thoại: {{branchDetail.phone}}</p>
      <p>Địa chỉ: {{branchDetail.address}}</p>
      <p>Website: {{branchDetail.website}}</p>
      <p>Email: {{branchDetail.email}}</p>
      <p>Facebook: {{branchDetail.facebook}}</p>
      <p>Zalo: {{branchDetail.zalo}}</p>
      <p>Mã số thuế: {{branchDetail.tax_number}}</p>
      <p>Ngân hàng: {{branchDetail.bank}}</p>
      <p>Chi nhánh chính <v-icon color="green" v-if="branchDetail.type==isBranchMain">done_outline</v-icon><v-icon v-else color="red">
      highlight_off</v-icon></p>
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
    ...mapGetters('Branch',['branchDetail']),
    isBranchMain () {
      return 1
    }
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Branch',['getBranch', 'deleteBranch']),
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
            this.$router.push({ name: 'branch' })
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
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }

}

</script>

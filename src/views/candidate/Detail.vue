<template >
    <v-layout ref="laylout" row fill-height>
      <v-flex xs4>
      <listting></listting>
    </v-flex>
    <v-flex xs8 class="border-e0-left">
        <v-toolbar dense color="white" flat>
          <v-toolbar-title>{{ $t('title.candidate.detail') }}: {{candidateDetail.name}}</v-toolbar-title>
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
         <v-btn v-if="canAccess('candidate.update')" icon @click="$router.push({name: 'candidate-edit', params: {id: $route.params.id}})">
                <v-icon>edit</v-icon>
        </v-btn>
        <v-btn v-if="canAccess('candidate.delete')" icon @click="removeConfirm()">
                <v-icon>delete</v-icon>
        </v-btn>
        <v-btn icon  @click="$router.push({name: 'candidate'})">
               <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
          <p> name : {{candidateDetail.name}} </p>
          <p> email : {{candidateDetail.email}} </p>
          <p> phone : {{candidateDetail.phone}} </p>
          <p v-if="candidateDetail.status == 0"> Status : Mới </p>
          <p v-else-if="candidateDetail.status == 1"> Status : Chờ kết quả </p>
          <p v-else-if="candidateDetail.status == 2"> Status : Trượt </p>
          <p v-else-if="candidateDetail.status == 3"> Status : Đỗ </p>
          <p v-else-if="candidateDetail.status == 4"> Status : Danh sách đen </p>
      </v-container>
    </v-flex>
      <dialog-confirm v-model="dialogDelete" @input="remove" />
    </v-layout>
</template>
<script>
import listting from './Listting'
import DialogConfirm from '@/components/DialogConfirm'
import { mapActions, mapGetters } from 'vuex'
export default{
  name: 'CandidateDetail',
  components: {
    listting,
    DialogConfirm
  },
  data () {
    return {
      dataViewHeight: 0,
      dialogDelete: false
    }
  },
  computed: {
    ...mapGetters('Candidate', ['candidateDetail'])
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Candidate', ['getCandidate', 'deleteCandidate']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    removeConfirm () {
      this.dialogDelete = true
    },
    remove (confirm) {
        if(confirm){
          this.deleteCandidate({
              id: this.$route.params.id,
              cb: (response) =>{
                  this.removeDataviewEntry({
                      name: 'candidate',
                      data: this.candidateDetail,
                      key: 'id'
                  })
                  this.$store.dispatch('showNotify', {
                    text: this.$t('alert.success'),
                    color: 'success'
                  })
                  this.dialogDelete = false
                  this.$router.push({ name: 'candidate' })
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
    console.log('id :' + this.candidateDetail.id)
    if (!this.candidateDetail.id) {
    this.getCandidate({ candidateId: this.$route.params.id})
     }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
    console.log(this.dataViewHeight)
  }
}
</script>

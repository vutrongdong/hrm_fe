<template>
    <v-layout ref="laylout" row fill-height>
      <v-flex xs4>
      <listting></listting>
    </v-flex>
    <v-flex xs8 class="border-e0-left">
            <v-toolbar dense color="white" flat>
           <v-toolbar-title>{{ $t('title.position.detail') }}: {{positionDetail.name}}</v-toolbar-title>
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
           <v-btn v-if="canAccess('position.update')" icon @click="$router.push({name: 'position-edit', params: {id: $route.params.id}})">
          <v-icon>edit</v-icon>
        </v-btn>
        <v-btn v-if="canAccess('user.delete')" icon @click="removeConfirm()">
          <v-icon>delete</v-icon>
        </v-btn>
        <v-btn icon @click="$router.push({name: 'position'})">
          <v-icon>close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
                  <p>Tên chức vụ: {{positionDetail.name}}</p>
                  <p> status    : {{positionDetail.status}} </p>
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
  name: 'PositionDetail',
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
    ...mapGetters('Position',['positionDetail'])
  },
  methods:{
    ...mapActions(['setMiniDrawer']),
    ...mapActions('Position',['getPosition','deletePosition']),
    ...mapActions('Dataview', ['removeDataviewEntry']),
    removeConfirm(){
        this.dialogDelete = true
    },

    remove(confirm){
      if (confirm){
        this.deletePosition({
          id: this.$route.params.id,
          cb: (response) =>{
            this.removeDataviewEntry({
                name: 'position',
                data  : this.positionDetail,
                key: 'id'
            })
            this.$store.dispatch('showNotify', {
              text: this.$t('alert.success'),
              color: 'success'
            })
            this.dialogDelete = false
            this.$router.push({name: 'position'})
          },
          error: (error) =>{
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
  created(){
    this.setMiniDrawer(true)
     if (!this.positionDetail.id) {
      this.getPosition({positionId:this.$route.params.id, params: {include: 'position' } })
    }
  },
  mounted () {
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }
  }
</script>



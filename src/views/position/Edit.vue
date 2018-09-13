<template>
   <v-layout ref="laylout" row fill-height>
      <v-flex xs4>
            <listting></listting>
      </v-flex>
      <v-flex xs8 class="border-e0-left">
          <v-toolbar dense color="white" flat>
            <v-toolbar-title>{{ $t('title.position.edit') }}: {{positionDetail.name}}</v-toolbar-title>
            <v-spacer></v-spacer>
            <v-btn icon @click="$router.push({name: 'position-detail', params: {id: $route.params.id}})">
               <v-icon>close</v-icon>
            </v-btn>
          </v-toolbar>
      <v-container fluid class="white scroll-y border-e0-top" :style="{height: dataViewHeight + 'px'}">
        <position-form v-if="positionDetail.id" @submit="submitForm"  type="edit" :dataPosition="positionDetail"></position-form>
      </v-container>
      </v-flex>
   </v-layout>
</template>
<script>
import PositionForm from './Form'
import listting from './Listting'
import { mapActions, mapGetters } from 'vuex'
 export default{
  name: 'EditPosition',
  components: {
    PositionForm,
    listting
  },
   data () {
    return {
      dataViewHeight: 0
    }
  },
  computed:{
      ...mapGetters('Position', ['positionDetail'])
  },
  methods:{
    ...mapActions(['showNotify', 'setMiniDrawer']),
    ...mapActions('Position', ['updatePosition', 'getPosition', 'setPosition']),
    ...mapActions('Dataview', ['updateDataviewEntry']),
    submitForm(formData){
        this.updatePosition({
             id: this.$route.params.id,
             position:formData,
             cb: (response) =>{
              this.showNotify({
                color: 'success',
                text: 'Thành công'
              })
             this.setPosition({position: response.data})
             this.updateDataviewEntry({
              name: 'position',
              data: response.data,
              key: 'id'
             })
              this.$router.push({
                name: 'position-detail',
                params: { id: this.$route.params.id }
              })
          }
        })
    }
  },
  created(){
      this.setMiniDrawer(true)
      if(!this.positionDetail.id){
      this.getPosition({ positionId: this.$route.params.id })
      }
  },
  mounted(){
    this.dataViewHeight = this.$refs.laylout.clientHeight - 48
  }
     }
</script>


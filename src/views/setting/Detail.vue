<!-- <template>
  <div>
    <children :id='index' v-for="(n,index) in range" :dataRange="range" @add="Add()" @delete="Remove(index)"></children>
  </div>
</template>

<script>
import children from './chilren'
export default{
 data() {
  return{
    range:1
  }
},
methods: {
  Add() {
    this.range += 1
  },
  Remove(index){
    if(index!=0){
      $('#'+index).remove()
    }
  }
},
components:{children}
}
</script>
 -->

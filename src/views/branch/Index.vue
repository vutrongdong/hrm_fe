<template>
  <v-layout ref="laylout" row fill-height>
    <v-flex xs12>
      <List/>
    </v-flex>
  </v-layout>
</template>
<script>
import List from './Listting'
export default{
  components: {
    List
  }
}
</script>

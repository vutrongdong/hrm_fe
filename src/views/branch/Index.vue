<template>
  <v-flex xs12>
    <listting />
  </v-flex>
</template>

<script>
import Listting from './Listting'
import { mapActions } from 'vuex'
export default{
  name: 'Branch',
  components: {
    Listting
  },
  methods: {
    ...mapActions(['setMiniDrawer'])
  },
  created () {
    this.setMiniDrawer(false)
  }
}
</script>

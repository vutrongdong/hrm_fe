<template>
 <v-layout ref="laylout" row fill-height>
   <v-flex xs4>
    <listting :is-mini="true" />
  </v-flex>
</v-layout>
</template>
<script type="text/javascript">
import Listting from './Listting'
import { mapActions, mapGetters } from 'vuex'
import DialogConfirm from '@/components/DialogConfirm'
export default{
  name: 'ContractDetail',
  components: {
    Listting
  }
}
</script>
<style type="text/css" media="screen">

</style>

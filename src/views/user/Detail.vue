<template>
  <v-container>
  </v-container>
</template>
<script>
import { mapActions, mapGetters } from 'vuex'
export default{
  data () {
    return {
      items: []
    }
  },
  props: ['idUser'],
  computed: {
    ...mapGetters('User', ['userDetail'])
  },
  methods: {
    ...mapActions('User', ['getUser', 'deleteUser'])
  },
  created () {
    if (!this.userDetail.id) {
      this.getUser({ userId: this.idUser, params: { include: 'departments.branch,positions,roles' } })
    }
  },
  mounted () {
    this.items.push(
      { name: 'Tên nhân sự', value: this.userDetail.name },
      { name: 'Mã nhân viên', value: this.userDetail.code },
      { name: 'Trình độ chuyên môn', value: this.userDetail.qualification },
      { name: 'Địa chỉ', value: this.userDetail.address },
      { name: 'Thư điện tử', value: this.userDetail.email },
      { name: 'Số điện thoại', value: this.userDetail.gender_txt },
      { name: 'Giới tính', value: this.userDetail.gender_txt },
      { name: 'Ngày sinh', value: this.userDetail.date_of_birth }
    )
  }
}
</script>

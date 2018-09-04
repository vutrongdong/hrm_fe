<template>
  <section>
    <v-toolbar flat class="transparent">
      <v-list class="pa-0">
        <v-list-tile
          avatar
          :to="{name: 'account-change-information'}"
        >
          <v-list-tile-avatar>
            <img :src="userProfile.avatar_url" alt=".name">
          </v-list-tile-avatar>

          <v-list-tile-content>
            <v-list-tile-title>
              <v-tooltip bottom>
                <span slot="activator">
                  {{ userName }}
                </span>
                <span>{{userProfile.name}}</span>
              </v-tooltip>
            </v-list-tile-title>
          </v-list-tile-content>

          <v-list-tile-action>
            <v-btn
              icon
              @click.prevent.stop="setMiniDrawer(!miniDrawer)"
            >
              <v-icon>chevron_left</v-icon>
            </v-btn>
          </v-list-tile-action>
        </v-list-tile>
      </v-list>
    </v-toolbar>

    <v-list dense>
      <template v-for="(item, index) in items" v-if="canAccess(item.access_permission)">
        <v-layout
          v-if="item.heading"
          :key="item.heading"
          row
          align-center
          >
          <v-flex xs6>
            <v-subheader v-if="item.heading">
              {{ item.heading }}
            </v-subheader>
          </v-flex>
          <v-flex xs6 class="text-xs-center">
            <a href="#!" class="body-2 black--text">EDIT</a>
          </v-flex>
        </v-layout>
        <v-list-group
          v-else-if="item.children"
          v-model="item.model"
          :key="item.text"
          :prepend-icon="item.icon"
          append-icon="keyboard_arrow_down"
          :value="checkOpenGroup(item.children, index)"
          >
          <v-list-tile slot="activator">
            <v-list-tile-content>
              <v-list-tile-title>
                {{ item.text }}
              </v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
          <v-list-tile
            ripple
            v-for="(child, i) in item.children"
            :key="i"
            @click="$router.push(child.router)"
            :class="child.router.name === $route.name && 'grey lighten-2'"
          >
            <v-list-tile-action v-if="child.icon">
              <v-icon>{{ child.icon }}</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>
                {{ child.text }}
              </v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list-group>
        <v-list-tile v-else ripple :key="item.text" @click="$router.push(item.router)" :class="item.router.name === $route.name && 'grey lighten-2'">
          <v-list-tile-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>
              {{ item.text }}
            </v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </template>
    </v-list>

  </section>
</template>
<script>
import { mapActions, mapGetters } from 'vuex'
import { vnFilter } from '@/helpers'
export default {
  name: 'GostoreNavigation',
  data () {
    return {
      items: [
        {
          icon: 'fa-home',
          text: this.$t('title.home'),
          router: {name: 'home'},
          access_permission: true
        },
        {
          icon: 'fas fa-object-group',
          text: this.$t('title.item.index'),
          access_permission: 'item.view',
          model: false,
          children: [
            {
              icon: 'fas fa-cube',
              text: this.$t('title.item.index'),
              router: {name: 'item'},
              access_permission: 'item.view'
            }
          ]
        },
        // {
        //   icon: 'keyboard_arrow_up',
        //   'icon-alt': 'keyboard_arrow_down',
        //   text: 'Labels',
        //   model: true,
        //   children: [
        //     { icon: 'add',
        //     text: 'Create label' }
        //   ]
        // },
        {
          icon: 'fa-user',
          text: this.$t('title.user.index'),
          router: {name: 'user'},
          access_permission: 'user.view'
        },
        {
          icon: 'fa-key',
          text: this.$t('title.role.index'),
          router: {name: 'role'},
          access_permission: 'role.view'
        }
      ]
    }
  },
  computed: {
    ...mapGetters(['miniDrawer', 'userProfile']),
    userName () {
      return this.userProfile.name && this.userProfile.name.length > 13 ? vnFilter(this.userProfile.name).match(/\b(\w)/g).join('').toUpperCase() : this.userProfile.name
    }
  },
  methods: {
    ...mapActions(['setMiniDrawer']),
    checkOpenGroup (routers, index) {
      if (routers.length) {
        routers.forEach(router => {
          if (router.router.name === this.$route.name) {
            this.items[index].model = true
          }
        })
      }
    }
  }
}
</script>

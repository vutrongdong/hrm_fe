import * as modules from './auth-modules'
// console.log(modules)
import { flatten } from 'lodash'
export default {
  path: '/',
  redirect: '/home',
  component: () => import('@/Auth'),
  name: 'layoutAuth',
  meta: {
    title: {
      i18n: 'title.home'
    },
    require_auth: true,
    breadcrumb: [
    ]
  },
  children: [
    {
      path: 'home',
      name: 'home',
      meta: {
        title: {
          i18n: 'title.home'
        },
        require_auth: true,
        breadcrumb: [
        ]
      },
      component: () => import('@/views/Home')
    },
    ...flatten(Object.values(modules))
  ]
}

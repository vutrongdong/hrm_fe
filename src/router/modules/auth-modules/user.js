export default[
  {
    path: 'user',
    name: 'user',
    meta: {
      title: {
        i18n: 'title.user.index'
      },
      require_auth: true,
      breadcrumb: []
    },
    component: () => import('@/views/user/Index')
  },
  {
    path: 'user/create',
    name: 'user-create',
    meta: {
      title: {
        i18n: 'title.user.create'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/user',
          meta: {
            title: {
              i18n: 'title.user.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/user/Create')
  },
  {
    path: 'user/:id',
    name: 'user-detail',
    meta: {
      title: {
        i18n: 'title.user.detail'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/user',
          meta: {
            title: {
              i18n: 'title.user.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/user/Detail')
  },
  {
    path: 'user/:id/edit',
    name: 'user-edit',
    meta: {
      title: {
        i18n: 'title.user.edit'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/user',
          meta: {
            title: {
              i18n: 'title.user.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/user/Edit')
  }
]

export default[
  {
    path: 'position',
    name: 'position',
    meta: {
      title: {
        i18n: 'title.position.index'
      },
      require_auth: true,
      breadcrumb: []
    },
    component: () => import('@/views/position/Index')
  },
  {
    path: 'position/create',
    name: 'position-create',
    meta: {
      title: {
        i18n: 'title.position.create'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/position',
          meta: {
            title: {
              i18n: 'title.position.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/position/Create')
  },
  {
    path: 'position/:id',
    name: 'position-detail',
    meta: {
      title: {
        i18n: 'title.position.detail'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/position',
          meta: {
            title: {
              i18n: 'title.position.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/position/Detail')
  },
  {
    path: 'position/:id/edit',
    name: 'position-edit',
    meta: {
      title: {
        i18n: 'title.position.edit'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/position',
          meta: {
            title: {
              i18n: 'title.position.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/position/Edit')
  }
]

export default[
  {
    path: 'setting',
    name: 'setting',
    meta: {
      title: {
        i18n: 'title.setting.index'
      },
      require_auth: true,
      breadcrumb: []
    },
    component: () => import('@/views/setting/Index')
  },
  {
    path: 'setting/create',
    name: 'setting-create',
    meta: {
      title: {
        i18n: 'title.setting.create'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/setting',
          meta: {
            title: {
              i18n: 'title.setting.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/setting/Create')
  },
  {
    path: 'setting/:id',
    name: 'setting-detail',
    meta: {
      title: {
        i18n: 'title.setting.detail'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/setting',
          meta: {
            title: {
              i18n: 'title.setting.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/setting/Detail')
  },
  {
    path: 'setting/:id/edit',
    name: 'setting-edit',
    meta: {
      title: {
        i18n: 'title.setting.edit'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/setting',
          meta: {
            title: {
              i18n: 'title.setting.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/setting/Edit')
  }
]

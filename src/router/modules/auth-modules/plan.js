export default[
  {
    path: 'plan',
    name: 'plan',
    meta: {
      title: {
        i18n: 'title.plan.index'
      },
      require_auth: true,
      breadcrumb: []
    },
    component: () => import('@/views/plan/Index')
  },
  {
    path: 'plan/create',
    name: 'plan-create',
    meta: {
      title: {
        i18n: 'title.plan.create'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/plan',
          meta: {
            title: {
              i18n: 'title.plan.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/plan/Create')
  },
  {
    path: 'plan/:id',
    name: 'plan-detail',
    meta: {
      title: {
        i18n: 'title.plan.detail'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/plan',
          meta: {
            title: {
              i18n: 'title.plan.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/plan/Detail')
  },
  {
    path: 'plan/:id/edit',
    name: 'plan-edit',
    meta: {
      title: {
        i18n: 'title.plan.edit'
      },
      require_auth: true,
      breadcrumb: [
        {
          path: '/plan',
          meta: {
            title: {
              i18n: 'title.plan.index'
            }
          }
        }
      ]
    },
    component: () => import('@/views/plan/Edit')
  }
]

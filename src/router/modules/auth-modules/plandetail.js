export default[
{
  path: 'plandetail',
  name: 'plandetail',
  meta: {
    title:{
        i18n: 'title.plandetail.index'
    },
    require_auth: true,
    breadcrumb: []
  },
  component: () => import('@/views/plan/plandetail/Index')
},
{
  path: 'plandetail/create',
  name: 'plandetail-create',
  meta: {
   title:{
        i18n: 'title.plandetail.create'
        },
      require_auth: true,
      breadcrumb: [
        {
          path:'/plandetail',
          meta: {
            title: {
              i18n: 'title.plandetail.index'
            }
          }
        }
      ]
  },
  component: () => import('@/views/plan/plandetail/Create')
},
{
   path: 'plandetail/:id/edit',
   name: 'plandetail-detail',
   meta: {
    title:{
       i18n: 'title.plandetail.detail'
    },
    require_auth: true,
    breadcrumb: [
      {
        path:'/plandetail',
        meta: {
          title: {
            i18n: 'title.plandetail.index'
          }
        }
      }
    ]
   },
  component: () => import('@/views/plan/plandetail/Detail')
},
{
   path: 'plandetail/:id/edit',
   name: 'plandetail-edit',
   meta: {
    title:{
       i18n: 'title.plandetail.edit'
    },
    require_auth: true,
    breadcrumb: [
      {
        path:'/plandetail',
        meta: {
          title: {
            i18n: 'title.plandetail.index'
          }
        }
      }
    ]
   },
  component: () => import('@/views/plan/plandetail/Edit')
}


]

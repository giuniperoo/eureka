App.Router.map ()->
  @resource 'mapnote', { path: '/:mapnote_id' }
  @route 'settings'
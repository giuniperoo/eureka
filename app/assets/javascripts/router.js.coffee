App.Router.map ()->
  @route 'mapnote', { path: '/:mapnote_id' }
  @route 'settings', ->
    @route 'map'
    @route 'note'
    @route 'about'

App.MapnoteTileController = Ember.ObjectController.extend
  needs: ['mapnote']

  rerouteIfCurrent: (mapnoteId)->
    mapnoteController = @.get 'controllers.mapnote'
    if mapnoteController.model.id == mapnoteId
      @transitionToRoute '/'

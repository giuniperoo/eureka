App.MapnoteTileController = Ember.ObjectController.extend
  needs: ['mapnote']

  rerouteIfCurrent: (mapnoteId)->
    mapnoteController = @.get 'controllers.mapnote'
    if mapnoteController.model.id == mapnoteId
      @transitionToRoute '/'

  actions:
    removeMapnote: ->
      Ember.run.later this, ->
        modelId = @model.id
        @model.destroyRecord()
        @rerouteIfCurrent modelId
      , 400

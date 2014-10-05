App.SettingsController = Ember.ObjectController.extend
  active: true
  mapType: Ember.computed.alias 'model.mapType'
  previousTransition: null

  transitionToPreviousRoute: ->
    if @previousTransition
      @previousTransition.retry()
    else
      @.transitionToRoute 'index'

  selectMap: (name)->
    @model.set 'mapType', name
    @model.save()

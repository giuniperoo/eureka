App.SettingsMapController = Ember.ObjectController.extend
  mapType: Ember.computed.alias 'model.mapType'

  selectMap: (name)->
    @model.set 'mapType', name
    @model.save()

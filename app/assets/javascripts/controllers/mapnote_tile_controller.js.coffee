App.MapnoteTileController = Ember.ObjectController.extend
  actions:
    delete: ->
      this.get('model').destroyRecord()

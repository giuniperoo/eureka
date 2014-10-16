App.ApplicationRoute = Ember.Route.extend App.PreviousTransitionable,
  model: -> @store.find 'mapnote'

  beforeModel: ->
    store = @store
    @store.find('settings').then (settings)->
      if settings.get('length') < 1
        settings = store.createRecord 'settings',
          'font': 'sans'
          'mapType': 'natural'
          'emojiActive': true
        settings.save()

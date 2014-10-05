App.SettingsRoute = Ember.Route.extend
  model: ->
    @store.find('settings').then (settings)->
      settings.get 'lastObject'

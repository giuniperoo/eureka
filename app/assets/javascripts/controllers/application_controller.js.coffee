App.ApplicationController = Ember.ArrayController.extend
  needs: 'settings'
  sortAscending: false
  sortProperties: ['updated']

  initializeSettings: (->
    store = @store
    @store.find('settings').then (settings)->
      if settings.get('length') < 1
        settings = store.createRecord 'settings',
          'mapType': 'toner'
        settings.save()
  ).on 'init'

  actions:
    displaySettings: ->
      settingsController = @.get 'controllers.settings'
      settingsController.set 'active', true
      @transitionToRoute 'settings'

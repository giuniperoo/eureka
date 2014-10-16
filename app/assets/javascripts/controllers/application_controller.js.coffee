App.ApplicationController = Ember.ArrayController.extend
  needs: 'settings'
  sortAscending: false
  sortProperties: ['updated']
  font: null

  setMapTileFont: (->
    store = @.get 'store'
    settings = store.all 'settings'
    font = settings.get 'lastObject.font'
    @.set 'font', font
  ).on 'init'

  actions:
    displaySettings: ->
      settingsController = @.get 'controllers.settings'
      settingsController.set 'active', true
      @transitionToRoute 'settings.map'

App.ApplicationController = Ember.ArrayController.extend
  needs: 'settings'
  sortAscending: false
  sortProperties: ['updated']

  actions:
    displaySettings: ->
      settingsController = @.get 'controllers.settings'
      settingsController.set 'active', true
      @transitionToRoute 'settings'

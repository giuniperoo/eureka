App.ApplicationController = Ember.ArrayController.extend
  needs: 'config'
  sortAscending: false
  sortProperties: ['updated']

  actions:
    displayConfig: ->
      configController = @.get 'controllers.config'
      configController.set 'active', !configController.get 'active'

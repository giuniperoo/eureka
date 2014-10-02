App.SettingsController = Ember.ObjectController.extend
  active: true
  previousTransition: null

  transitionToPreviousRoute: ->
    if @previousTransition
      @previousTransition.retry()
    else
      @.transitionToRoute 'index'

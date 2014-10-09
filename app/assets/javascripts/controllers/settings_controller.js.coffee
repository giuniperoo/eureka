App.SettingsController = Ember.ObjectController.extend
  active: true
  previousTransition: null

  transitionToPreviousRoute: ->
    if @previousTransition && !@previousTransition.isAborted
      @previousTransition.retry()
    else
      @.transitionToRoute 'index'

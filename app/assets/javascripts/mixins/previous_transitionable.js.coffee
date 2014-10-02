App.PreviousTransitionable = Ember.Mixin.create
  beforeModel: (transition)->
    @.saveTransition transition

  saveTransition: (transition)->
    unless transition.targetName == 'settings'
      @.controllerFor('settings').set 'previousTransition', transition

  actions:
    willTransition: (transition)->
      @.saveTransition transition

App.PreviousTransitionable = Ember.Mixin.create
  beforeModel: (transition)->
    @.saveTransition transition

  saveTransition: (transition)->
    unless transition.targetName.indexOf('settings') == 0
      @.controllerFor('settings').set 'previousTransition', transition

  actions:
    willTransition: (transition)->
      @.saveTransition transition

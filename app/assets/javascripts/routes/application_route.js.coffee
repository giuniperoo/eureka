App.ApplicationRoute = Ember.Route.extend App.PreviousTransitionable,
  model: -> @store.find 'mapnote'

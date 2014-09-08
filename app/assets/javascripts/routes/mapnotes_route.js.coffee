App.MapnotesRoute = Ember.Route.extend
  model: -> @store.find 'mapnote'

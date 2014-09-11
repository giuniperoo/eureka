App.ApplicationRoute = Ember.Route.extend
  model: -> @store.find 'mapnote'

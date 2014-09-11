App.IndexRoute = Ember.Route.extend
  controllerName: 'mapnote'
  model: -> @store.createRecord 'mapnote'

App.MapnoteRoute = Ember.Route.extend
  beforeModel: ->
    mapnotes = @store.all 'mapnote'
    mapnotes.setEach 'active', false

  actions:
    error: (reason, transition)->
      console.error reason.message + " Redirecting to '/'"
      @transitionTo '/'

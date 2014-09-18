App.MapnoteRoute = Ember.Route.extend
  actions:
    error: (reason, transition)->
      console.error reason.message + " Redirecting to '/'"
      @transitionTo '/'

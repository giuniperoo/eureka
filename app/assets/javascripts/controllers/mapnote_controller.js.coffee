App.MapnoteController = Ember.ObjectController.extend
  text: ''
  latitude: ''
  longitude: ''
  loading: true

  initializeMapnote: ->
    model = @store.createRecord 'mapnote'
    @.set 'model', model

  saveMapnote: ->
    model = @.get 'model'

    if model.get 'isDeleted'
      @initializeMapnote()
      model = @.get 'model'

    model.set 'text', @text
    model.set 'latitude', @latitude
    model.set 'longitude', @longitude
    model.set 'updated', new Date()
    if model.get 'isNew'
      model.set 'created', new Date()
    model.save()

App.MapnoteController = Ember.ObjectController.extend
  text: ''
  zoom: ''
  latitude: ''
  longitude: ''
  loading: true

  initializeMapnote: ->
    model = @store.createRecord 'mapnote'
    @.set 'model', model

  saveMapnote: ->
    if @text isnt ''
      @initializeMapnote() if @model.get 'isDeleted'

      @model.set 'text', @text
      @model.set 'zoom', @zoom
      @model.set 'latitude', @latitude
      @model.set 'longitude', @longitude
      @model.set 'updated', new Date()
      @model.set 'created', new Date() if @model.get 'isNew'
      @model.save()

App.MapnoteController = Ember.ObjectController.extend
  text: ''

  actions:
    createMapnote: ->
      @.get('model').set 'text', @text
      @.get('model').set 'created', new Date()
      @.get('model').set 'updated', new Date()
      @.get('model').save()

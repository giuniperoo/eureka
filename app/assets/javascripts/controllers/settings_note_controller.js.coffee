App.SettingsNoteController = Ember.ObjectController.extend
  needs: 'application'

  emojiActive: Ember.computed.alias 'model.emojiActive'
  font: Ember.computed.alias 'model.font'

  toggleEmoji: (boolean)->
    @model.set 'emojiActive', boolean
    @model.save()

  selectFont: (name)->
    @model.set 'font', name
    @model.save()

    applicationController = @.get 'controllers.application'
    applicationController.set 'font', name

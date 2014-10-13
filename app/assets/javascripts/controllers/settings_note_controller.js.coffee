App.SettingsNoteController = Ember.ObjectController.extend
  emojiActive: Ember.computed.alias 'model.emojiActive'

  toggleEmoji: (boolean)->
    @model.set 'emojiActive', boolean
    @model.save()

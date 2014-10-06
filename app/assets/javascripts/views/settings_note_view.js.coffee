App.SettingsNoteView = Ember.View.extend
  didInsertElement: ->
    parentView = @.get 'parentView'
    if parentView.get('pointerSet') == true
      parentView.slidePointer()

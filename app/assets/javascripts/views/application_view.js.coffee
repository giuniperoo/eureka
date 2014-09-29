App.ApplicationView = Ember.View.extend

  keyboardShortcuts: (evt)->
    unless $(document.activeElement).is 'textarea'
      # c => 'config'
      @.get('controller').send 'displayConfig' if evt.keyCode == 67

  click: -> $('.mapnote-tiles .confirm').fadeOut()

  didInsertElement: ->
    $(document).on 'keyup', @keyboardShortcuts.bind(this)

  willDestroyElement: ->
    $(document).off 'keyup', @keyboardShortcuts.bind(this)

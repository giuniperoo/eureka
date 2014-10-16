App.ApplicationView = Ember.View.extend

  keyboardShortcuts: (evt)->
    unless $(document.activeElement).is 'textarea, input'
      # s => 'settings'
      @.get('controller').send 'displaySettings' if evt.keyCode == 83

  click: -> $('.mapnote-tiles .confirm').fadeOut()

  didInsertElement: ->
    $(document).on 'keyup.keyboard', @keyboardShortcuts.bind this

  willDestroyElement: ->
    $(document).off 'keyup.keyboard'

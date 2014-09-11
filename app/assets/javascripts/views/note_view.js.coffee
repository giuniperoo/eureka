App.NoteView = Em.View.extend
  classNames: 'note'
  templateName: 'note'

  displayNote: ->
    $('.note').addClass 'active'
    $('textarea').focus()

  # suppress two-finger map zoom event on note
  bindScrolling: (opts)->
    @.$().bind 'mousewheel DOMMouseScroll', {}, false

  unbindScrolling: ->
    @.$().unbind 'mousewheel DOMMouseScroll'

  keyUp: ->
    console.log @.$('textarea').val()

  didInsertElement: ->
    @displayNote()
    @bindScrolling()

  willDestroyElement: -> @unbindScrolling()

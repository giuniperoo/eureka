App.NoteView = Ember.View.extend
  classNames: 'note'
  templateName: 'note'

  displayNote: ->
    $('.note').addClass 'active'
    $('textarea').focus()

  # suppress two-finger map zoom event on note
  bindScrolling: ->
    @.$().on 'mousewheel DOMMouseScroll', (evt) ->
      evt.stopPropagation()

  unbindScrolling: ->
    @.$().off 'mousewheel DOMMouseScroll'

  didInsertElement: ->
    @displayNote()
    @bindScrolling()

  willDestroyElement: -> @unbindScrolling()

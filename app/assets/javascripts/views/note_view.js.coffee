App.NoteView = Ember.View.extend
  classNames: 'note'
  templateName: 'note'
  updateNote: (->
    Ember.run.scheduleOnce 'afterRender', this, 'displayNote'
  ).observes('controller.model').on 'didInsertElement'

  keyUp: ->
    Ember.run.debounce this, 'compareText', 1000

  compareText: ->
    controller = @.get('controller')
    if controller.get('.text') != controller.get('model.text')
      controller.saveMapnote()

  displayNote: ->
    $('.note').addClass 'active'
    $('textarea').focus()
    unless @.get 'controller.model.isNew'
      @.set('controller.text', @.get 'controller.model.text')

  # suppress two-finger map zoom event on note
  bindScrolling: ->
    @.$().on 'mousewheel DOMMouseScroll', (evt) ->
      evt.stopPropagation()

  unbindScrolling: ->
    @.$().off 'mousewheel DOMMouseScroll'

  didInsertElement: -> @bindScrolling()

  willDestroyElement: -> @unbindScrolling()

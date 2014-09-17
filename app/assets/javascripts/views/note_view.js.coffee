App.NoteView = Ember.View.extend
  classNames: 'note'
  templateName: 'note'
  updateNote: (->
    Ember.run.scheduleOnce 'afterRender', this, 'initializeNote'
  ).observes('controller.model').on 'didInsertElement'

  keyUp: ->
    Ember.run.debounce this, 'compareText', 1000

  compareText: ->
    controller = @.get 'controller'
    uiText     = controller.get 'text'
    modelText  = controller.get 'model.text'

    if uiText != '' && uiText != modelText
      controller.saveMapnote()

  initializeNote: ->
    @.$().addClass 'active'
    @.$('textarea').focus()
    unless @.get 'controller.model.isNew'
      @.set('controller.text', @.get 'controller.model.text')

  displayNote: ->
    @.$().transition
      x: 0
    @.$('.note-slider.left').hide()
    @.$('.note-slider.right').css
      display: 'inline-block'

  hideNote: ->
    offset = @.$().width() - 40
    @.$().transition
      x: offset
    @.$('.note-slider.right').hide()
    @.$('.note-slider.left').css
      display: 'inline-block'

  click: (evt)->
    if $(evt.target).is '.note-slider'
      if $(evt.target).hasClass 'right'
        @hideNote()
      else
        @displayNote()

  # suppress two-finger map zoom event on note
  bindScrolling: ->
    @.$().on 'mousewheel DOMMouseScroll', (evt) ->
      evt.stopPropagation()

  unbindScrolling: ->
    @.$().off 'mousewheel DOMMouseScroll'

  didInsertElement: -> @bindScrolling()

  willDestroyElement: -> @unbindScrolling()

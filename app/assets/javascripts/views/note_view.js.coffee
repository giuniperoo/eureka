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
    if @.get 'controller.model.isNew'
      @.$('textarea').val ''
    else
      @.set('controller.text', @.get 'controller.model.text')

    @.$('textarea').focus() if @.$().hasClass 'active'

    unless @.$().hasClass('init')
      @.$().addClass 'init'
      @.$().addClass 'active'

  displayNote: ->
    @.$().addClass 'active'
    @.$().transition
      x: 0
    , 300

  hideNote: ->
    @.$().removeClass 'active'

    offset = @.$().width() + 20
    @.$().transition
      x: offset
    , 300

  click: (evt)->
    if $(evt.target).is '.note-slider'
      if $(evt.target).hasClass 'right'
        @hideNote()
      else
        @displayNote()

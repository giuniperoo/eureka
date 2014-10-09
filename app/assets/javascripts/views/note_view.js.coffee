App.NoteView = App.EmojiView.extend
  classNames: 'note'
  templateName: 'note'
  updateNote: (->
    Ember.run.scheduleOnce 'afterRender', this, 'initializeNote'
  ).observes('controller.model').on 'didInsertElement'

  keyDown: ->
    Ember.run.debounce this, 'handleSave', 1000

  handleSave: ->
    controller = @.get 'controller'
    uiText     = controller.get 'text'
    modelText  = controller.get 'model.text'

    if uiText != '' && uiText != modelText
      controller.saveMapnote()
      Ember.run.scheduleOnce 'afterRender', emojify, 'run'

  initializeNote: ->
    if @.get 'controller.model.isNew'
      @.$('textarea').val ''
    else
      @.set('controller.text', @.get 'controller.model.text')

    unless @.$().hasClass('init')
      @.$().addClass 'init'
      @.$().addClass 'active'

    @.$('textarea').focus() if @.$().hasClass 'active'

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

  didInsertElement: ->
    @._super()
    $(document).on 'click.emoji', '.dropdown-menu', @handleSave.bind this

  willDestroyElement: ->
    $(document).off 'click.emoji'

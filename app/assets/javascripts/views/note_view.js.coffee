App.NoteView = App.EmojiView.extend
  templateName: 'note'

  settings: (->
    store = @.get 'controller.store'
    store.all('settings').get 'lastObject'
  ).property()

  updateNote: (->
    Ember.run.scheduleOnce 'afterRender', this, '_updateNote'
  ).observes('controller.model').on 'didInsertElement'

  _updateNote: ->
    @updateEmojiStatus()
    @updateFont()
    @setText()
    @initializeNote()

  updateEmojiStatus: ->
    emojiActive = @.get 'settings.emojiActive'
    if emojiActive
      @initializeEmojiDropdown()
      @initializeEmojiConversion()

  updateFont: ->
    font = @.get 'settings.font'
    @.$('textarea').addClass font

  setText: ->
    if @.get 'controller.model.isNew'
      @.$('textarea').val ''
    else
      @.set('controller.text', @.get 'controller.model.text')

  initializeNote: ->
    unless @.$().hasClass 'init'
      @.$().addClass 'init'
      @.$().addClass 'active'
    @.$('textarea').focus() if @.$().hasClass 'active'

  keyDown: ->
    Ember.run.debounce this, 'handleSave', 1000

  handleSave: ->
    controller = @.get 'controller'
    uiText     = controller.get 'text'
    modelText  = controller.get 'model.text'

    if uiText != '' && uiText != modelText
      controller.saveMapnote()
      Ember.run.scheduleOnce 'afterRender', emojify, 'run'

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

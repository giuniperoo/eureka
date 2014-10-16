App.SettingsView = Ember.View.extend
  classNames: 'overlay'
  isVisible: Ember.computed.alias 'controller.active'
  classNameBindings: 'isVisible'

  pointerSet: false
  pointerOffset: null

  preventScroll: (->
    if @.get 'isVisible'
      window.scrollTo 0, 0
      $('body').css 'overflow', 'hidden'
    else
      $('body').css 'overflow', 'initial'
  ).observes 'isVisible'

  getActiveOffset: ->
    $('.menu .active').offset().top -
        $('.menu').offset().top

  setPointer: ->
    @.set 'pointerOffset', @getActiveOffset()
    @.set 'pointerSet', true

    pointer = $('.pointer')
    pointer.css 'top', @pointerOffset + 4
    pointer.show()

  slidePointer: (evt)->
    $('.pointer').transition
      y: @getActiveOffset() - @pointerOffset
    , 300

  hideSettings: (evt)->
    @.$().addClass 'fade-out'
    controller = @.get 'controller'

    Ember.run.later this, ->
      @.set 'isVisible', false
      @.$().removeClass 'fade-out'
      controller.transitionToPreviousRoute()
    , 300

  keyboardShortcuts: (evt)->
    unless $(document.activeElement).is 'input'
      # m => 'map'
      if evt.keyCode == 77
        @.get('controller').transitionToRoute 'settings.map'
      # n => 'note'
      if evt.keyCode == 78
        @.get('controller').transitionToRoute 'settings.note'
      # a => 'about'
      if evt.keyCode == 65
        @.get('controller').transitionToRoute 'settings.about'

    # esc => hide settings
    @hideSettings evt if evt.keyCode == 27

  click: (evt)->
    if $(evt.target).is '.close, .overlay'
      @hideSettings evt

  didInsertElement: ->
    $(document).on 'keyup.settings', @keyboardShortcuts.bind this

  willDestroyElement: ->
    $(document).off 'keyup.settings'

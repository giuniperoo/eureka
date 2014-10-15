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

  hideSettingsOnEsc: (evt)->
    if evt.keyCode == 27
      @hideSettings evt

  hideSettings: (evt)->
    @.$().addClass 'fade-out'
    controller = @.get 'controller'

    Ember.run.later this, ->
      @.set 'isVisible', false
      @.$().removeClass 'fade-out'
      controller.transitionToPreviousRoute()
    , 300

  click: (evt)->
    if $(evt.target).is '.close, .overlay'
      @hideSettings evt

  didInsertElement: ->
    $(document).on 'keyup.esc', @hideSettingsOnEsc.bind this

  willDestroyElement: ->
    $(document).off 'keyup.esc'

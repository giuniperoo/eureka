App.SettingsView = Ember.View.extend
  classNames: 'overlay'
  isVisible: Ember.computed.alias 'controller.active'
  classNameBindings: 'isVisible'

  fadeInMapSamples: ->
    @.$('.lazy').lazyload
      event: 'load'
      effect: 'fadeIn'
      placeholder: ''

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

  preventScroll: (->
    if @.get 'isVisible'
      window.scrollTo 0, 0
      $('body').css 'overflow', 'hidden'
    else
      $('body').css 'overflow', 'initial'
  ).observes 'isVisible'

  click: (evt)->
    if $(evt.target).is '.close, .overlay'
      @hideSettings evt

  didInsertElement: ->
    $(document).on 'keyup.esc', @hideSettingsOnEsc.bind this
    @fadeInMapSamples()

  willDestroyElement: ->
    $(document).off 'keyup.esc'

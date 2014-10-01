App.SettingsView = Ember.View.extend
  classNames: 'overlay'
  isVisible: Ember.computed.alias 'controller.active'
  classNameBindings: 'isVisible'

  fadeInMapSamples: (->
    Ember.run.scheduleOnce 'afterRender', this, '_fadeInMapSamples'
  ).on 'didInsertElement'

  _fadeInMapSamples: ->
    @.$('.lazy').lazyload
      effect: 'fadeIn'
      event: 'load'

  hideSettingsOnEsc: (evt)->
    if evt.keyCode == 27
      @hideSettings evt

  hideSettings: (evt)->
    @.$().addClass 'fade-out'
    controller = @.get('controller')
    Ember.run.later this, ->
      @.set 'isVisible', false
      @.$().removeClass 'fade-out'
      controller.transitionToRoute '/'
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
    $(document).on 'keyup', @hideSettingsOnEsc.bind this

  willDestroyElement: ->
    $(document).off 'keyup', @hideSettingsOnEsc.bind this

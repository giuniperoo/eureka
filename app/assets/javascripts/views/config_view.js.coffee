App.ConfigView = Ember.View.extend
  classNames: 'overlay'
  isVisible: Ember.computed.alias 'controller.active'
  classNameBindings: 'isVisible'

  hideConfigOnEsc: (evt)->
    if evt.keyCode == 27
      @hideConfig evt

  hideConfig: (evt)->
    @.$().addClass 'fade-out'
    Ember.run.later this, ->
      @.set 'isVisible', false
      @.$().removeClass 'fade-out'
    , 300

  click: (evt)->
    if $(evt.target).is '.close'
      @hideConfig evt

  didInsertElement: ->
    $(document).on 'keyup', @hideConfigOnEsc.bind(this)

  willDestroyElement: ->
    $(document).off 'keyup', @hideConfigOnEsc.bind(this)

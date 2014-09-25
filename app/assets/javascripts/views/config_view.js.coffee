App.ConfigView = Ember.View.extend
  classNames: 'overlay'
  isVisible: Ember.computed.alias 'controller.active'
  classNameBindings: 'isVisible'

  hideConfig: (evt)->
    if evt.keyCode == 27
      @.$().addClass 'fade-out'
      Ember.run.later this, ->
        @.set 'isVisible', false
        @.$().removeClass 'fade-out'
      , 300

  didInsertElement: ->
    $(document).on 'keyup', @hideConfig.bind(this)

  willDestroyElement: ->
    $(document).off 'keyup', @hideConfig.bind(this)

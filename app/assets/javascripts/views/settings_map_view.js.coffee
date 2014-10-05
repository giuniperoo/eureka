App.SettingsMapView = Ember.View.extend
  actions:
    selectMap: (name)->
      @.get('controller').selectMap name
      @.setActiveMapType name

  setActiveMapType: (mapType = @.get 'controller.mapType')->
    @.$('.maps li').removeClass 'active'
    @.$(".#{mapType}").addClass 'active'

  fadeInMapSamples: ->
    @.$('.lazy').lazyload
      event: 'load'
      effect: 'fadeIn'
      placeholder: ''

  didInsertElement: ->
    @fadeInMapSamples()
    @setActiveMapType()

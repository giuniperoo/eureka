App.SettingsSubView = Ember.View.extend
  didInsertElement: ->
    Ember.run.later(this, ->
      parentView = @.get 'parentView'
      if parentView.get('pointerSet') == true
        parentView.slidePointer()
      else
        parentView.setPointer()
    , 100)


App.SettingsAboutView = App.SettingsSubView.extend
  classNames: 'about'

  didInsertElement: ->
    @._super()

    eyeLeft  = new Eye 3, 13, 20, 'eyeLeft'
    eyeRight = new Eye 3, 13, 20, 'eyeRight'

    Ember.run.later(this, ->
      @.$('.smile, canvas').transition
        opacity: 1
        duration: 800
    , 3000)

App.SettingsNoteView = App.SettingsSubView.extend
  classNames: 'note'


App.SettingsMapView = App.SettingsSubView.extend
  tagName: 'ul'
  classNames: 'maps'

  actions:
    selectMap: (name)->
      @.get('controller').selectMap name
      @.setActiveMapType name

  setActiveMapType: (mapType = @.get 'controller.mapType')->
    @.$('li').removeClass 'active'
    @.$(".#{mapType}").addClass 'active'

  fadeInMapSamples: ->
    @.$('.lazy').lazyload
      event: 'load'
      effect: 'fadeIn'
      placeholder: ''

  didInsertElement: ->
    @._super()
    @fadeInMapSamples()
    @setActiveMapType()

App.SettingsSubView = Ember.View.extend

  fadeInImages: ->
    @.$('.lazy').lazyload
      event: 'load'
      effect: 'fadeIn'
      placeholder: ''

  didInsertElement: ->
    @fadeInImages()

    Ember.run.later(this, ->
      parentView = @.get 'parentView'
      if parentView.get('pointerSet') == true
        parentView.slidePointer()
      else
        parentView.setPointer()
    , 100)


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

  didInsertElement: ->
    @._super()
    @setActiveMapType()


App.SettingsNoteView = App.SettingsSubView.extend
  classNames: 'note'

  toggleEmoji: (->
    Ember.run.scheduleOnce('afterRender', this, '_toggleEmoji')
  ).observes 'controller.emojiActive'

  _toggleEmoji: ->
    if @.get 'controller.emojiActive'
      @.$('.status').text 'enabled'
      @.$('.emoji-container img').removeClass 'blackAndWhite'
      @.get('controller').toggleEmoji true
    else
      @.$('.status').text 'disabled'
      @.$('.emoji-container img').addClass 'blackAndWhite'
      @.get('controller').toggleEmoji false

  actions:
    selectFont: (name)->
      @.get('controller').selectFont name
      @.setActiveFont name

  setActiveFont: (font = @.get 'controller.font')->
    @.$('.font-list li').removeClass 'active'
    @.$(".#{font}").addClass 'active'

  didInsertElement: ->
    @._super()
    @setActiveFont()


App.SettingsAboutView = App.SettingsSubView.extend
  classNames: 'about'

  didInsertElement: ->
    @._super()

    eyeLeft  = new Eye 3, 13, 20, 'eyeLeft'
    eyeRight = new Eye 3, 13, 20, 'eyeRight'

    @.$('.yolo').transition
      x: 0
      opacity: 1
      duration: 400

    Ember.run.later(this, ->
      @.$('.smile, canvas')?.transition
        opacity: 1
        duration: 800
    , 3000)

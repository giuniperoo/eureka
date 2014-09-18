App.MapnoteTileView = Ember.View.extend
  tagName: 'li'
  templateName: 'mapnote-tile'

  removeMapnoteTile: ->
    @.$().addClass 'hidden'
    setTimeout (=>
      model = @controller.model
      model.destroyRecord()
      @controller.rerouteIfCurrent model.id
    ), 400

  click: (evt)->
    if $(evt.target).is '.delete'
      @removeMapnoteTile()

  didInsertElement: ->
    $clamp @.$('p').get(0), {clamp: 4}

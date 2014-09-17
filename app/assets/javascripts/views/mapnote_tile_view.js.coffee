App.MapnoteTileView = Ember.View.extend
  tagName: 'li'
  templateName: 'mapnote-tile'

  removeRecord: ->
    @.get('controller.model').destroyRecord()

  click: (evt)->
    if $(evt.target).is '.delete'
      @.$().addClass 'hidden'
      setTimeout (=> @removeRecord()), 400

  didInsertElement: ->
    $clamp @.$('p').get(0), {clamp: 4}

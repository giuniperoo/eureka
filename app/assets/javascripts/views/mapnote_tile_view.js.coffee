App.MapnoteTileView = Ember.View.extend
  tagName: 'li'
  templateName: 'mapnote-tile'

  didInsertElement: ->
    $clamp @.$('p').get(0), {clamp: 4}

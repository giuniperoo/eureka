App.MapnoteTileComponent = Ember.Component.extend
  didInsertElement: ->
    $clamp @.$('p').get(0), {clamp: 3}

App.MapnoteTileView = Ember.View.extend
  tagName: 'li'

  didInsertElement: ->
    $clamp @.$('p').get(0), {clamp: 4}

    @.$().find('.delete').click (evt)=>
      $('.confirm').fadeOut()
      @.$('.confirm').fadeIn()
      false

    @.$().find('.confirm').click (evt)=>
      @.$().addClass 'hidden'

Ember.Handlebars.registerBoundHelper 'time', (time)->
  moment(time).format 'lll'

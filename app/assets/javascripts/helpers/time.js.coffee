Ember.Handlebars.registerBoundHelper 'time', (time)->
  formattedTime = moment(time).format(
    '[<span class="time">]h:mma[</span>]
     [<span class="date">]dddd, M MMM[</span>]'
  )
  new Ember.Handlebars.SafeString formattedTime

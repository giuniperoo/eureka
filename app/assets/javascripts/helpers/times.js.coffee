Handlebars.registerHelper 'times', (n, block) ->
  (block.fn(i) for i in [0...n]).join ''

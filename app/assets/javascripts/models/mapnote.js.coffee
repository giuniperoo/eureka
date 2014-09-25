App.Mapnote = DS.Model.extend
  text:       DS.attr 'string'
  zoom:       DS.attr 'number'
  latitude:   DS.attr 'string'
  longitude:  DS.attr 'string'
  created:    DS.attr 'date'
  updated:    DS.attr 'date'

  didCreate: -> @.set 'active', true

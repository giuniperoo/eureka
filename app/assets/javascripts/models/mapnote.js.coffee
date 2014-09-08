App.Mapnote = DS.Model.extend
  title:     DS.attr 'string'
  note:      DS.attr 'string'
  latitude:  DS.attr 'string'
  longitude: DS.attr 'string'
  created:   DS.attr 'date'
  updated:   DS.attr 'date'

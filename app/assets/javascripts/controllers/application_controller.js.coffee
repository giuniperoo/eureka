App.ApplicationController = Ember.ArrayController.extend
  sortProperties: ['updated']
  sortAscending: false

  # validEntry: (->
  #   filtered = @.model.filter (mapnote)->
  #     !mapnote.get('isNew') &&    # don't display entries that haven't yet been saved
  #     !mapnote.get('isEmpty') ||  # don't display entries that have been deleted
  #     mapnote.get('isSaving')     # display entries that have been saved

  #   filtered.sortBy('updated').reverse()
  # ).property '@each'

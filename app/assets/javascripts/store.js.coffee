# http://emberjs.com/guides/models/#toc_store
# http://emberjs.com/guides/models/pushing-records-into-the-store/

App.ApplicationStore = DS.Store.extend({

})

App.ApplicationAdapter = DS.LSAdapter.extend({
  namespace: 'mapnote'
});

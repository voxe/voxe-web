class window.VoxeLive
  
  constructor: (options)->
    window.app = {models: {}, collections: {}, views:{}}
        
    comparisons = new ComparisonsCollection()
    
    comparisonsListView = new ComparisonsListView(collection: comparisons)
    $("#app").append comparisonsListView.render().el
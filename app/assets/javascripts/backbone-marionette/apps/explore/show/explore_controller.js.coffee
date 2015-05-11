@Ebet.module "Explore.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      @categories = App.categories

      @layout =  @getCategoryView @categories
      
      @listenTo @layout,"search",(args)=>
        text = args.view.$el.find(".typeahead").val()
        auctions = args.collection.get(1).get("auctions")
        auctions.query = text
        App.request "auction:entities", auctions
           
      @show @layout, loading : true

    getCategoryView: (categories)->
      new Show.Auctions
        collection : categories


@Ebet.module "ShowCase.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize:(options) ->
      { auction } = options
      App.categories = App.request "categories:entities"
      categories = App.categories
      @layout = @getLayout categories
      model = new App.Entities.Model({ value : 1})

      @listenTo @layout, "show", =>
        first_auction = categories.first().get("auctions").first()
        
        if auction
          categories.chooseById(auction.get("category_id"))
          category = categories.getChosen()
          auctions = category[0].get("auctions") 
          @showCategoriesRegion categories, category
          auctions.chooseById(auction.id)
          auction = auctions.getChosen().pop()
    
          @auctionsRegion category[0].get("auctions")
          @mainAuctionRegion auction
          @showBetRegion model , auction
        
        else
          first_auction.choose()
          @showCategoriesRegion categories
          @auctionsRegion categories.first().get("auctions")
          @mainAuctionRegion first_auction
          @showBetRegion model , first_auction

      @show @layout, loading : true

    showCategoriesRegion: (categories,category)->
      @categoriesView = @getCategoriesRegion categories, category
      @listenTo @categoriesView, "select:category",(args)->
        #get the value from selector
        name = args.view.$el.find(".select").val()
        unless @mainAuctionView.model.collection.parents[0].get("name") == name.trim()
          #choose the categroy by name
          args.collection.chooseByName(name.trim())
          category = args.collection.getChosen()
          #get the auctions from category
          @auctionsRegion category[0].get("auctions")
          #envia el auction al bet module
          App.vent.trigger "send:auction",category[0].get("auctions").first()
          #choose the first auction from collection
          category[0].get("auctions").first().choose()
          #show the mainAuction with the first auction
          @mainAuctionRegion category[0].get("auctions").first()

      @show @categoriesView, region : @layout.categories_region

    auctionsRegion:(auctions) ->
      @auctionsView = @getAuctionsRegion auctions
      #Envia el modelo que se ha clickeado a la vista de main auction y envia el id al bet view
      @auctionsView.on "childview:change:main:auction",(args)=>
        unless @mainAuctionView.options.model.id == args.model.id
          @mainAuctionRegion args.model
          args.model.choose()
          App.vent.trigger "send:auction",args.model
          App.vent.trigger "change:main_auction"

      @show @auctionsView , region : @layout.auctions_region

    mainAuctionRegion:(auction)->
      @mainAuctionView = @getMainAuctionRegion auction
      @show @mainAuctionView, region : @layout.main_auction_region

    showBetRegion: (bet,auction)->
      betRegionView = @getBetRegion bet, auction

      @listenTo betRegionView, "bet:now",(args)=>
        App.vent.trigger "show:bet:now",args.model,args.view.options.auction

      @show betRegionView, region : @layout.bet_region

    getCategoriesRegion: (categories,category)->
      new Show.Categories
        collection : categories
        category : category

    getAuctionsRegion:(auctions)->
      new Show.Auctions
        collection : auctions

    getBetRegion: (bet,auction) ->
      new Show.Bets
        model : bet
        auction : auction

    getMainAuctionRegion:(auction)->
      new Show.MainAuction
        model : auction

    getLayout: (auctions) ->
      new Show.Layout
        collection : auctions
      

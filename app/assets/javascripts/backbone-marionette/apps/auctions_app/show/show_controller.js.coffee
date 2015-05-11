@Ebet.module "AuctionsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: ->
      auctions = App.request "get:user:auctions", App.currentUser
      @layout = @getLayout auctions

      @listenTo @layout, "show", =>
        auctions_open = App.request "get:open:auctions",auctions
        @showActiveAuctions auctions_open

        auctions_close = App.request "get:close:auctions", auctions
        @showCloseAuctions auctions_close

      @show @layout, loading :true
  
    showActiveAuctions: (auctions)->
      activeAuctionsView = @getActiveAuctions auctions

      @listenTo activeAuctionsView,"childview:show:auction",(args)->
        App.vent.trigger "show:home", args.model

      @show activeAuctionsView, region : @layout.activeAuctions

    showCloseAuctions: (auctions)->
      closeAuctionsView = @getCloseAuctions auctions
      @show closeAuctionsView, region : @layout.closeAuctions

    getActiveAuctions : (auctions)->
      new Show.ListActiveAuctions
        collection : auctions

    getCloseAuctions: (auctions)->
      new Show.ListCloseAuctions
        collection : auctions

    getLayout: (auctions) ->
      new Show.Layout
        collection : auctions

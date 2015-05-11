@Ebet.module "AuctionsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "auctions_app/show/layout"
    className : "auctions"

    regions:
      activeAuctions: "#active-auctions"
      closeAuctions : "#close-auctions"

  class Show.ListActiveAuction extends App.Views.ItemView
    compiledTemplate = "auctions_app/show/open_auction"
    template : compiledTemplate
    className: "auction-wrapper"

    triggers:
      "click " : "show:auction"

    onRender: ->
      App.startClock @model.get("finish_time"), @
      App.setBetBar @model.id ,@, @model.get("total_bets")
      App.setBetProgressAmount @model.get("bets_on_auction"), @model.id, @

  class Show.ListActiveAuctions extends App.Views.CompositeView
    template: "auctions_app/show/composite_auction_open"
    itemView : Show.ListActiveAuction
  
    serializeData : ->
      "number_auctions": @collection.length


  class Show.ListCloseAuction extends App.Views.ItemView
    template : "auctions_app/show/close_auction"
    className: "auction-wrapper"


  class Show.ListCloseAuctions extends App.Views.CompositeView
    template: "auctions_app/show/composite_auction_close"
    itemView : Show.ListCloseAuction

    serializeData : ->
      "number_auctions": @collection.length





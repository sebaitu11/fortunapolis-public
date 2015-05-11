@Ebet.module "Explore.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Auction extends App.Views.ItemView
    compiledTemplate = "explore/show/auction"
    template : compiledTemplate
    className: "auction-wrapper"

    serializeData: ->
      "items" : @model.get("auctions")
      "title" : @model.get("name")

  class Show.Auctions extends App.Views.CompositeView
    template : "explore/show/auctions"
    itemView: Show.Auction
    itemViewContainer : ".auctions"
    className : "container-category"

    triggers:
      "search #query" : "search"

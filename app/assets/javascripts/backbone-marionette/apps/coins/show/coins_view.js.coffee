@Ebet.module "Coins.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Pack extends App.Views.ItemView
    compiledTemplate = "coins/show/pack"
    template : compiledTemplate

    triggers:
      "click .buy-now" : "buy:now"

  class Show.Coins extends App.Views.CompositeView
    compiledTemplate = "coins/show/coins"
    template : compiledTemplate
    itemViewContainer : ".packs"
    itemView : Show.Pack
    className : "coins"

    serializeData: ->
      "coins" : @options.coins
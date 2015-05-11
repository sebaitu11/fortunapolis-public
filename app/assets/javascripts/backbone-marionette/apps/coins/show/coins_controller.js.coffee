@Ebet.module "Coins.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: () ->
      @userCoins = App.currentUser.get("tickets").length
      packs = App.request "pack:entities"
      
      @layout =  @getCoinsView @userCoins, packs
      coins = new App.Entities.CoinsCollection()
      
      @listenTo @layout, "childview:buy:now",(args)->  
        i = 0
        while i < args.model.get("amount")
          coins.add new App.Entities.Coin({valor:990})
          i++
        
        App.commands.execute "buy:coins",coins

      @show @layout, loading : true

    getCoinsView: (coins,packs)->
      new Show.Coins
        collection : packs
        coins : coins


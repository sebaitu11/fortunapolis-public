@Ebet.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Coin extends App.Entities.Model
    urlRoot: -> Routes.tickets_path()
  
  class Entities.CoinsCollection extends App.Entities.Collection
    model : Entities.Coin
  
  API =
    buyCoins: (coins)->
      _.each coins.models,(coin)->
        coin.save null, 
          headers :
            "Authorization": "Token token=" + App.currentUser.get("authentication_token")
      coins

  App.commands.setHandler "buy:coins",(coins) ->
    API.buyCoins coins
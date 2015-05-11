@Ebet.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Bet extends App.Entities.Model
    urlRoot: -> Routes.bets_path()

  class Entities.BetCollection extends App.Entities.Collection
    model : Entities.Bet
  
  API =
    betNow: (bets)->
      _.each bets.models,(bet)->
        bet.save null,
          reset :true
          headers :
            "Authorization": "Token token=" + App.currentUser.get("authentication_token")
      bets

  App.commands.setHandler "bet:request:api",(bets) ->
    API.betNow bets
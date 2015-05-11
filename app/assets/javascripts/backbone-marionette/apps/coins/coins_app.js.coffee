@Ebet.module "Coins", (Coins, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class Coins.Router extends App.Router.notUser
    appRoutes:

      "coins(/)"     : "show"
  
  API =
    show:  ->
      App.vent.trigger "nav:choose", "Coins"
      new Coins.Show.Controller
        region: App.mainRegion
    
  App.addInitializer ->
    new Coins.Router
      controller : API


  App.vent.on "show:coins" , ->
    App.navigate "coins", trigger: false
    API.show()
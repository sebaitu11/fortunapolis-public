@Ebet.module "AuctionsApp", (AuctionsApp, App, Backbone, Marionette, $, _) ->

  class AuctionsApp.Router extends App.Router.notUser
    appRoutes:

      "auctions"  : "showAuctions"

  API =
    showAuctions : ->
      App.vent.trigger "nav:choose", "Auctions"  
      new AuctionsApp.Show.Controller
        region : App.mainRegion
  
  App.addInitializer ->
    new AuctionsApp.Router
      controller : API

  #Metodos para routear sin trigger
  @listenTo App.vent, "show:auctions" , ->
    App.navigate "auctions" , trigger: false
    API.showAuctions()
      
      
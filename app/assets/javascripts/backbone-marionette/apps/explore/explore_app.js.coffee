@Ebet.module "Explore", (Explore, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class Explore.Router extends App.Router.notUser
    appRoutes:

      "explore(/)"     : "show"
  
  API =
    show:  ->
      App.vent.trigger "nav:choose", "Explore"
      new Explore.Show.Controller
        region: App.mainRegion
    
  App.addInitializer ->
    new Explore.Router
      controller : API


  App.vent.on "show:explore" , ->
    App.navigate "explore", trigger: false
    API.show()
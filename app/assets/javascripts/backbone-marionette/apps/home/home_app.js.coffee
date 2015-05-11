@Ebet.module "Home", (Home, App, Backbone, Marionette, $, _) ->

  class Home.Router extends Marionette.AppRouter
    appRoutes:

      ".*(/)"     : "show"
      
  API =
    show: ->
      App.module("BottomMenu").stop()
      new Home.Show.Controller
        region: App.mainRegion
  
  App.addInitializer ->
    new Home.Router
      controller : API

  #Metodos para routear sin trigger
  App.vent.on "show:home:page" , ->
    App.navigate "/", trigger: false
    API.show()
      
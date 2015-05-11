@Ebet.module "ShowCase", (ShowCase, App, Backbone, Marionette, $, _) ->

  class ShowCase.Router extends App.Router.notUser
    appRoutes:

      "home(/)"   : "show"
  
  API =
    show: (auction)->
      App.vent.trigger "nav:choose", "Home" if App.navs
      App.module("BottomMenu").start(App.navs)
      new ShowCase.Show.Controller
        region: App.mainRegion  
        auction : auction
  
  App.addInitializer ->
    new ShowCase.Router
      controller : API
      
  #Metodos para routear sin trigger
  @listenTo App.vent ,"show:home" , (auction)->
    App.navigate "home", trigger: false
    API.show(auction)
      
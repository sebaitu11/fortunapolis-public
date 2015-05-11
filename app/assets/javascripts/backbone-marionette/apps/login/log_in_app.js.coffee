@Ebet.module "Login", (Login, App, Backbone, Marionette, $, _) ->

  class Login.Router extends App.Router.User 
    appRoutes:

      "login(/)"     : "show"
   
  API =
    show: ->
      new Login.Show.Controller
        region: App.mainRegion
  
  App.addInitializer ->
    new Login.Router
      controller : API

  #Metodos para routear sin trigger
  App.vent.on "show:login" , ->
    App.navigate "login", trigger: false
    API.show()
      
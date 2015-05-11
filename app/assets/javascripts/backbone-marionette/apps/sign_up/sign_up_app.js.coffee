@Ebet.module "SignUp", (SignUp, App, Backbone, Marionette, $, _) ->

  class SignUp.Router extends App.Router.User 
    appRoutes:

      "register(/)"     : "show"
      
  API =
    show: ->
      new SignUp.Show.Controller
        region: App.mainRegion
  
  App.addInitializer ->
    new SignUp.Router
      controller : API

  #Metodos para routear sin trigger
  @listenTo App.vent , "show:signup" , ->
    App.navigate "register", trigger: false
    API.show()
      
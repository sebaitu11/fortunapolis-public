@Ebet.module "UserProfile", (UserProfile, App, Backbone, Marionette, $, _) ->

  class UserProfile.Router extends App.Router.notUser
    appRoutes:

      "profile(/)"     : "show"
   
  API =
    show: ->
      App.vent.trigger "nav:choose", "Profile" 
      new UserProfile.Show.Controller
        region: App.mainRegion
  
  App.addInitializer ->
    new UserProfile.Router
      controller : API

  #Metodos para routear sin trigger
  @listenTo App.vent ,"show:profile" , ->
    App.navigate "profile", trigger: false
    API.show()
      
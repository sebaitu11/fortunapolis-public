@Ebet.module "Components.SuccessLogin", (SuccessLogin, App, Backbone, Marionette, $, _) ->
   
  App.commands.setHandler "success:login:register", (args,user_session) ->
    if user_session 
      App.currentUser = new App.Entities.UserSession args.attributes
    else
      App.currentUser = args 

    App.vent.trigger "show:home"

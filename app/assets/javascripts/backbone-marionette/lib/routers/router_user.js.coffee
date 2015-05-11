@Ebet.module "Router", (Router, App, Backbone, Marionette, $, _) ->

  class Router.User extends Marionette.AppRouter

    before : ->
      if App.currentUser
        if App.currentUser.isDestroyed() == false || App.currentUser.isDestroyed() == undefined
          App.vent.trigger "show:home"
          return false 
      

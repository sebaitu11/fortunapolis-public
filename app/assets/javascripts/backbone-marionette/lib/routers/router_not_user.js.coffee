@Ebet.module "Router", (Router, App, Backbone, Marionette, $, _) ->

  class Router.notUser extends Marionette.AppRouter

    before : ->
      if App.currentUser
        if App.currentUser.isDestroyed()
          App.vent.trigger "show:login"
          return false 
      else
        App.vent.trigger "show:login"
        return false

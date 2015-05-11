@Ebet.module "BottomMenu", (BottomMenu, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    list: (navs) ->
      App.vent.trigger "nav:choose", "Home"
      new BottomMenu.List.Controller
        region: App.bottomRegion
        navs: navs
    
  BottomMenu.on "start",(navs)->
    API.list navs

  BottomMenu.on "stop", () ->
    App.bottomRegion.close()
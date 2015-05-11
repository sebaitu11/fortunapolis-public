@Ebet.module "BottomMenu.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application

    initialize: (options) ->
      { navs } = options
      user = App.currentUser

      @listView = @getListView navs, user

      @listenTo App.currentUser, "sync" ,(model)=>
        @listView.render()
        
      @show @listView

    getListView: (navs,options = {}) ->
      new List.Header
        collection: navs
        user: options
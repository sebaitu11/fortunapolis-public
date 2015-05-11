@Ebet.module "UserProfile.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: ->
      user = App.currentUser
      @layout = @getLayout user

      @listenTo user, "destroy",(model)->
        App.vent.trigger "show:home:page"

      @listenTo user, "sync",(model)->
        App.commands.execute "show:modal", "Successfully Changed", "fa-check","success-modal"
          
      @listenTo @layout, "update:user",(args)->
        if args.model.get("changed")
          App.commands.execute "update:user:api",args.model
      
      @listenTo @layout ,"logout:request",(args)->
          App.commands.execute "logout:request:api", args.model
      
      @show @layout, loading :true

    getLayout: (user) ->
      new Show.Layout
        model : user


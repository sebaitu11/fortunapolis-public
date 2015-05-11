@Ebet.module "SignUp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: ->
      user = new App.Entities.UserRegistration
      @layout = @getLayout user
      
      @listenTo @layout, "register:user",(args)=>
        App.request "register:user",args.model

      @listenTo user,"sync",(args)->
        App.commands.execute "success:login:register", args,true

      @show @layout, loading :true

    closeLayout : ->
      @layout.close()

    getLayout: (user) ->
      new Show.Item
        model : user

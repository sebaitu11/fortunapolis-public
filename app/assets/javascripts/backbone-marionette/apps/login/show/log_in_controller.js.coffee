@Ebet.module "Login.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      # { navs } = options
      model = new App.Entities.UserSession 
      @logInView = @getLogInView model

      #success login to server
      @listenTo model, "sync",(model)=>
        App.commands.execute "success:login:register", model,false
        @logInView.$el.spin(false)
      
      @listenTo model, "error",(model)=>
        @logInView.$el.spin(false)
        @logInView.$el.find("form").css("opacity",1)
        App.commands.execute "show:modal", model.get("_errors").error, "fa-exclamation","error-modal"

      @listenTo @logInView, "login:request", (args)->
        if args.model.isValid(true)                
          args.view.$el.find("form").css("opacity",0.3)
          args.view.$el.spin({color: '#fff' })
          App.commands.execute "login:request:api", args.model 
        
      @show @logInView, loading:true

    getLogInView: (model) ->
      new Show.Login
        model : model

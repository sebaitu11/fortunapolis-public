@Ebet.module "Home.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      model = new App.Entities.Model 
      @homeView = @getHome model
      
      @show @homeView, loading :true

    getHome: (model) ->
      new Show.Home
        model : model


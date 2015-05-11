@Ebet.module "SignUp.Show", (Show, App, Backbone, Marionette, $, _) ->


  class Show.Item extends App.Views.ItemView
    template: "sign_up/show/signup"
    className: "sign-up-view"

    triggers :
      "submit" : "register:user"

    modelEvents:
      "error"    : "render showNotify"

    initialize :->
      @modelBinder = new Backbone.ModelBinder()

    onRender: ->
      @modelBinder.bind @model, @$el
      setTimeout (=>
        @$el.find("input[name=email]").focus()
      ), 1

    showNotify: (args) ->
      if !@$el.find("input").val()
        message = "Write your email and password"
      else
        message = "Ops We have an error"
      App.commands.execute "show:notify", message
@Ebet.module "Login.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Login extends App.Views.ItemView
    template : "login/show/login"

    events :
      "keyup input" : "checkValues"

    triggers:
      "submit" : "login:request"

    initialize :->
      @modelBinder = new Backbone.ModelBinder()
      Backbone.Validation.bind(@, {invalid: @handleInvalid, valid: @validParams})
  
    onRender: (options = {})->
      @modelBinder.bind @model, @$el
      @$el.find(".login").attr("disabled","disabled")
    
    validParams:(view, attr, error, selector) =>
      @removeError attr

    handleInvalid: (view, attr, error, selector) =>
      @removeError attr
      @$el.find("input[name=" + attr + "]").after("<p class='errors " + attr + "'>" + error + "</p>")

    checkValues: ->
      if @$el.find("input[name=email]").val() != "" && @$el.find("input[name=password]").val() != "" 
        @$el.find(".login").attr("disabled",false).css("background","#648f00")
      else
        @$el.find(".login").attr("disabled","disabled").css("background","#ccc")

    removeError: (attr)->
      @$el.find("." + attr + "").remove()      


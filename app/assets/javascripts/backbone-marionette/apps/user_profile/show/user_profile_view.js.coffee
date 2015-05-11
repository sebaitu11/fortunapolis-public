@Ebet.module "UserProfile.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.ItemView
    template : "user_profile/show/user_info"
    id : "user-info"

    events:
      "click .toggle-button" : "toggleModify"

    triggers :
      "click .button"      : "logout:request"

    modelEvents:
      "change" : "changedModel"

    initialize: ->
      @modelBinder = new Backbone.ModelBinder()

    onRender:->
      @modelBinder.bind @model, @$el

    changedModel:(args) ->
      if args.changed.modify == true || args.changed.modify == false
        @model.set("changed",false) 
      else
        @model.set("changed",true) 

    toggleModify: ->
      toggle = @$el.find(".toggle-button").toggleClass("update")
      
      if @model.get("modify")
        @trigger "update:user", @
        @model.set("modify",false)
        toggle
        @render()
        @$el.find(".toggle-button p").text("Modify")
      else
        @model.set("modify",true)
        toggle
        @render()
        @$el.find(".toggle-button p").text("Update")




@Ebet.module "BottomMenu.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Nav extends App.Views.ItemView
    tagName: "li"
    template : "bottom_menu/list/_nav"

    events :
      "click" : "gotoPage"

    gotoPage: (e)->
      e.preventDefault()
      App.vent.trigger "show:" + @model.get("url") unless Backbone.history.fragment == @model.get("url")

    initialize: ->
      @model.set("tickets",@options.user.get("tickets").length) if @model.get("coins")
    
    @include "Chooseable"

  class List.Header extends App.Views.CompositeView
    template: "bottom_menu/list/bottom"
    itemView: List.Nav
    itemViewContainer: "#nav-links"

    itemViewOptions : ->
      user: @options.user
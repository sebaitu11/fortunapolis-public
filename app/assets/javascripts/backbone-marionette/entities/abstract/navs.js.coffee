@Ebet.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Nav extends Entities.Model
    isDivider: -> @get("divider")

  class Entities.NavsCollection extends Entities.Collection
    model: Entities.Nav

    chooseByName: (nav) ->
      @choose (@findWhere(name: nav) or @first())

    @include "SingleChooser"

  API =
    getNavs: ->
      new Entities.NavsCollection [
        { name: "Home",  url: "home", icon: "fa fa-home",id : "home" , active: "active" }
        { name: "Explore", url: "explore" , icon: "fa  fa-globe",id : "explore"}
        { name: "Auctions",url: "auctions", icon: "fa fa-gavel" ,id : "auctions"}
        { name: "Coins",url: "coins", icon: "fa  fa-circle" ,id : "tickets", coins:true}
        { name: "Profile", url: "profile", icon: "fa fa-user" ,id : "profile"}
      ]

  App.reqres.setHandler "nav:entities", ->
    API.getNavs()
@Ebet.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.UserSession extends App.Entities.Model
    urlRoot: -> Routes.user_session_path()  

    validation:
      email:
        pattern: 'email'
      password:
        minLength: 8

    relations: [
     {
      type: Backbone.Many
      key: 'auctions'
      relatedModel:Entities.Auction
      collectionType : Entities.AuctionCollection
     },
     {
      type: Backbone.Many
      key: 'tickets'
      relatedModel:Entities.Coin
      collectionType : Entities.CoinsCollection
     }
    ]
    
  API =
    updateUser: (user)->
      user.save null,
        url : "/users/" + user.id
        headers :
          "Authorization": "Token token=" + user.get("authentication_token")
      user

    logInUser: (user)->
      user.on "all", (e) -> console.log(e)
      user.save null,
        headers:
          'X-CSRF-Token' + $("meta[name='csrf-param']").attr('content')
        success:(response)->
          response.unset("password")
        error:(response,xhr)->
          response.saveError response, xhr
      user

    logOutUser : (user)->
      user.on "all", (e) -> console.log(e)
      user.destroy
        url: "users/sign_out"
      user

    getCurrentUser: (current_user)->
      current_user.fetch
        url: Routes.user_path(current_user.id) 
        headers :
          "Authorization": "Token token=" + current_user.get("authentication_token") 
      current_user
             
  App.commands.setHandler "login:request:api",(user)->
    API.logInUser user

  App.commands.setHandler "logout:request:api",(user)->
    API.logOutUser user

  App.commands.setHandler "update:user:api",(user)->
    API.updateUser user

  App.commands.setHandler "current:user",(user)->
    API.getCurrentUser user

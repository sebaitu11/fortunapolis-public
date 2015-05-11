@Ebet.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Auction extends App.Entities.Model
    urlRoot: -> Routes.auction_path()

    relations: [
      {
        type: Backbone.One
        key: 'category'
        relatedModel: Entities.Category
      }
    ]

  class Entities.AuctionCollection extends App.Entities.Collection
    model: Entities.Auction

    url: -> 
      if @query then "/auctions?query=" + encodeURIComponent(@query) else "/auctions"

    chooseByName: (id) ->
      @choose (@findWhere(id: id) or @first())

    @include "SingleChooser"

  API =
    getAuctions: (auctions)->
      auctions.fetch
        reset: true      
      auctions

    getUserAuctions: (user)->
      auctions = new Entities.AuctionCollection
      auctions.fetch
        url : Routes.user_auctions_path(user.id)
        headers :
          "Authorization": "Token token=" + user.get("authentication_token")
      auctions

    getOpenAuctions:(auctions) ->
      open = auctions.where({state:"open"})
      open_auctions = new Entities.AuctionCollection open
      open_auctions

    getCloseAuctions:(auctions) ->
      close = auctions.where({state:"closed"})
      close_auctions = new Entities.AuctionCollection close
      close_auctions
    
    newAuction: ->
      new Entities.Auction

  App.reqres.setHandler "auction:entities",(auctions) ->
    API.getAuctions(auctions)

  App.reqres.setHandler "new:auction:entity", ->
    API.newAuction()

  App.reqres.setHandler "get:user:auctions",(user) ->
    API.getUserAuctions(user)
  
  App.reqres.setHandler "get:open:auctions",(auctions) ->
    API.getOpenAuctions auctions

  App.reqres.setHandler "get:close:auctions",(auctions) ->
    API.getCloseAuctions auctions
  # App.reqres.setHandler "crew:entity", (id) ->
  #   API.getCrewMember id
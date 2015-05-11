@Ebet.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Category extends App.Entities.Model
    urlRoot: -> Routes.category_path()
    
    relations: [
      {
        type: Backbone.Many
        key: 'auctions'
        relatedModel: Entities.Auction
        collectionType : Entities.AuctionCollection
        }  
      ]

  class Entities.CategoriesCollection extends App.Entities.Collection
    model : Entities.Category

    url: -> Routes.categories_path()

    chooseByName: (name) ->
      @choose (@findWhere(name: name) or @first())

    @include "SingleChooser"

  API =
    getCategoires: ->
      categories = new Entities.CategoriesCollection
      categories.fetch
        reset: true      
      categories

  App.reqres.setHandler "categories:entities", ->
    API.getCategoires()
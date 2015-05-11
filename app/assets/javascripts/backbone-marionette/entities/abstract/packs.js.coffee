@Ebet.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Pack extends Entities.Model

  class Entities.PacksCollection extends Entities.Collection
    model: Entities.Pack

  API =
    getPacks: ->
      new Entities.PacksCollection [
        { name: "Basic",  amount: 2, value: 4 }
        { name: "Advanced", amount: 11 , value: 20}
        { name: "Expert",amount: 28, value: 50}
        { name: "Pro",amount: 60, value: 100}
      ]

  App.reqres.setHandler "pack:entities", ->
    API.getPacks()
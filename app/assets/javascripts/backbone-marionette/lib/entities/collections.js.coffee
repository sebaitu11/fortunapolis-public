@Ebet.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Collection extends Backbone.Collection

    search : (letters) ->
      return this  if letters is ""
      pattern = new RegExp("^" + letters,["gm"])
      _ @filter((model) ->
        model.get("product").name.match(pattern)
        pattern.test model.get("product").name
      )
@Ebet.module "Components.SelectedItem", (SelectedItem, App, Backbone, Marionette, $, _) ->
   
  App.reqres.setHandler "normal:item", (total,position) ->
    base = 24
    if position > 2
      p = position - 2
      number = base + 100 * p

    return if position is 2 then number = 39 + "px" else number + "px"

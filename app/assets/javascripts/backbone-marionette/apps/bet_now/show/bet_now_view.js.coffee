@Ebet.module "BetNow.Modal", (Modal, App, Backbone, Marionette, $, _) ->

  class Modal.ModalView extends App.Views.ItemView
    template : "bet_now/show/modal"
    className : "modal fade" 
    
    triggers :
      "click .bet-now-button-modal" : "api:bet"

    events :
      "click i" : "exit"

    serializeData: ->
      "product" : @options.auction.get("product")
      "value"   : @model.get("value")
      "coins"   : @model.get("coins_amount")

    onRender: ->
      @$el.modal("show")
      # setTimeout (=>
      #   @$el.modal("hide")
      # ),2000

    exit: ->
      @$el.modal("hide")
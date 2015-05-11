@Ebet.module "BetNow", (BetNow, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    show: (bet,auction) ->
      new BetNow.Modal.ModalController
        region: App.modalRegion
        bet: bet
        auction: auction
    
  @listenTo App.vent, "show:bet:now",(bet,auction)->
    API.show bet,auction

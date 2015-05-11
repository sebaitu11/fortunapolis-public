@Ebet.module "BetNow.Modal", (Modal, App, Backbone, Marionette, $, _) ->

  class Modal.ModalController extends App.Controllers.Application

    initialize : (options)->
      { bet,auction } = options

      @modalView = @getModalView bet,auction
      bets = new App.Entities.BetCollection()

      @listenTo bets,"sync",(args)->
        @modalFinish()
        # App.commands.execute "current:user",App.currentUser
        App.commands.execute "show:modal", "Successfully Created", "fa-check","success-modal"
        App.navigate "auctions", trigger: true

      @listenTo bets,"error",(args)->
        @modalFinish()
        App.commands.execute "show:modal", args.get("_errors").bet , "fa-exclamation","error-modal"

      @listenTo @modalView, "api:bet",(args)->
        args.view.$el.spin({color: '#333' })
        auction = args.view.options.auction
        i = 0
        while i < args.model.get("value")
          bets.add new App.Entities.Bet({auction_id : auction.id })
          i++
        
        App.commands.execute "bet:request:api",bets
      
      @show @modalView
      
    modalFinish :->
      @modalView.$el.modal("hide")
      $('body').removeClass('modal-open')
      $('.modal-backdrop').remove()
      @modalView.$el.spin(false)

    getModalView:(bet,auction) ->
      new Modal.ModalView
        model: bet
        auction : auction

@Ebet.module "ShowCase.Show", (Show, App, Backbone, Marionette, $, _) ->
  
  class Show.Layout extends App.Views.Layout
    template: "show_case/show/layout"
    regions:
      
      categories_region: "#categories-auctions"
      auctions_region: "#auctions-region"
      main_auction_region: "#main-auction"
      bet_region : "#bet-region"

  class Show.Category extends App.Views.ItemView
    template: "show_case/show/category"
    tagName: "option"

  class Show.Categories extends App.Views.CompositeView
    template: "show_case/show/categories"
    itemView: Show.Category
    itemViewContainer: ".select"

    triggers:
      "focusout .select" : "select:category"

    onRender: ->
      if @options.category
        @$el.find("." + @options.category[0].id).parent().attr("selected",true)

  class Show.Auction extends App.Views.ItemView
    compiledTemplate = "show_case/show/auction"
    template : compiledTemplate
    tagName : "li"
  
    triggers:
      "click " : "change:main:auction"

    modelEvents:
      "change:chosen" : "chosenAuction"

    onRender: ->
      if @model.isChosen() then @chosenAuction(@model)

    chosenAuction:(model) ->
      if model.isChosen() then @$el.toggleClass("active-slider") else @$el.toggleClass("active-slider")

  class Show.Auctions extends App.Views.CompositeView
    template: "show_case/show/auctions"
    itemView : Show.Auction
    itemViewContainer : ".slidee"

    onShow: ->
      @setTopSlider()
      size = @$el.find(".slidee li").size()
      position = @$el.find(".active-slider").index()
      i = App.request "normal:item", size,position
      @$el.find(".slidee").css({"-webkit-transform":"translate(-#{i},0px)"})

    setTopSlider:->
      new Sly(@$el.find(".frame"),{activeClass:"active-null",horizontal:true,swingSpeed:0.1 ,releaseSwing: true,touchDragging: true,mouseDragging: true,itemNav: "basic"}).init()
    
  class Show.MainAuction extends App.Views.ItemView
    template : "show_case/show/main_auction"
    className : "showcase"

    events :  
      "click .description" : "showDescription"
    
    onRender: ->
      App.startClock @model.get("finish_time"), @
      App.setBetBar @model.id, @, @model.get("total_bets")
      App.setBetProgressAmount @model.get("bets_on_auction"),@model.id, @
  
    showDescription: ->
      @$el.find(".hide-description").slideToggle(()=>
        if @$el.find(".fa").hasClass("fa-plus-square-o")
          @$el.find(".fa-plus-square-o").addClass("fa-minus-square-o").removeClass("fa-plus-square-o")
        else
          @$el.find(".fa-minus-square-o").addClass("fa-plus-square-o").removeClass("fa-minus-square-o")
        )
    
    onClose: ->
      @model.unchoose()

  class Show.Bets extends App.Views.ItemView
    template: "show_case/show/bets"

    events:
      "click .plus" : "addOneBet"
      "click .minus": "removeOneBet"

    triggers:
      "click .bet-button" : "bet:now"
    
    modelEvents:
      "change" : "render"
    
    initialize:->
      @changeCoins()
      @listenTo App.vent,"change:main_auction", (args)=>
        @ticketsValue()
        @render()

      @listenTo App.vent, "send:auction", (args)=>
        @options.auction = args
        @changeCoins()

    changeCoins : ->
      @model.set("coins_amount",@options.auction.get("tickets_by_bet"))

    ticketsValue: ->
      @model.set("coins_amount", @options.auction.get("tickets_by_bet") * @model.get("value"))      

    addOneBet: (e)->
      e.preventDefault()
      e.stopPropagation()
      @model.set("value",@model.get("value") + 1)
      @ticketsValue()

    removeOneBet: (e)->
      e.preventDefault()
      e.stopPropagation()
      @model.set("coins_amount", @model.get("coins_amount") - @options.auction.get("tickets_by_bet")) if @model.get("value") > 1
      @model.set("value",@model.get("value") - 1) if @model.get("value") > 1




@Ebet = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.on "initialize:before", (options) ->
    App.environment = options.environment
    App.navs = App.request "nav:entities"

  App.addRegions  
    headerRegion : "#header-region"
    mainRegion   : "#main-region"
    bottomRegion : "#bottom-menu"
    modalRegion : "#modal-region"

  App.rootRoute = "/"
  
  App.addInitializer ->
    App.module("Home").start()
  
  App.vent.on "nav:choose", (nav) -> App.navs.chooseByName nav
  App.reqres.setHandler "concern", (concern) -> App.Concerns[concern]

  #funciones que se utilizan en toda la App
  App.startClock =(time,context) ->
    date  = new Date(time);
    hours = date.getHours()
    minutes = date.getMinutes()
    seconds = date.getSeconds()
    context.$el.find(".countdown").countEverest({hour: hours,minute: minutes,second:seconds})

  App.setBetBar = (id,self,total)->
    self = self
    self.$el.find("#progressbar-" + id).progressbar
      warningMarker: false
      dangerMarker:false
      maximum: total
      step: 1

  App.setBetProgressAmount = (amount,id,self)->
    self = self
    self.$el.find("#progressbar-" + id).progressbar "setPosition", amount


  App.on "initialize:after", ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  App

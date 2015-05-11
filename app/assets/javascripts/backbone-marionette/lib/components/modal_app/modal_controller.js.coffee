@Ebet.module "Components.Modal", (Modal, App, Backbone, Marionette, $, _) ->

  class Modal.ModalController extends App.Controllers.Application

    initialize : (options)->
      { message,icon,style } = options
      modalView = @getLoadingView message, icon, style
      
      @show modalView
    
    getLoadingView:(message,icon,style) ->
      new Modal.ModalView
        message : message
        icon : icon
        style : style

  App.commands.setHandler "show:modal", (message,icon,style) ->
    new Modal.ModalController
      region : App.modalRegion
      message: message
      icon : icon
      style: style

@Ebet.module "Components.Modal", (Modal, App, Backbone, Marionette, $, _) ->

  class Modal.ModalView extends App.Views.ItemView
    template : "modal_app/modal"
    className : "modal fade" 

    serializeData :->
      "message" : @options.message
      "icon"    : @options.icon
      "style"   : @options.style

    onRender: ->
      @$el.modal("show")
      setTimeout (=>
        @$el.modal("hide")
      ),2000
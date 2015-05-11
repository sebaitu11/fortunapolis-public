@Ebet.module "Components.Notify", (Notify, App, Backbone, Marionette, $, _) ->
   
  App.commands.setHandler "show:notify", (options,clases) ->
     
     $.notify.defaults
        autoHideDelay: 4000
        showAnimation: 'fadeIn'
        hideAnimation: 'fadeOut'
        globalPosition: 'bottom'
        className: clases

      $.notify(options)


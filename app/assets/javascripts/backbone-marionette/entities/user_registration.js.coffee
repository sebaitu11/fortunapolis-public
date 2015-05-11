@Ebet.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.UserRegistration extends App.Entities.Model
    urlRoot: -> Routes.user_registration_path()

    saveError: (model, xhr, options) =>
      ## set errors directly on the model unless status returned was 500 or 404
      @set _errors: $.parseJSON(xhr.responseText) unless /500/.test xhr.status

  API =
    registerUser: (user)->
      user.save null,
        success:(response)->
          response.unset("password")
          response.unset("password_confirmation")
        error:(response,xhr)->
          response.saveError(response,xhr)

      user

  App.reqres.setHandler "register:user",(user) ->
    API.registerUser(user)

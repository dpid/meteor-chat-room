# Configure the base template for the applicatio
Router.configure
  layoutTemplate: "layout"
  waitOn: -> Meteor.subscribe "allRooms"

# Define page routes.
# Require login on the home page when not on the home page.
# After login, go to page where a user can select a room to join.
Router.map ->

    @.route "home",
      path : "/"
      template : "home"
      redirectOnLogin : true

    @.route "loginRedirectRoute",
      action : ->
        Router.go("/rooms")

    @.route "room",
      path : "/room/:_id"
      template : "room"
      loginRequired : "home"
      # Subscribe user to the data from the room they are in
      waitOn : ->
        Meteor.subscribe "roomUsers", @.params._id
        Meteor.subscribe "roomMessages", @.params._id
      action : ->
          Meteor.call "joinRoom", @.params._id
          Session.set "roomId", @.params._id
          @.render()
      # Remove user from the list of users on unload
      unload : ->
        Meteor.call "leaveRoom", @.params._id
        Session.set "roomId", null

    @.route "rooms",
      path : "/rooms"
      template : "roomList"
      loginRequired : "home"
      action : ->
        Session.set "userName", Meteor.user().username
        @.render()

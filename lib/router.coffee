# Configure the base template for the applicatio
Router.configure
  layoutTemplate: "layout"
  waitOn: -> Meteor.subscribe "allRooms"

# Define page routes.
Router.map ->

    @.route "home",
      path : "/"
      template : "home"

    @.route "rooms",
      path : "/rooms"
      template : "roomList"
      loginRequired : "home"
      action : ->
        Session.set "roomId", null
        @.render()

    @.route "room",
      path : "/room/:_id"
      template : "room"
      loginRequired : "home"
      # Subscribe user to the data from the room they are in
      waitOn : ->
        Meteor.subscribe "roomUsers", @.params._id
        Meteor.subscribe "roomMessages", @.params._id
      action : ->
          Session.set "userName", Meteor.user().username
          Meteor.call "joinRoom", @.params._id
          Session.set "roomId", @.params._id
          @.render()
      # Remove user from the list of users on unload
      unload : ->
        Meteor.call "leaveRoom", @.params._id
        Session.set "roomId", null

Router.onBeforeAction ->
  if not Meteor.userId()
    @.render "home"
  else
    @.next()

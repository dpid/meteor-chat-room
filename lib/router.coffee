# Configure the base template for the application
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
      # Set the session roomId to null when navigating to a non room page.
      action : ->
        Session.set "roomId", null
        @.render()

    @.route "room",
      path : "/room/:_id"
      template : "room"
      loginRequired : "home"
      # Subscribe to the room user list and messages associated with this room id.
      # See, server/publications.coffee for publication setup.
      waitOn : ->
        Meteor.subscribe "roomUsers", @.params._id
        Meteor.subscribe "roomMessages", @.params._id
      # When navigating to a room we want to call joinRoom so the server can handle it.
      # Then, we set the session roomId. This will reactivley update user presence data.
      action : ->
          Session.set "userName", Meteor.user().username
          Meteor.call "joinRoom", @.params._id
          Session.set "roomId", @.params._id
          @.render()
      # Remove user from the list of users on unload
      unload : ->
        Meteor.call "leaveRoom", @.params._id
        Session.set "roomId", null

# When navigating to pages, check that we have a userId. If not, then render home page instead.
Router.onBeforeAction ->
  if not Meteor.userId()
    @.render "home"
  else
    @.next()

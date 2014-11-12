# Setup accounts
Accounts.ui.config passwordSignupFields: "USERNAME_ONLY"

# Track to see if a user has a userId (they're signed in) and they are on the home page.
# If so, then navigate to the room list page.
Tracker.autorun ->
  if Meteor.userId()
    if Router.current() and Router.current().route.getName() is "home"
      Router.go "rooms"

# Setup user presences optional data
UserPresence.data = ->
  roomId: Session.get 'roomId'
  username : Session.get 'userName'

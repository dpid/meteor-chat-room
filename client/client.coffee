# Setup accounts
Accounts.ui.config passwordSignupFields: "USERNAME_ONLY"

Tracker.autorun ->
  if Meteor.userId()
    if Router.current() and Router.current().route.getName() is "home"
      Router.go "rooms"

# Setup user presences optional data
UserPresence.data = ->
  roomId: Session.get 'roomId'
  username : Session.get 'userName'

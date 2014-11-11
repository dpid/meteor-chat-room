# Setup accounts
Accounts.ui.config passwordSignupFields: "USERNAME_ONLY"

# Setup user presences optional data
UserPresence.data = ->
  roomId: Session.get 'roomId'
  username : Session.get 'userName'

# If logged in then setup user presence data and skip to rooms page.
# Otherwise go to home page.
Tracker.autorun ->
  if Meteor.user()
    Session.set "userName", Meteor.user().username
    # If user is logged in and on the home page, then go to rooms
    if Router.current()
      routerName = Router.current().route.getName()
      if routerName is "home"
        Router.go "rooms"
  else
    Router.go "home"

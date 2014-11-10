Accounts.ui.config passwordSignupFields: "USERNAME_ONLY"
UserPresence.data = ->
  roomId: Session.get 'roomId'
  username : Meteor.user().username

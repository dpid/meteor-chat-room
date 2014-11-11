Template.layout.helpers
  hasRoomId : -> if Meteor.userId() and Session.get("roomId") then true else false

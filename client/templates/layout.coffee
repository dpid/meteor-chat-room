Template.layout.helpers
  hasRoomId : -> if Session.get "roomId" then true else false

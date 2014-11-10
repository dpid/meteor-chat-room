Template.room.helpers
  roomName : ->
    room = Rooms.findOne Session.get "roomId"
    room ?= name : "Current Room"
    room.name
  roomUsers : ->
    # RoomUsers.find {}, sort : username : "asc"
    UserPresences.find {}
  messages : ->
    Messages.find {}, sort : creation_date : 'desc'

Template.room.events =
  "click .send-message" : (event, template) ->
    event.preventDefault()
    $message = $("textarea.message")
    if $message.val() is "" then return
    Meteor.call "createMessage",
      roomId : Session.get "roomId"
      message : $message.val()

    $message.val ""

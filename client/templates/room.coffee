Template.room.helpers
  roomName : ->
    room = Rooms.findOne Session.get "roomId"
    room ?= name : "Current Room"
    room.name
  roomUsers : ->
    UserPresences.find {}, sort : "data.username" : "asc"
  messages : ->
    Messages.find {}, sort : creation_date : 'desc'

Template.room.events =
  "submit form.create-message" : (event, template) ->
    event.preventDefault()
    $message = $("input.message")
    if $message.val() is "" then return
    Meteor.call "createMessage",
      roomId : Session.get "roomId"
      message : $message.val()

    $message.val ""

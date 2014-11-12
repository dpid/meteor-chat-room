# Template helpers
Template.room.helpers
  # Find the room name from the Rooms collection by room id.
  roomName : ->
    room = Rooms.findOne Session.get "roomId"
    room ?= name : "Current Room"
    room.name
  # Retrieve the users sorted by username.
  # The UserPresences collection will only contain relevant room users since the server publishes by roomId.
  roomUsers : ->
    UserPresences.find {}, sort : "data.username":1
  # Find the messages in the room by room id.
  # Like UserPresences, the Messages collection subscribed to only contains messages associated with the current roomId.
  messages : ->
    Messages.find {}, sort : creation_date : 'desc'

# Template events
Template.room.events =
  # Create a message on form submit.
  # Note: It is recommended to use 'submit' instead of 'click' since it will handle all submit cases.
  "submit form.create-message" : (event, template) ->
    event.preventDefault()
    $message = $("input.message")
    if $message.val() is "" then return
    # Call the Meteor.method function on the server to handle putting it into the messages collection.
    Meteor.call "createMessage",
      roomId : Session.get "roomId"
      message : $message.val()
    # Clear the form
    $message.val ""

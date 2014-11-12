# Meteor methods are the more secure way to handle data manipulation on the server instead of from the client.
Meteor.methods
  # Create a room by adding it to the Rooms collection
  # The callback parameter is automatically handled by Meteor.
  # See client/templates/roomList.coffee for an example call.
  createRoom : (roomName, callback) ->
    if not roomName then return
    # Insert the new room into the Rooms collection
    Rooms.insert
      name : roomName
      user_count : 0
      creation_date : new Date()

  # Join a room.
  # When joining we want to update the user count.
  # See lib/router.coffee for an example call.
  joinRoom : (roomId) ->
    if not checkIsValidRoom roomId then return
    # Set the new room count.
    # We could use $inc, but setting it from the user presences count will keep it a little more accurate.
    roomUsers = UserPresences.find "data.roomId" : roomId
    Rooms.update roomId, $set: user_count: roomUsers.count()+1

  # Leave a room.
  # When leaving we want to update the user count.
  # If there are no users in the room, then remove it from the collection.
  # See lib/rounter.coffee for an example call
  leaveRoom : (roomId) ->
    if not checkIsValidRoom roomId then return
    # If no users left in the room, then remove.
    # Otherwise update count.
    roomUsers = UserPresences.find "data.roomId" : roomId
    roomUsersCount = roomUsers.count()-1
    if roomUsersCount <= 0
      removeRoom roomId
    else
      Rooms.update roomId, $set: user_count:roomUsersCount

  # Create a message and insert it into the Messages collection.
  # See client/templates/room.coffee for an example call.
  createMessage : (params={}) ->
    if not params.roomId or not params.message then return
    Messages.insert
      username : Meteor.user().username
      roomId : params.roomId
      content : params.message
      creation_date : new Date()


# Setup an onDisconnect handler on UserPresenceSettings (from dpid:user-presence package).
# Usually we update the user count in a room when the user leaves the room manually.
# However, we also need to handle updating the count when a user disconnects.
UserPresenceSettings
  onDisconnect : (userPresence={}) ->
    if not userPresence.data or not userPresence.data.roomId then return
    roomId = userPresence.data.roomId
    if not checkIsValidRoom roomId then return
    # If no users left in the room, then remove after a short delay if still empty.
    # The delay is handle the edge case where the user is the only one in the room and they refresh
    # the page or get disconnected for a moment.
    roomUsers = UserPresences.find "data.roomId" : roomId
    roomUsersCount = roomUsers.count()-1
    if roomUsersCount <= 0
      Meteor.setTimeout ->
        roomUsers = UserPresences.find "data.roomId" : roomId
        roomUsersCount = roomUsers.count()
        if roomUsersCount <= 0 then removeRoom roomId
      , 1000
    else # Else, update the user count.
      Rooms.update roomId, $set: user_count:roomUsersCount


# A helper function to check if the roomId is associated with a valid room
checkIsValidRoom = (roomId) ->
  if not roomId then false
  room = Rooms.findOne _id:roomId
  if not room then false
  return true

# A helper function for removing a room.
# Removes the room from the Rooms collection and messages associated with the roomId.
removeRoom = (roomId) ->
  Rooms.remove roomId
  Messages.remove roomId:roomId

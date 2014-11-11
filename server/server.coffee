removeRoom = (roomId) ->
  Rooms.remove roomId
  Messages.remove roomId:roomId

Meteor.methods
  createRoom : (roomName, callback) ->
    if not roomName then return

    Rooms.insert
      name : roomName
      user_count : 0
      creation_date : new Date()

  joinRoom : (roomId) ->
    if not roomId then return
    room = Rooms.findOne _id:roomId
    if not room then return

    roomUsers = UserPresences.find "data.roomId" : roomId
    Rooms.update roomId, $set: user_count: roomUsers.count()+1

  leaveRoom : (roomId) ->
    if not roomId then return
    room = Rooms.findOne _id:roomId
    if not room then return

    # If no users left in the room, then remove.
    # Otherwise update count.
    roomUsers = UserPresences.find "data.roomId" : roomId
    roomUsersCount = roomUsers.count()-1
    if roomUsersCount <= 0
      removeRoom roomId
    else
      Rooms.update roomId, $set: user_count:roomUsersCount

  createMessage : (params={}) ->
    if not params.roomId or not params.message then return
    Messages.insert
      username : Meteor.user().username
      roomId : params.roomId
      content : params.message
      creation_date : new Date()

UserPresenceSettings
  tickDelay : 400
  onDisconnect : (userPresence={}) ->
    if not userPresence.data or not userPresence.data.roomId then return
    roomId = userPresence.data.roomId
    room = Rooms.findOne _id:roomId
    if not room then return
    # If no users left in the room, then remove after a short delay if still empty.
    # Otherwise update count.
    roomUsers = UserPresences.find "data.roomId" : roomId
    roomUsersCount = roomUsers.count()-1
    if roomUsersCount <= 0
      Meteor.setTimeout ->
        roomUsers = UserPresences.find "data.roomId" : roomId
        roomUsersCount = roomUsers.count()
        if roomUsersCount <= 0 then removeRoom roomId
      , 1000
    else
      Rooms.update roomId, $set: user_count:roomUsersCount

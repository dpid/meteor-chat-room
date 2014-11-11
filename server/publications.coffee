Meteor.publish "allRooms", -> Rooms.find()
Meteor.publish "roomMessages", (roomId) -> Messages.find roomId:roomId
Meteor.publish "roomUsers", (roomId) ->
  filter =
    "data.roomId" : roomId
  fields =
    state: true
  UserPresences.find filter, fields

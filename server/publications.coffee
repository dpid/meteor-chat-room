# Publish all rooms so that they can be displayed in the room list.
Meteor.publish "allRooms", -> Rooms.find()
# Publish the room messages filtered by a roomId.
Meteor.publish "roomMessages", (roomId) -> Messages.find roomId:roomId
# Publish the users that are in a given room by roomId.
Meteor.publish "roomUsers", (roomId) -> UserPresences.find "data.roomId" : roomId

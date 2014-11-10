Template.roomList.helpers
  rooms : -> Rooms.find {}, sort : creation_date : 'desc'

Template.roomList.events
  'click .create-room' : (event, template) ->
    event.preventDefault()

    roomName = $('.room-name').val()
    if not roomName then return

    Meteor.call "createRoom", roomName, (error, result) ->
      if error then return

      Router.go "room",
        name: roomName
        _id : result

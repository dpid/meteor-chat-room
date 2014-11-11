Template.roomList.helpers
  rooms : -> Rooms.find {}, sort : creation_date : 'desc'

Template.roomList.events
  'submit form.create-room' : (event, template) ->
    event.preventDefault()

    roomName = $('input.room-name').val()
    if not roomName then return

    Meteor.call "createRoom", roomName, (error, result) ->
      if error then return

      Router.go "room",
        name: roomName
        _id : result

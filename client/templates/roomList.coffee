# Template helpers
Template.roomList.helpers
  # Find rooms and sort by create date.
  rooms : -> Rooms.find {}, sort : creation_date : 'desc'

# Template events
Template.roomList.events
  # Create a room on form submit.
  # Note: It is recommended to use 'submit' instead of 'click' since it will handle all submit cases.
  'submit form.create-room' : (event, template) ->
    event.preventDefault()

    roomName = $('input.room-name').val()
    if not roomName then return

    # Call the Meteor.method function on the server to handle putting it into the rooms collection.
    # Also, setup a callback that will navigate to the room when the server is done.
    Meteor.call "createRoom", roomName, (error, result) ->
      if error then return

      Router.go "room",
        name: roomName
        _id : result

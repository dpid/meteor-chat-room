Meteor Chat Room
================

Meteor Chat Room is an open source app powered by [Meteor](https://www.meteor.com/) and made by
[Damon Pidhajecky](http://www.damonpidhajecky.com). In this demo we explore the following techniques:

  * __User login__
    * Track reactive user data to navigate to the room list page after login.
    * Track reactive user data to navigate back to the home page after logout.

  * __User Presence__
    * Use the [dpid:user-presence](https://github.com/dpid/meteor-user-presence/) package to detect
      when a user is online, idle, or disconected.
    * Track the room a user is in with reactive data.

  * __Room List Page__
    * Use template helpers to display a reactive list of rooms.
    * Use template events to create a room.
    -
  * __Rooms__
    * Use the [iron:router](https://github.com/eventedmind/iron-router/) package to subscribe to
      parameterized collection publications specific to the room the user is in.
    * Use template helpers to dynamically display a list of users in the room and their states.
    * Use template helpers to display a reactive list of messages.
    * Use template events to submit a new message.

##CoffeScript

This demo uses [CoffeeScript](http://coffeescript.org/) as a cleaner way to write JavaScript.
More information on the Meteor package can be found at https://atmospherejs.com/meteor/coffeescript

##Jade

This demo uses the [Jade](http://jade-lang.com/) template engine as a cleaner way to write html. More information on the Meteor package can
be found at https://atmospherejs.com/mquandalle/jade

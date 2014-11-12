# Lib
Files in this directory are loaded first.

## router.coffee
In this file, we use [iron:router](https://github.com/eventedmind/iron-router/) to manage templates
and page navigation.

When navigating to a room, we use the `waitOn` function to subscribe to parameterized publications associated with that room.

Also, we set the reactive session data associated with [user presence](https://github.com/dpid/meteor-user-presence/) when joining and leaving a room.

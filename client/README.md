# Client
Files in this directory are handled by the client.

## templates
This directory contains the [jade](http://jade-lang.com/) and [coffee](http://coffeescript.org/) files for each template used in the app.

## client.coffee
In this file, we handle a few things:
* Setup `Accounts.ui.config`. See, http://docs.meteor.com/#/full/accounts_ui_config
* Use `Tracker.autorun` to detect that when the user is logged they go to the room list page. See, http://docs.meteor.com/#/basic/Tracker-autorun
* Setup `UserPresence.data` to reactively keep track of the user's current room. See, https://github.com/dpid/meteor-user-presence/#optional-data-function

## head.jade
Simply defines the app head html.

## styles.styl
Style definitions for the app.

Note: This app uses [Bootstrap](http://getbootstrap.com/) which conveniently defines most css for us. For package info, see https://atmospherejs.com/mizzao/bootstrap-3

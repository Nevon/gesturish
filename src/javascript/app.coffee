Hammer = require 'hammerjs'
TouchEvents = require './touch-events'
Gesturish = require './gesturish'

class App
	constructor: (@toucharea, @output) ->
		@gesturish = new Gesturish()

		@createListeners()

		@initTouchHandling(
			new Hammer(@toucharea),
			{ direction: Hammer.DIRECTION_ALL, velocity: .1 }
			TouchEvents, 
			@_onTouchAction
		)

		@initKeyboardHandling()

	createListeners: () ->
		@gesturish.on 'character', @_handleCharacter

		@gesturish.on 'delete', @_handleDeleteCommand
			

	initTouchHandling: (hammerInstance, config, events, callback) ->
		@mc = hammerInstance
		@mc.get('swipe').set config

		@mc.on (events[e] for e in Object.keys(events)).join(' '), (e) =>
			callback.call @, e

	_onTouchAction: (e) ->
		console.log "#{e.type} gesture detected"
		@gesturish.gesture e.type

	initKeyboardHandling: ->
		# Fake touch events
		document.addEventListener 'keydown', (e) =>
			if e.keyCode is 13
				@_onTouchAction {type: TouchEvents.tap}
			else if e.keyCode is 38
				@_onTouchAction {type: TouchEvents.up}
			else if e.keyCode is 40
				@_onTouchAction {type: TouchEvents.down}
			else if e.keyCode is 37
				@_onTouchAction {type: TouchEvents.left}
			else if e.keyCode is 39
				@_onTouchAction {type: TouchEvents.right}

	_handleCharacter: (character) =>
		@output.innerHTML += character

	_handleDeleteCommand: =>
		# Each delete command will be preceded by a space command, so we need to remove two characters
		@output.innerHTML = @output.innerHTML.slice 0, -2


module.exports = App
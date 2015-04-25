StateMachine = require 'javascript-state-machine'
Hammer = require 'hammerjs'
TouchEvents = require './touch-events'
translateCharToken = require './character-lookup'

class App
	constructor: (@toucharea, @output) ->
		@fsm = @createStateMachine()

		@initTouchHandling @onTouchAction

		@initKeyboardHandling()

	createStateMachine: ->
		output = @output

		# TODO: Generate the events from a simpler structure
		fsm = StateMachine.create
			initial: 'idle',
			events: [
				{ name: TouchEvents.down,  from: ['idle', 'SPACE', 'DELETE'],  to: 'a' },
				{ name: TouchEvents.tap,  from: 'm',  to: 'b' },
				{ name: TouchEvents.right,  from: 'PERIOD',  to: 'c' },
				{ name: TouchEvents.up,  from: 'ZERO',  to: 'd' },
				{ name: TouchEvents.right,  from: ['idle', 'SPACE', 'DELETE'],  to: 'e' },
				{ name: TouchEvents.right,  from: 'e',  to: 'f' },
				{ name: TouchEvents.down,  from: 'ZERO',  to: 'g' },
				{ name: TouchEvents.down,  from: 'a',  to: 'h' },
				{ name: TouchEvents.up,  from: ['idle', 'SPACE', 'DELETE'],  to: 'i' },
				{ name: TouchEvents.down,  from: 'g',  to: 'j' },
				{ name: TouchEvents.right,  from: 'f',  to: 'k' },
				{ name: TouchEvents.right,  from: 'i',  to: 'l' },
				{ name: TouchEvents.up,  from: 'i',  to: 'm' },
				{ name: TouchEvents.down,  from: 'i',  to: 'n' },
				{ name: TouchEvents.right,  from: 'ZERO',  to: 'o' },
				{ name: TouchEvents.tap,  from: 'a',  to: 'p' },
				{ name: TouchEvents.right,  from: 'g',  to: 'q' },
				{ name: TouchEvents.tap,  from: 'i',  to: 'r' },
				{ name: TouchEvents.right,  from: 'a',  to: 's' },
				{ name: TouchEvents.down,  from: 'e',  to: 't' },
				{ name: TouchEvents.up,  from: 'a',  to: 'u' },
				{ name: TouchEvents.down,  from: 's',  to: 'v' },
				{ name: TouchEvents.down,  from: 'h',  to: 'w' },
				{ name: TouchEvents.right,  from: 'u',  to: 'x' },
				{ name: TouchEvents.right,  from: 'l',  to: 'y' },
				{ name: TouchEvents.right,  from: 't',  to: 'z' },
				{ name: TouchEvents.tap,  from: 'e',  to: 'PERIOD' },
				{ name: TouchEvents.tap,  from: 'PERIOD',  to: 'COMMA' },
				{ name: TouchEvents.tap,  from: 'COMMA',  to: 'QUESTION_MARK' },
				{ name: TouchEvents.tap,  from: 'QUESTION_MARK',  to: 'EXCLAMATION_MARK' },
				{ name: TouchEvents.tap,  from: 'EXCLAMATION_MARK',  to: 'APOSTROPHE' },
				{ name: TouchEvents.tap,  from: 'APOSTROPHE',  to: 'AT_SIGN' },
				{ name: TouchEvents.tap,  from: 'AT_SIGN',  to: 'HASH' },
				{ name: TouchEvents.tap,  from: 'HASH',  to: 'DOLLAR' },
				{ name: TouchEvents.tap,  from: ['idle', 'SPACE', 'DELETE'],  to: 'ZERO' },
				{ name: TouchEvents.tap,  from: 'ZERO',  to: 'ONE' },
				{ name: TouchEvents.tap,  from: 'ONE',  to: 'TWO' },
				{ name: TouchEvents.tap,  from: 'TWO',  to: 'THREE' },
				{ name: TouchEvents.tap,  from: 'THREE',  to: 'FOUR' },
				{ name: TouchEvents.tap,  from: 'FOUR',  to: 'FIVE' },
				{ name: TouchEvents.tap,  from: 'FIVE',  to: 'SIX' },
				{ name: TouchEvents.tap,  from: 'SIX',  to: 'SEVEN' },
				{ name: TouchEvents.tap,  from: 'SEVEN',  to: 'EIGHT' },
				{ name: TouchEvents.tap,  from: 'EIGHT',  to: 'NINE' }
				{ name: TouchEvents.left, from: '*', to: 'idle' },
				{ name: TouchEvents.left, from: 'idle', to: 'SPACE' },
				{ name: TouchEvents.left, from: 'SPACE', to: 'DELETE' },
				{ name: TouchEvents.left, from: 'DELETE', to: 'DELETE' } # Currently, transitions from one state to itself doesn't trigger
			]

		fsm.onenterstate = (e, from, to) ->
			console.log "Transition: #{from} -> #{to}"

		fsm.onenterSPACE = ->
			output.innerHTML += ' '

		fsm.onenterDELETE = ->
			# Each delete command will be preceded by a space command, so we need to remove two characters
			output.innerHTML = output.innerHTML.slice(0, -2)

		fsm.onenteridle = (e, from, to) ->
			console.log "Committing symbol #{from}"

			unless from in ['SPACE', 'DELETE']
				console.log "Writing #{from} to output"
				output.innerHTML += translateCharToken(from)

		fsm

	initTouchHandling: (callback) ->
		@mc = new Hammer @toucharea
		@mc.get('swipe').set direction: Hammer.DIRECTION_ALL

		@mc.on (TouchEvents[e] for e in Object.keys(TouchEvents)).join(' '), (e) =>
			callback.call @, e

	onTouchAction: (e) ->
		console.log "#{e.type} gesture detected"
		@fsm[e.type]()

	initKeyboardHandling: ->
		# Fake touch events
		document.addEventListener 'keydown', (e) =>
			console.log e
			if e.keyCode is 13
				@onTouchAction {type: TouchEvents.tap}
			else if e.keyCode is 38
				@onTouchAction {type: TouchEvents.up}
			else if e.keyCode is 40
				@onTouchAction {type: TouchEvents.down}
			else if e.keyCode is 37
				@onTouchAction {type: TouchEvents.left}
			else if e.keyCode is 39
				@onTouchAction {type: TouchEvents.right}


module.exports = App
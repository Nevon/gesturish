Gesturish = require '../gesturish'
EventEmitter2 = require('eventemitter2').EventEmitter2

describe 'Gesturish', ->
	gesturish = undefined
	sandbox = sinon.sandbox.create()

	beforeEach ->
		gesturish = new Gesturish()

	afterEach ->
		sandbox.restore()

	it 'extends EventEmitter2', ->
		expect(gesturish instanceof EventEmitter2).to.equal true

	it 'runs an event when a gesture is called', ->
		# given
		spy = sandbox.spy gesturish, '_stateEvent'

		# when
		gesturish.gesture 'swipeup'

		# then
		expect(spy.calledWithExactly('swipeup')).to.equal true

	it 'rejects invalid gestures', ->
		# given
		spy = sandbox.spy gesturish, '_stateEvent'

		# when
		gesturish.gesture 'foo'

		# then
		expect(spy.calledWithExactly('_stateEvent')).to.equal false

	it 'triggers state machine event on valid gestures', ->
		# given
		spy = sandbox.spy gesturish.fsm, 'swipeup'

		# when
		gesturish._stateEvent 'swipeup'

		# then
		expect(spy.calledWithExactly()).to.equal true

	describe 'Character state', ->

		it 'exposes the current character', ->
			# given
			gesturish.fsm.current = 'a'

			# then
			expect(gesturish.current()).to.equal 'a'

		it 'translates the character token before returning it', ->
			# given
			CharacterLookup = require '../character-lookup'
			gesturish.fsm.current = 'SPACE'
			stub = sandbox.stub CharacterLookup, 'translate'
			stub.withArgs('SPACE').returns ' '

			# when
			gesturish.current()

			# then
			expect(stub.calledWithExactly('SPACE')).to.equal true

		it 'does not return DELETE command', ->
			# given
			gesturish.fsm.current = 'DELETE'

			# then
			expect(gesturish.current()).to.equal undefined

		it 'does not return idle state', ->
			# given
			gesturish.fsm.current = 'idle'

			# then
			expect(gesturish.current()).to.equal undefined
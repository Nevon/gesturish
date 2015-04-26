App = require '../app'

describe 'App', ->

	app = undefined

	outputDiv = document.createElement 'div'
	outputDiv.id = 'output'
	document.body.appendChild outputDiv

	toucharea = document.createElement 'div'
	toucharea.id = 'toucharea'
	document.body.appendChild toucharea
	
	sandbox = sinon.sandbox.create()

	beforeEach ->
		app = new App toucharea, outputDiv

	afterEach ->
		sandbox.restore()
		outputDiv.innerHTML = ''

	it 'should set up event listeners', ->
		# given
		spy = sandbox.spy App::, 'createListeners'

		# when
		app = new App toucharea, outputDiv

		# then
		expect(spy.called).to.equal true

	it 'should set up touch handling', ->
		# given
		spy = sandbox.spy App::, 'initTouchHandling'

		# when
		app = new App toucharea, outputDiv

		# then
		expect(spy.called).to.equal true

	it 'should set up keyboard handling', ->
		# given
		spy = sandbox.spy App::, 'initKeyboardHandling'

		# when
		app = new App toucharea, outputDiv

		# then
		expect(spy.called).to.equal true

	describe 'createListeners', ->

		it 'should listen on `character`', ->
			# given
			spy = sandbox.spy app.gesturish, 'on'
			spy.withArgs 'character', app._handleCharacter

			# when
			app.createListeners()

			# then
			expect(spy.called).to.equal true

		it 'should listen on `delete`', ->
			# given
			spy = sandbox.spy app.gesturish, 'on'
			spy.withArgs 'delete', app._handleDeleteCommand

			# when
			app.createListeners()

			# then
			expect(spy.called).to.equal true

		it 'should handle character events', ->
			# given
			app.output.innerHTML = ''

			# when
			app._handleCharacter 'a'

			# then
			expect(app.output.innerHTML).to.equal 'a'

		it 'should handle delete commands', ->
			# given
			app.output.innerHTML = 'foobarz '

			# when
			app._handleDeleteCommand()

			# then
			expect(app.output.innerHTML).to.equal 'foobar'

	describe 'initTouchHandling', ->

		it 'should enable vertical swiping', ->
			# given
			spy = sinon.spy()
			fixture = 
				get: ->
					set: spy
				on: (->)
			config =
				direction: 30
				velocity: .1

			# when
			app.initTouchHandling fixture, config, {}, (->)

			# then
			expect(spy.calledWithExactly(config)).to.equal true

		it 'should listen for all specified events', ->
			# given
			spy = sinon.spy()
			
			fixture = 
				get: ->
					set: (->)
				on: spy

			config =
				direction: 30
				velocity: .1
			
			events =
				foo: 'foo',
				bar: 'bar'

			# when
			app.initTouchHandling fixture, config, events, (->)

			# then
			expect(spy.calledWith('foo bar')).to.equal true

		it 'should notify gesturish on new touch event', ->
			# given
			spy = sandbox.spy app.gesturish, 'gesture'
			action = type: 'tap'

			# when
			app._onTouchAction action

			# then
			expect(spy.calledWithExactly(action.type)).to.equal true
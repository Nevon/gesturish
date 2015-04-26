CharacterLookup = require '../character-lookup'

describe 'CharacterLookup', ->

	describe 'translate', ->

		it 'translates character tokens', ->
			expect(CharacterLookup.translate 'EXCLAMATION_MARK').to.equal '!'

		it 'returns the original token if it is unable to find a translation', ->
			expect(CharacterLookup.translate 'DELETE').to.equal 'DELETE'
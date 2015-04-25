charTable =
	SPACE: ' '
	PERIOD: '.'
	COMMA: ','
	QUESTION_MARK: '?'
	EXCLAMATION_MARK: '!'
	APOSTROPHE: '\''
	AT_SIGN: '@'
	HASH: '#'
	DOLLAR: '$'
	ZERO: '0'
	ONE: '1'
	TWO: '2'
	THREE: '3'
	FOUR: '4'
	FIVE: '5'
	SIX: '6'
	SEVEN: '7'
	EIGHT: '8'
	NINE: '9'

module.exports = (charToken) ->
	if charTable[charToken] then charTable[charToken] else charToken 
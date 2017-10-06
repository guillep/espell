*Espell-Extensions
asLiteralInObjectSpace: anObjectSpace

	| espellGlobal |
	self haltIf: [ key ~= #Array ].
	"The compiler has a special case for literal arrays.
	In such a case, it hardcodes the creation of a local array.
	See OCASTTranslator>>#visitLargeArrayNode:"
	
	espellGlobal := EPGlobalBinding new
			name: key objectSpace: anObjectSpace ;
			yourself.
	^ espellGlobal asLiteralInObjectSpace: anObjectSpace.
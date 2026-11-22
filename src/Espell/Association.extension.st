Extension { #name : 'Association' }

{ #category : '*Espell-Extensions' }
Association >> asLiteralInObjectSpace: anObjectSpace [

	| espellGlobal |
	self haltIf: [ key ~= #Array ].
	"The compiler has a special case for literal arrays.
	In such a case, it hardcodes the creation of a local array.
	See OCASTTranslator>>#visitLargeArrayNode:"
	
	espellGlobal := EPGlobalBinding new
			name: key objectSpace: anObjectSpace ;
			yourself.
	^ espellGlobal asLiteralInObjectSpace: anObjectSpace.
]

{ #category : '*Espell' }
Association >> isGlobalClassNameBinding [
	^ (self value isClass or: [ self value isTrait ])
		and: [ self variable key == self value name ]
]

{ #category : '*Espell' }
Association >> isGlobalVariable [
	^ true
]

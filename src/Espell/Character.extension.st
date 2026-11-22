Extension { #name : 'Character' }

{ #category : '*Espell-Extensions' }
Character >> asLiteralInObjectSpace: anObjectSpace [

	^anObjectSpace fromLocalCharacter: self
]

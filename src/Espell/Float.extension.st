Extension { #name : 'Float' }

{ #category : '*Espell-Extensions' }
Float >> asLiteralInObjectSpace: anObjectSpace [

	^anObjectSpace fromLocalFloat: self
]

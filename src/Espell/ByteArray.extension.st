Extension { #name : 'ByteArray' }

{ #category : '*Espell-Extensions' }
ByteArray >> asLiteralInObjectSpace: anObjectSpace [
	
	^anObjectSpace fromLocalByteArray: self
]

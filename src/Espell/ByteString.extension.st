Extension { #name : 'ByteString' }

{ #category : '*Espell-Extensions' }
ByteString >> asLiteralInObjectSpace: anObjectSpace [

	^anObjectSpace fromLocalByteString: self
]

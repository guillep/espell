Extension { #name : 'ByteSymbol' }

{ #category : '*Espell-Extensions' }
ByteSymbol >> asLiteralInObjectSpace: anObjectSpace [

	^anObjectSpace fromLocalByteSymbol: self
]

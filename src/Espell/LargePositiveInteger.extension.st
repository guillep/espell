Extension { #name : 'LargePositiveInteger' }

{ #category : '*Espell-Extensions' }
LargePositiveInteger >> asLiteralInObjectSpace: anObjectSpace [
	
	^ anObjectSpace fromLocalPositiveInteger: self
]

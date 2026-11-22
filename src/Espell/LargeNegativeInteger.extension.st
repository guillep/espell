Extension { #name : 'LargeNegativeInteger' }

{ #category : '*Espell-Extensions' }
LargeNegativeInteger >> asLiteralInObjectSpace: anObjectSpace [
	
	^ anObjectSpace fromLocalNegativeInteger: self
]

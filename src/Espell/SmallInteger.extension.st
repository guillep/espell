Extension { #name : 'SmallInteger' }

{ #category : '*Espell-Extensions' }
SmallInteger >> asLiteralInObjectSpace: anObjectSpace [

	^ anObjectSpace fromLocalInteger: self
]

{ #category : '*Espell-Extensions' }
SmallInteger >> asSmallInteger [
	
	^ self
]

Extension { #name : 'Array' }

{ #category : '*Espell-Extensions' }
Array class >> asLiteralInObjectSpace: anEPObjectSpace [ 
	^ anEPObjectSpace classNamed: #Array
]

{ #category : '*Espell-Extensions' }
Array >> asLiteralInObjectSpace: anObjectSpace [
	"Method only for literal arrays!"
	^ anObjectSpace 
		newArrayWithAll: (self collect: [ :each | each asLiteralInObjectSpace: anObjectSpace ]).
]

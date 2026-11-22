Extension { #name : 'GlobalVariable' }

{ #category : '*Espell' }
GlobalVariable >> asLiteralInObjectSpace: anObjectSpace [

	| espellGlobal |
	espellGlobal := EPGlobalBinding new
		                name: name objectSpace: anObjectSpace;
		                yourself.
	^ espellGlobal asLiteralInObjectSpace: anObjectSpace
]

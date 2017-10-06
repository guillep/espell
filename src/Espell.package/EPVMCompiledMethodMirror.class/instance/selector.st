accessing
selector
	| penultimateLiteral remoteSelector isSymbol |
	penultimateLiteral := self penultimateLiteral.
	penultimateLiteral isNilObject ifTrue: [ ^nil ].
	
	isSymbol := penultimateLiteral basicClass = backend byteSymbolClass.
	remoteSelector := isSymbol ifTrue: [ penultimateLiteral ]
										ifFalse: [ "It is a method properties object whose second inst var has the selector"
														penultimateLiteral instanceVariableAtIndex: 2 ].
	^ self backend fromRemoteByteSymbol: remoteSelector
as yet unclassified
address
	
	^ self isSmallInteger
		ifTrue: [ backend objectMemory integerObjectOf: object ]
		ifFalse: [
			"somebody is asking the address of a non immediate object!" 
			self halt ].
"	^ backend nilObject target address"
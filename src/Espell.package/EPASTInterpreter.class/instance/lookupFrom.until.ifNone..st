lookup
lookupFrom: aRFiClass until: aBlockClosure ifNone: aBlockClosure3 
	
	| lookupClass |
	lookupClass := aRFiClass.
	[lookupClass isNil] whileFalse: [ 
		(aBlockClosure value: lookupClass) ifTrue: [ ^ lookupClass ].
		lookupClass := lookupClass superclass ].
	aBlockClosure3 value.
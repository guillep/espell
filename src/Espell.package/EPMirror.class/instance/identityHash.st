comparing
identityHash

	^ self isSmallInteger
		ifTrue: [ self target asSmallInteger hashMultiply ]
		ifFalse: [ self basicIdentityHash bitShift: 18 ]
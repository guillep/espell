private
privateRemoveFromList: theList

	(self pointsToSameObject: (theList instanceVariableAtIndex: 1))
		ifTrue: [theList instanceVariableAtIndex: 1 put: (self instanceVariableAtIndex: 1).
				(self pointsToSameObject: (theList instanceVariableAtIndex: 2))
					ifTrue: [theList instanceVariableAtIndex: 1 put: self objectSpace nilObject]]
		ifFalse: [| tempLink |
				tempLink := theList instanceVariableAtIndex: 1.
				[tempLink isNilObject ifTrue: [^ self ].
				 (tempLink instanceVariableAtIndex: 1) pointsToSameObject: self]
					whileFalse: [tempLink := tempLink instanceVariableAtIndex: 1].
				tempLink nextLink: (self instanceVariableAtIndex: 1).
				(self pointsToSameObject: (theList instanceVariableAtIndex: 2))
					ifTrue: [theList instanceVariableAtIndex: 2 put: tempLink]].
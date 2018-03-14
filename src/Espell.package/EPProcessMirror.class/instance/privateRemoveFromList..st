private
privateRemoveFromList: theList
	(self
		pointsToSameObject: (theList instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex))
		ifTrue: [ theList
				instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex
				put: (self instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex).
			(self
				pointsToSameObject: (theList instanceVariableAtIndex: self backend instanceVariableMapping processContextIndex))
				ifTrue: [ theList
						instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex
						put: self objectSpace nilObject
					]
			]
		ifFalse: [ | tempLink |
			tempLink := theList instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex.
			[ tempLink isNilObject
				ifTrue: [ ^ self ].
			(tempLink instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex)
				pointsToSameObject: self
			]
				whileFalse: [ tempLink := tempLink instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex ].
			tempLink nextLink: (self instanceVariableAtIndex: self backend instanceVariableMapping processNextLinkIndex).
			(self
				pointsToSameObject: (theList instanceVariableAtIndex: self backend instanceVariableMapping processContextIndex))
				ifTrue: [ theList instanceVariableAtIndex: self backend instanceVariableMapping processContextIndex put: tempLink ]
			]
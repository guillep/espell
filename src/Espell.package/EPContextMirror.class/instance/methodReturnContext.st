accessing
methodReturnContext
	(self closure pointsToSameObject: backend nilObject)
		ifTrue: [ ^ self ].
	^ self closure outerContext methodReturnContext
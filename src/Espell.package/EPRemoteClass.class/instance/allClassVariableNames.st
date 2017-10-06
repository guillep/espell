class variables
allClassVariableNames
	
	self superclass ifNil: [ ^ self classVariableNames ].
	^ self superclass allClassVariableNames, self classVariableNames
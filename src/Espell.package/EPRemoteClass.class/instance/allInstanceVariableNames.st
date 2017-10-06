instance variables
allInstanceVariableNames
	
	self superclass ifNil: [ ^ self instanceVariableNames ].
	^ self superclass allInstanceVariableNames, self instanceVariableNames
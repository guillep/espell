instance variables
allInstanceVariableNames
	
	self superclass isNilObject ifTrue: [ ^ self instanceVariableNames ].
	^ self superclass allInstanceVariableNames, self instanceVariableNames
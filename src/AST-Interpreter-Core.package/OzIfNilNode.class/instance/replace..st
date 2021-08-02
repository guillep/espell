as yet unclassified
replace: aMessageNode

	checkForNil := aMessageNode selector beginsWith: 'ifNil'.
	receiver := aMessageNode receiver.
	trueCondition := aMessageNode arguments at: 1.
	falseCondition := aMessageNode arguments size > 1
		ifTrue: [ (aMessageNode arguments at: 2) body ]
		ifFalse: [ RBLiteralNode value: nil ].
	
	trueCondition isBlock	ifFalse: [ ^ nil ].
	
	self replace: aMessageNode with: self.
	^ self
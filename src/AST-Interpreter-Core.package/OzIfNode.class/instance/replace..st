as yet unclassified
replace: aMessageNode

	receiver := aMessageNode receiver.
	trueCondition := aMessageNode arguments at: 1.
	falseCondition := aMessageNode arguments at: 2.
	self replace: aMessageNode with: self.
	^ self
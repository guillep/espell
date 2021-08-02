as yet unclassified
replace: aMessageNode

	receiver := aMessageNode receiver.
	falseCondition := aMessageNode arguments at: 1.
	self replace: aMessageNode with: self.
	^ self
as yet unclassified
replace: aMessageNode

	fromNode := aMessageNode receiver.
	toNode := aMessageNode arguments at: 1.
	blockNode := aMessageNode arguments at: 2.
	self replace: aMessageNode with: self.
	^ self
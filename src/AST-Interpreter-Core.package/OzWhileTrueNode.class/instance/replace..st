as yet unclassified
replace: aMessageNode

	isWhileFalse := aMessageNode selector beginsWith: 'whileFalse'.
	receiver := aMessageNode receiver.
	condition := aMessageNode arguments isEmpty
		ifTrue: [ RBLiteralNode value: nil ]
		ifFalse: [ (aMessageNode arguments at: 1) body ].
	self replace: aMessageNode with: self.
	^ self
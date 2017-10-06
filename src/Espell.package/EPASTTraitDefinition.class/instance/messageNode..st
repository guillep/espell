accessing
messageNode: aMessageNode

	message := aMessageNode.
	parent := aMessageNode parent.
	parent replaceNode: message withNode: self.
	self parent: parent.
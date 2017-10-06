accessing
visitMessageNode: aMessageNode

	aMessageNode receiver acceptVisitor: self.
	aMessageNode arguments do: [ :arg | arg acceptVisitor: self ]
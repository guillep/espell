accessing
withArgumentsAs: aTransformationBlock

	| newExecution |
	newExecution := self copy.
	newExecution arguments: (self arguments collect: aTransformationBlock).
	^ newExecution
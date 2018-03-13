accessing
closure: aClosureMirror
	self instanceVariableAtIndex: (self backend instanceVariableMapping contextClosureOrNilIndex) put: aClosureMirror
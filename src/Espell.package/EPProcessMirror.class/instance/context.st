accessing
context
	^ (self instanceVariableAtIndex: (self backend instanceVariableMapping processContextIndex)) asContextMirror
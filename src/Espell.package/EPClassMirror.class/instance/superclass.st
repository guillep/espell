accessing
superclass
	^ (self instanceVariableAtIndex: (self backend instanceVariableMapping classSuperclassIndex)) asClassMirror
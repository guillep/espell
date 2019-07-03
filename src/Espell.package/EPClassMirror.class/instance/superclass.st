accessing
superclass

	self backend interpreter codeProvider systemDefinition classNamed: self classNameFromAnyOrigin.
	^ (self instanceVariableAtIndex: (self backend instanceVariableMapping classSuperclassIndex)) asClassMirror
special objects
symbolTableClass
	
	^ symbolTableClass ifNil: [
		(self arrayClass instanceVariableAtIndex: self classNameIndex)
			basicClass
			superclass]
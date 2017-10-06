accessing
priority: aPriorityInteger

	self 
		instanceVariableAtIndex: 3
		put: (aPriorityInteger asLiteralInObjectSpace: self backend)
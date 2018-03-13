accessing
priority: aPriorityInteger

	self 
		instanceVariableAtIndex: (self backend instanceVariableMapping processPriorityIndex)
		put: (aPriorityInteger asLiteralInObjectSpace: self backend)
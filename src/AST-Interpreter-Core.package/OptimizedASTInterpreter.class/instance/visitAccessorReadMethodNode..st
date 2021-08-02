visiting-special-nodes
visitAccessorReadMethodNode: aMethodNode
	
	^ self readInstVarAt: aMethodNode index named: nil
visiting
visitBlockNode: aBlockNode
	^ evaluator objectSpace backend mirrorOnExternalHandle: (super visitBlockNode: aBlockNode)
visiting
visitArrayNode: anArrayNode
	
	^ evaluator objectSpace newArrayWithAll: (super acceptArrayNode: anArrayNode)
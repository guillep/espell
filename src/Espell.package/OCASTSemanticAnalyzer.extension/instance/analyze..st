*Espell
analyze: aNode
	self visitNode: aNode.
	OCASTClosureAnalyzer new visitNode: aNode.
	"OCASTMethodMetadataAnalyser new visitNode: aNode"
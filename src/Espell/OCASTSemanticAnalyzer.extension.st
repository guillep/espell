Extension { #name : 'OCASTSemanticAnalyzer' }

{ #category : '*Espell' }
OCASTSemanticAnalyzer >> analyze: aNode [
	self visitNode: aNode.
	OCASTClosureAnalyzer new visitNode: aNode.
	"OCASTMethodMetadataAnalyser new visitNode: aNode"
]

as yet unclassified
tryToReplaceMethod: aMethodNode
	
	(self isAccessor: aMethodNode)
		ifTrue: [ ^ OzAccessorReadNode replace: aMethodNode ].
	(self isMutator: aMethodNode)
		ifTrue: [ ^ OzAccessorWriteNode replace: aMethodNode ].
	
	^ nil
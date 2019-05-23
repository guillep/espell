visiting
visitIfTrueNode: anIfTrueNode
	| theReceiver block |
	theReceiver := self interpret: anIfTrueNode receiver.
	(self classOf: theReceiver) name = 'PCTrue'
		ifTrue: [ block := anIfTrueNode trueCondition body ]
		ifFalse: [ block := RBLiteralNode value: nil ].
	"It is for sure a block"
	block isSequence ifTrue: [
		block temporaries do: [ :temp |
			(self context hasTempNamed: temp name) ifFalse: [
				self context temporaries
						at: temp name
						put: (self interpret: (RBLiteralValueNode value: nil)).
			 ]
		]
	].
	^ self interpret: block.
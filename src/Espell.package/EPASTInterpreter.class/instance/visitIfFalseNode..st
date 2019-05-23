visiting
visitIfFalseNode: anIfFalseNode
	| theReceiver block |
	theReceiver := self interpret: anIfFalseNode receiver.
	(self classOf: theReceiver) name = 'PCFalse'
		ifTrue: [ block := anIfFalseNode falseCondition body  ]
		ifFalse: [ block := RBLiteralNode value: nil ].
	"It is for sure a block"
	^ self interpret: block.
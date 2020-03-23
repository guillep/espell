visiting
visitIfNode: anIfNode
	| theReceiver block |
	theReceiver := self interpret: anIfNode receiver.
	(self classOf: theReceiver) name = (evaluator classNamed: 'True') name
		ifTrue: [ block := anIfNode trueCondition ]
		ifFalse: [ block := anIfNode falseCondition ].
	
	^ block isBlock ifTrue: [
		"It is for sure a block"
		self interpret: block body.
	] ifFalse: [ 
		self send: (Message selector: #value) to: (self interpret: block)
	]
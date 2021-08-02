visiting-special-nodes
visitWhileTrueNode: aWhileTrueNode

	| theReceiver lastResult |
	[ 
	aWhileTrueNode receiver temporaries do: [ :temporary |
		self context temporaries
			at: temporary name
			put: context receiver ].
				
	lastResult := theReceiver := self interpret: aWhileTrueNode receiver body.
	self ifSkip: [ ^ lastResult ].

	(self classOf: theReceiver) name = aWhileTrueNode expectedBooleanValue]
		whileTrue: [
			"It is for sure a block"
"			aWhileTrueNode condition temporaries do: [ :temporary |
				self context temporaries
					at: temporary name
					put: theReceiver ].
"			lastResult := self interpret: aWhileTrueNode condition.
			self ifSkip: [ ^ lastResult ] ].

	^ theReceiver
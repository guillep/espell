visiting-special-nodes
visitIfNilNode: anIfNilNode
	| theReceiver |
	theReceiver := self interpret: anIfNilNode receiver.
	anIfNilNode trueCondition arguments ifNotEmpty: [
		context temporaries
			at: anIfNilNode trueCondition arguments first name 
			put: theReceiver.
	].

	anIfNilNode trueCondition temporaries do: [ :each | context temporaries
			at: each name 
			put: theReceiver ].

	^ ((self classOf: theReceiver) name = 'UndefinedObject') = anIfNilNode checkForNil
		ifTrue: [ self interpret: anIfNilNode trueCondition body. ]
		ifFalse: [
			anIfNilNode falseCondition isLiteralNode ifTrue: [ ^ theReceiver ].
			anIfNilNode falseCondition parent arguments ifNotEmpty: [
			self context temporaries
				at: anIfNilNode falseCondition parent arguments first name 
				put: theReceiver.
			].
			self interpret: anIfNilNode falseCondition ].

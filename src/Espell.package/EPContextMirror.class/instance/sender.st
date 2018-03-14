accessing
sender

	| sender |
	sender := self instanceVariableAtIndex: (self backend instanceVariableMapping contextSenderIndex).
	sender isNilObject ifTrue: [ ^sender ].
	^ sender asContextMirror
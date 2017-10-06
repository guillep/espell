accessing
sender

	| sender |
	sender := self instanceVariableAtIndex: 1.
	sender isNilObject ifTrue: [ ^sender ].
	^ sender asContextMirror
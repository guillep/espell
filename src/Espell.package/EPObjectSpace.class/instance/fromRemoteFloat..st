transformations
fromRemoteFloat: aRemoteFloat

	| newFloat |
	newFloat := Float basicNew: aRemoteFloat basicSize.
	1 to: 2 do: [ :i | newFloat at: i put: (aRemoteFloat at: i) asLocalLiteral ].
	^newFloat
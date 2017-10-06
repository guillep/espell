converting
fromLocalPositiveInteger: aPositiveInteger

	| integerClassMirror integerMirror |
	integerClassMirror := self largePositiveIntegerClass asClassMirror.
	integerMirror := (integerClassMirror basicNew: aPositiveInteger basicSize).
	1 to: aPositiveInteger basicSize do: [ :i | integerMirror at: i put: ((aPositiveInteger at: i) asLiteralInObjectSpace: self) ].
	^integerMirror
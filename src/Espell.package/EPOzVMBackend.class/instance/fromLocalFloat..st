converting
fromLocalFloat: aLocalFloat

	| floatClassMirror floatMirror |
	floatClassMirror := self floatClass asClassMirror.
	floatMirror := (floatClassMirror basicNew: aLocalFloat basicSize) asFloatMirror.
	1 to: 2 do: [ :i | floatMirror at: i put: ((aLocalFloat at: i) asLiteralInObjectSpace: self) ].
	^floatMirror
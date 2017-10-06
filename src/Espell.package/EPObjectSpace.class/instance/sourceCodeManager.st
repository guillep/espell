accessing
sourceCodeManager

	sourceCodeManager ifNil: [ self error: 'no source code manager installed in this object space' ].
	^ sourceCodeManager
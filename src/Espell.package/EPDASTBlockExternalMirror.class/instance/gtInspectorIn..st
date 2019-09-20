gt-inspector-extension
gtInspectorIn: composite
	| cr block |
	block := self target object.
	cr := Character cr.
	^composite text
		title: 'Source with interval';
		display: [ block sourceCodeInMethod ];
		initialize: [ :presentation | 
			presentation selectionInterval: block interval ]
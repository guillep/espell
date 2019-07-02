gt-inspector-extension
gtInspectorIn: composite
	<gtInspectorPresentationOrder: 0>
	| cr block |
	block := self target object.
	cr := Character cr.
	^composite text
		title: 'EPDASTBlockMirror';
		display: [ block sourceCodeInMethod ];
		initialize: [ :presentation | 
			presentation selectionInterval: block interval ]
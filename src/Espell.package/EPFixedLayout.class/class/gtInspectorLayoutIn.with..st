gt-inspector-extension
gtInspectorLayoutIn: composite with: aMirror
	^ composite table
		title: 'FixedLayout view';
		display: [
			(aMirror basicClassFromEnvironment allInstVarNames) collectWithIndex: [ :ivName :i | ivName -> (aMirror instanceVariableAtIndex: i) ] ];
		column: 'Key' evaluated: [:each | each key ];
		column: 'Value' evaluated: [ :each | each value ];
		send: #value
	
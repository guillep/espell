gt-inspector-extension
gtInspectorLayoutIn: composite with: aMirror
	^ composite table
		title: 'Dictionary view';
		display: [ | array | 
				array := (aMirror instanceVariableAtIndex:2).
				((1 to: array basicSize) collect: [ :i | array at: i ]) reject: [ :each | each = aMirror backend nilObject ] ];
		column: 'Key' evaluated: [:each | each instanceVariableAtIndex:1];
		column: 'Value' evaluated: [ :each | each instanceVariableAtIndex:2 ]
	
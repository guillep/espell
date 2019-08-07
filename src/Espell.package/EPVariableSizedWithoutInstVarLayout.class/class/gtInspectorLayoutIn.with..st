gt-inspector-extension
gtInspectorLayoutIn: composite with: aMirror

	^ composite table
		title: 'VariableSizesWOIV view';
		display: [
			(1 to: aMirror basicSize) collect: [ :i | i -> (aMirror at: i) ] ];
		column: 'Index' evaluated: [:each | each key ];
		column: 'Item' evaluated: [ :each | each value ];
		send: #value
	
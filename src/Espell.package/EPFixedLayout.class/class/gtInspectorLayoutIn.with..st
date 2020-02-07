gt-inspector-extension
gtInspectorLayoutIn: composite with: aMirror
	^ composite table
		title: 'FixedLayout view';
		display: [ aMirror allInstanceVariables ];
		column: 'Key' evaluated: [:each | each key ];
		column: 'Value' evaluated: [ :each | each value ];
		send: #value
	
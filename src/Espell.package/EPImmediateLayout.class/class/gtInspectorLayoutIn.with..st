gt-inspector-extension
gtInspectorLayoutIn: composite with: aMirror
	
	^composite text
		title: 'ImmediateLayout view';
		display: [ aMirror asSmallInteger asString ]
		
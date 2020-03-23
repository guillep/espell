printing
gtInspectorLayoutIn: composite with: aMirror
	
	^composite text
		title: 'ByteIndexable view';
		display: [ aMirror asString ]
		
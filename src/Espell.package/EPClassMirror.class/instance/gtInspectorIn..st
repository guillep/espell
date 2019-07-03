gt-inspector-extension
gtInspectorIn: composite
	<gtInspectorPresentationOrder: 0>

	^composite text
		title: 'EPClassMirror';
		display: [ 
			| cr |
			cr := Character cr.
			
			self classNameWithOrigin, cr,
			'hash: ',self identityHash, cr,
			"'Superclass: ', self superclass className, cr,"
			'TypeSpec: ', self instSpec , ' = ', self instSpecDescription ];
		when: [ true ] 
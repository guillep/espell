gt-inspector-extension
gtInspectorIn: composite
	<gtInspectorPresentationOrder: 5>

	^composite text
		title: 'Mirror(Class)';
		display: [ 
			| cr |
			cr := Character cr.
			
			self classNameWithOrigin, cr,
			"'Superclass: ', self superclass className, cr,"
			'TypeSpec: ', self instSpec , ' = ', self instSpecDescription ];
		when: [ true ] 
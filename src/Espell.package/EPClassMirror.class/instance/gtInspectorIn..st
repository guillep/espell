gt-inspector-extension
gtInspectorIn: composite

	^composite text
		title: 'self ClassMirror';
		display: [ 
			| cr |
			cr := Character cr.
			
			self classNameWithOrigin, cr,
			'hash: ',self identityHash, cr,
			'Superclass: ', self basicClass superclass className, cr,
			'instSpec: ', self instSpec , ' = ', self instSpecDescription, cr,
			'instSize: ', self instSize , cr,  
			'format: ', self format asString , cr];
		when: [ true ] 
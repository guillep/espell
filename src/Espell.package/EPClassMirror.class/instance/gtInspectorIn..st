gt-inspector-extension
gtInspectorIn: composite

	^composite text
		title: 'mirror';
		display: [ 
			| cr sclass |
			sclass := self basicClass superclass.
			cr := Character cr.
			self classNameWithOrigin, cr,
			'hash: ',self identityHash, cr,
			'Superclass: ', (sclass isNilObject ifTrue: [ sclass asString ] ifFalse: [ sclass asClassMirror classNameFromAnyOrigin asString ]), cr,
			'instSpec: ', self instSpec , ' = ', self instSpecDescription, cr,
			'instSize: ', self instSize , cr,  
			'format: ', self format asString , cr];
		when: [ true ] 
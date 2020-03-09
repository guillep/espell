gt-inspector-extension
gtInspectorIn: composite

	^composite text
		title: 'mirror';
		display: [ 
			| cr sclass |
			sclass := self basicClass superclass.
			cr := Character cr asString.
			self classNameWithOrigin, cr,
			'hash: ',self identityHash asString, cr,
			'Superclass: ', (sclass isNilObject ifTrue: [ sclass asString ] ifFalse: [ sclass asClassMirror classNameFromAnyOrigin asString ]), cr,
			'instSpec: ', self instSpec asString, ' = ', self instSpecDescription, cr,
			'instSize: ', self instSize asString, cr,  
			'format: ', self format asString , cr];
		when: [ true ] 
accessing
hasTempNamed: aName
	self temporaries 
		at: aName 
		ifPresent: [ :value| ^ true ].
	
	self homeContext 
		ifNil: [ ^ false ].
		
	^ self homeContext hasTempNamed: aName.
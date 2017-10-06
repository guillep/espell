testing
isMethodProperties: anObjectMirror
	(self worldConfiguration hasClass: #methodProperties)
		ifFalse: [ ^false ].
	^ anObjectMirror getClass pointsToSameObject:
							self environment methodPropertiesClass
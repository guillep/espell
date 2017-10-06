mapping
classForClassMirror: anEPClassMirror 
	
	(self isMeta: anEPClassMirror)
		ifTrue: [ ^ self metaclassForClassMirror: anEPClassMirror ].
	^ EPRemoteClass on: anEPClassMirror environment: self
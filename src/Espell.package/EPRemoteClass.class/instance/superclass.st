accessing
superclass
	
	mirror superclass isNilObject ifTrue: [ ^ nil ].
	^ EPRemoteClass on: mirror superclass environment: environment
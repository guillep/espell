accessing
superclass
	| superclmirror |
	
	superclmirror := mirror superclass.
	superclmirror isNilObject ifTrue: [ ^ nil ].
	
	^ EPRemoteClass on: superclmirror environment: environment 
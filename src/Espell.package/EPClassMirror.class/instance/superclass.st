accessing
superclass
	| superclmirror |
	superclmirror := self instanceVariableAtIndex: (self backend instanceVariableMapping classSuperclassIndex). 
	
	superclmirror isNilObject 
		ifTrue: [ 
			| rgsupercl |
			rgsupercl := self asRGClass superclass.
			rgsupercl ifNil: [ ^ superclmirror ].
			
			superclmirror := (self builder classLoader classNamed: rgsupercl name) 
			].
	
	^ superclmirror asClassMirror
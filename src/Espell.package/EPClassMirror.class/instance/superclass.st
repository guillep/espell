accessing
superclass
	| mirror |
	mirror := self instanceVariableAtIndex: (self backend instanceVariableMapping classSuperclassIndex). 
	^ mirror isNilObject 
		ifTrue: [ mirror ]
		ifFalse: [ mirror asClassMirror ]
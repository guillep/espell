accessing
superclass
	| mirror |
	self backend interpreter codeProvider systemDefinition classNamed: self classNameFromAnyOrigin.
	mirror := self instanceVariableAtIndex: (self backend instanceVariableMapping classSuperclassIndex). 
	^ mirror isNilObject 
		ifTrue: [ mirror ]
		ifFalse: [ mirror asClassMirror ]
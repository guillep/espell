private
looksLikeClass: anObject
	| methodDictionary mirror |
	anObject fixedSize < 3 ifTrue: [ ^false ].
	methodDictionary := anObject instanceVariableAtIndex: ((self instanceVariableMapping classMethodDictionaryIndex)).
	mirror := methodDictionary basicClass.
	
	mirror fixedSize < self classNameIndex ifTrue: [ ^false ].
	(mirror instanceVariableAtIndex: self classNameIndex) size = #MethodDictionary size ifFalse: [ ^false ].
	^mirror className == #MethodDictionary
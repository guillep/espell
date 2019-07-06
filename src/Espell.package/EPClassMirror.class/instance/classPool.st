accessing
classPool
	| instSide |
	"We wish this is a classpool dictionary"
	
	instSide := self asRGClass isInstanceSide 
						ifTrue: [ self ] ifFalse: [ (self instanceVariableAtIndex: 4) asClassMirror]. "soleInstance of Metaclass"
	^ instSide instanceVariableAtIndex: (self backend instanceVariableMapping classPoolIndex)
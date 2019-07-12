accessing
classPool
	| instSide rgClass |
	"We wish this is a classpool dictionary"
	self flag: 'non complete return result'.
	rgClass := self asRGClass.
	rgClass ifNil: [ ^self backend nilObject  ].
	instSide := rgClass isInstanceSide 
						ifTrue: [ self ] ifFalse: [ (self instanceVariableAtIndex: 4) asClassMirror]. "soleInstance of Metaclass"
	self halt.
	^ instSide instanceVariableAtIndex: 4"(self backend instanceVariableMapping classPoolIndex)"
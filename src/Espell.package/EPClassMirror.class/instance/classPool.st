accessing
classPool
	| instSide rgClass |
	"We wish this is a classpool dictionary"
	self flag: 'non complete return result'.
	rgClass := self asRGClass.
	rgClass ifNil: [ ^self backend nilObject  ].
	instSide := rgClass isInstanceSide 
						ifTrue: [ self ] ifFalse: [ (self instanceVariableAtIndex: 4) asClassMirror]. "soleInstance of Metaclass"
	
	^ [instSide instanceVariableAtIndex: self backend instanceVariableMapping classPoolIndex] on: AssertionFailure do: [ backend nilObject ]
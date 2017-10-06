visiting
visitAssignmentNode: anAssignmentNode
	| value variable theBinding |
	
	value := self interpret: anAssignmentNode value.
	variable := anAssignmentNode variable.
	theBinding := variable binding isLiteralVariable
		ifTrue: [ variable binding assoc ]
		ifFalse: [ variable binding ].
	
	theBinding accept: self assign: value inNode: variable.
	^ value
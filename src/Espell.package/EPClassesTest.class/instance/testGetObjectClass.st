tests
testGetObjectClass

	| object |
	object := objectSpace globalNamed: #Object.
	self assert: object superclass className equals: #ProtoObject.
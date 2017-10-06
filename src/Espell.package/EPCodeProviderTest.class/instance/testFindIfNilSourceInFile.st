running
testFindIfNilSourceInFile
	
	| classDefinition method |
	classDefinition := environment classNamed: #ProtoObject.
	method := classDefinition methodDictionary at: #ifNil:.
	self assert: method sourceCode equals: 'ifNil: nilBlock
	"Return self, or evaluate the block if I''m == nil (q.v.)"

	^ self'
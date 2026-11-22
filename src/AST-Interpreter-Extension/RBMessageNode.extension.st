Extension { #name : 'RBMessageNode' }

{ #category : '*AST-Interpreter-Extension' }
RBMessageNode >> = anObject [ 
	self == anObject ifTrue: [^true].
	anObject isMessage ifFalse: [ ^ false ].
	(self receiver = anObject receiver 
		and: [self selector = anObject selector]) ifFalse: [^false].
	self arguments
		with: anObject arguments
		do: [:first :second | first = second ifFalse: [^false]].
	^true
]

{ #category : '*AST-Interpreter-Extension' }
RBMessageNode >> polymorphicInlineCache [

	^ self
		propertyAt: #polymorphicInlineCache
		ifAbsentPut: [LRUCache new maximumWeight: 3 ]
]

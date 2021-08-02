*AST-Interpreter-Extension
polymorphicInlineCache

	^ self
		propertyAt: #polymorphicInlineCache
		ifAbsentPut: [LRUCache new maximumWeight: 3 ]
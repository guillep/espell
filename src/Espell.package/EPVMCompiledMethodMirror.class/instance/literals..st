accessing - literals
literals: someLiterals
	someLiterals withIndexDo: [ :literal :index |
		self literalAt: index put: (literal asLiteralInObjectSpace: self objectSpace).
	]
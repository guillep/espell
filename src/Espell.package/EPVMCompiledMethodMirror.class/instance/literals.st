accessing - literals
literals
	^(1 to: self numberOfLiterals) collect: [ :index |
		(self literalAt: index) asLocalLiteral.
	]
accessing - literals
remoteLiterals
	^(1 to: self numberOfLiterals) collect: [ :index | self literalAt: index]
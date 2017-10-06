accessing
toInternalSymbolTable

	| internal |
	internal := EPInternalSymbolTable new objectSpace: objectSpace.
	self symbolsDo: [ :symbol | 
		internal installSymbol: symbol ].
	objectSpace symbolTable: internal.
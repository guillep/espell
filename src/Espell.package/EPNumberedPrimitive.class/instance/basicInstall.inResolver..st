installing
basicInstall: aPrimitive inResolver: aPrimitiveResolver

	self resolver: aPrimitiveResolver.
	aPrimitiveResolver primitiveForNumber: number put: aPrimitive.
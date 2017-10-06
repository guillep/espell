running
setUp

	super setUp.
	objectSpace := EPTestResource current objectSpace.
	primitiveResolver := EPVMPrimitiveResolver new backend: objectSpace backend; yourself
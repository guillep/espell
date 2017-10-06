execution
postProcessResult: aResult
	
	^ (aResult target asLiteralInObjectSpace: self objectSpace)
dispatching
alternativePrimitivesResult
	^ alternativePrimitivesResult
		ifNil: [ alternativePrimitivesResult := 
			{(#primitiveSnapshot -> true).
			 (#primitiveImageName -> 'imagename')} asDictionary ]
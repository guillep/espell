dispatching
alternativePrimitivesResult
	^ alternativePrimitivesResult ifNil: [
		alternativePrimitivesResult := { #primitiveSnapshot -> true } asDictionary ]
literal resolution
value: anObject
	"we keep track in the remote representation"
	^(self asLiteralInObjectSpace: objectSpace) instanceVariableAtIndex: 2 put: anObject
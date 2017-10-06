literal resolution
asLiteralInObjectSpace: anObjectSpace

	^ ((objectSpace classNamed: ownerName)
			classPool bindingOf: name)
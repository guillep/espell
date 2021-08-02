executing
replace: aMethodNode

	variableNode := aMethodNode body statements first value.
	self replace: aMethodNode with: self.
	^ self
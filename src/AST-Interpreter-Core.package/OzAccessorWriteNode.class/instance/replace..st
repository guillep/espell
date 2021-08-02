executing
replace: aMethodNode

	variableNode := aMethodNode body statements first variable.
	self replace: aMethodNode with: self.
	^ self
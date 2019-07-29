gt-inspector-extension
forInstSpec: instSpec
	(instSpec = 1) ifTrue: [ ^ EPFixedLayout ].
	(instSpec = 7) ifTrue: [ ^ EPImmediateLayout ].
	(instSpec = 3) ifTrue: [ ^ EPVariableSizedWithInstVarLayout ].	
	^ EPLayout
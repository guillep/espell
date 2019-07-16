layout
layout 
	| instSpec |
	instSpec := self instSpec.
	(instSpec = 1) ifTrue: [ ^ EPFixedLayout ].
	 ^ EPLayout

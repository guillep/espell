layout
layout 
	| layout |
	layout := EPLayout forInstSpec: self instSpec.
	(layout = EPFixedLayout) ifTrue: [ 
		(self backend associationClass = self) ifTrue: [ 
			^ EPFixedLayoutForAssociation  ].
		(self backend dictionaryClass = self) ifTrue: [ 
			^ EPFixedLayoutForDictionary ] .
		
	 ].
	 ^ layout
	
	
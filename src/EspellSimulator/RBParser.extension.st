Extension { #name : 'RBParser' }

{ #category : '*EspellSimulator' }
RBParser class >> parseParameterNames: aString [ 
	
	^ (self parseMethod: aString) argumentNames
]

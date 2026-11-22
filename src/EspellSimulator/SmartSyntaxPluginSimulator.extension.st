Extension { #name : 'SmartSyntaxPluginSimulator' }

{ #category : '*EspellSimulator' }
SmartSyntaxPluginSimulator >> ccgLoad: forProlog expr: failBlock asKindOf: aClass from: argIndexOrNil [ 
	^[:oop|
	   "interpreterProxy success: (interpreterProxy is: oop KindOf: aClass name asString)."
	   oop]
]

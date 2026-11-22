Class {
	#name : 'EPCrossCompiler',
	#superclass : 'Object',
	#instVars : [
		'objectSpace'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'private' }
EPCrossCompiler >> basicCompileDoItFromSourceCode: sourceCode [

	"Ugly. We should not build a remote environment on demand like this. Think wether to put it in the object space or make the cross compiler know it."
	| highLevelUndefinedObjectClass env |
	env := EPRemoteEnvironment on: objectSpace backend systemDictionary.
	highLevelUndefinedObjectClass := env classForClassMirror: objectSpace nilObject basicClass.
	
	^ (OpalCompiler new
		options: #(+ optionFullBlockClosure);
		noPattern: true;
		source: sourceCode;
		encoderClass: EncoderForSistaV1;
		class: highLevelUndefinedObjectClass;
		environment: (EPDummyEnvironment on: objectSpace);
		requestor: nil;
		productionEnvironment: self class environment;
		failBlock: [ self error ];
		parseDoIt) generate


]

{ #category : 'private' }
EPCrossCompiler >> basicCompileSourceCode: sourceCode forClass: aClass [

	| options |
	options := #(+ optionFullBlockClosure).
	aClass className == #Context ifTrue: [ options := options , #(+ optionLongIvarAccessBytecodes) ].
	
	^ (OpalCompiler new
		options: options;
		source: sourceCode;
		encoderClass: EncoderForSistaV1;
		class: aClass;
		environment: aClass environment;
		requestor: nil;
		productionEnvironment: self class environment;
		failBlock: [ self error ];
		parse) generate
]

{ #category : 'compiling' }
EPCrossCompiler >> compile: sourceCode forClass: aClass inEnvironment: anEnvironment [

	| localCompiledMethod binding |

	binding := EPCrossCompilerBinding new class: aClass; environment: anEnvironment.
	[localCompiledMethod := self basicCompileSourceCode: sourceCode forClass: binding. ]
		on: OCUndeclaredVariableWarning
		do: [ :e | 
			e resume:
				(EPUndeclaredBinding new
					name: e node name;
					objectSpace: anEnvironment;
					yourself) ].
	^ localCompiledMethod asLiteralInObjectSpace: objectSpace alreadyTransformed: Dictionary new
]

{ #category : 'compiling' }
EPCrossCompiler >> compileDoIt: sourceCode [

	| localCompiledMethod |
	localCompiledMethod := self basicCompileDoItFromSourceCode: sourceCode.
	^ localCompiledMethod asLiteralInObjectSpace: objectSpace alreadyTransformed: Dictionary new
]

{ #category : 'converting' }
EPCrossCompiler >> createCompiledMethodWithSize: methodSize andHeader: header [

	^ objectSpace backend
		createCompiledMethodWithSize: methodSize
		andHeader: header
]

{ #category : 'accessing' }
EPCrossCompiler >> objectSpace: anEPObjectSpace [ 
	objectSpace := anEPObjectSpace
]

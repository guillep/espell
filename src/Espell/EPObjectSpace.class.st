"
I am an object space, defining the basic API of ""how to interact with an image""
"
Class {
	#name : 'EPObjectSpace',
	#superclass : 'Object',
	#instVars : [
		'environment',
		'symbolTransformationTable',
		'evaluator',
		'compiledMethodMapping',
		'methodPropertiesMapping',
		'byteStringMapping',
		'byteSymbolMapping',
		'largePositiveIntegerMapping',
		'largeNegativeIntegerMapping',
		'methodBuilder',
		'contextBuilder',
		'processBuilder',
		'byteArrayMapping',
		'wideStringMapping',
		'smalltalkInstance',
		'methodDictionaryBuilder',
		'sourceCodeManager',
		'imageFile',
		'characterTable',
		'backend',
		'mustRebuildSpecialObjectsArray'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'well known objects' }
EPObjectSpace >> arrayWithAll: elements [
	
	| array |
	array := self environment arrayClass basicNew: elements size.
	elements withIndexDo: [ :element :index |
		array at: index put: element
	].
	^ array
]

{ #category : 'accessing' }
EPObjectSpace >> backend [

	^ backend
]

{ #category : 'accessing' }
EPObjectSpace >> backend: aBackend [

	backend := aBackend
]

{ #category : 'accessing' }
EPObjectSpace >> bindingOfClass: aClass [
	
	^self bindingByName: aClass className
]

{ #category : 'mappings' }
EPObjectSpace >> byteArrayMapping [
	^byteArrayMapping
]

{ #category : 'mappings' }
EPObjectSpace >> byteArrayMapping: aMapping [
	byteArrayMapping := aMapping
]

{ #category : 'mappings' }
EPObjectSpace >> byteStringMapping [
	^byteStringMapping
]

{ #category : 'mappings' }
EPObjectSpace >> byteStringMapping: aMapping [
	byteStringMapping := aMapping
]

{ #category : 'mappings' }
EPObjectSpace >> byteSymbolMapping [
	^byteSymbolMapping
]

{ #category : 'mappings' }
EPObjectSpace >> byteSymbolMapping: aMapping [
	byteSymbolMapping := aMapping
]

{ #category : 'accessing' }
EPObjectSpace >> characterTable [
	^ characterTable
]

{ #category : 'accessing' }
EPObjectSpace >> characterTable: aCharacterTable [

	characterTable := aCharacterTable
]

{ #category : 'class-bootstrap' }
EPObjectSpace >> classNamed: aClassName [

	^ self environment at: aClassName
]

{ #category : 'class access' }
EPObjectSpace >> classNamed: aClassName ifAbsent: aBlock [

	| classHandle |
	classHandle := self environment classNamed: aClassName ifAbsent: [ ^ aBlock value ].
	^ self classMirrorOn: classHandle
]

{ #category : 'accessing' }
EPObjectSpace >> classes [
	^self environment classes collect: [ :c | self classMirrorOn: c ] 
]

{ #category : 'builders' }
EPObjectSpace >> contextBuilder [

	^contextBuilder
]

{ #category : 'builders' }
EPObjectSpace >> contextBuilder: aContextBuilder [

	contextBuilder := aContextBuilder
]

{ #category : 'converting' }
EPObjectSpace >> convertHeaderToTargetPlatform: localCompiledCode [

	"I need to convert the header to the target platform. If the target platform is different wordsize the minSmallInteger changes..."

	| encoderClass headerFlagForEncoder |

	encoderClass := localCompiledCode encoderClass.
	headerFlagForEncoder := (CompiledMethod headerFlagForEncoder:
		                         encoderClass) < 0
		                        ifTrue: [ self backend minSmallInteger ]
		                        ifFalse: [ 0 ].

	^ headerFlagForEncoder + (localCompiledCode numArgs bitShift: 24)
	  + (localCompiledCode numTemps bitShift: 18)
	  + localCompiledCode allLiterals size
	  + (localCompiledCode isPrimitive asBit bitShift: 16)
]

{ #category : 'primitives' }
EPObjectSpace >> createClassWithFormat: aClassFormat forInstancesOfFormat: theInstancesFormat [

	| mirror |
	mirror := (self createObjectWithFormat: aClassFormat) asClassMirror.
	mirror format: theInstancesFormat.
	^mirror
]

{ #category : 'primitives' }
EPObjectSpace >> createInstanceFromClassDefinition: aClassDefinition [

	^ (self
		createClassWithFormat: aClassDefinition classSide format
		forInstancesOfFormat: aClassDefinition format) basicNew
]

{ #category : 'transformations' }
EPObjectSpace >> createMethodDictionary [

	^self createMethodDictionaryInEnvironment: self environment
]

{ #category : 'transformations' }
EPObjectSpace >> createMethodDictionary: aSize [

	^ methodDictionaryBuilder createMethodDictionary: aSize inEnvironment: self environment
]

{ #category : 'transformations' }
EPObjectSpace >> createMethodDictionary: aSize inEnvironment: anEnvironment [

	^ methodDictionaryBuilder createMethodDictionary: aSize inEnvironment: anEnvironment
]

{ #category : 'transformations' }
EPObjectSpace >> createMethodDictionaryInEnvironment: anEnvironment [

	^self createMethodDictionary: 32 inEnvironment: anEnvironment
]

{ #category : 'primitives' }
EPObjectSpace >> createObjectWithFormat: aClassFormat [
	^self createObjectWithFormat: aClassFormat withSize: 0
]

{ #category : 'primitives' }
EPObjectSpace >> createObjectWithFormat: aClassFormat withSize: aSize [

	^ backend createObjectWithFormat: aClassFormat withSize: aSize
]

{ #category : 'execution' }
EPObjectSpace >> createProcessWithPriority: aPriority doing: anExpression [
	^ self
		createProcessWithPriority: aPriority
		doing: anExpression
		withTemps: #()
]

{ #category : 'execution' }
EPObjectSpace >> createProcessWithPriority: aPriority doing: anExpression withTemps: someTemps [
	| method aContext  |
	method := self methodBuilder createDoit: anExpression withTemps: someTemps inObjectSpace: self.
	aContext := self contextBuilder createContextForMethod: method inObjectSpace: self.
	^self processBuilder createProcessForContext: aContext andPriority: aPriority inObjectSpace: self.
]

{ #category : 'well known objects' }
EPObjectSpace >> createSpecialObjectsArray [
	| newSpecialObjectsArray |
	newSpecialObjectsArray := backend arrayClass asClassMirror basicNew: 56.
	newSpecialObjectsArray at: 1 put: self nilObject.
	newSpecialObjectsArray at: 2 put: self falseObject.
	newSpecialObjectsArray at: 3 put: self trueObject.
	newSpecialObjectsArray
		at: 4
		put: (self environment bindingOf: #Processor).
	newSpecialObjectsArray at: 5 put: backend nilObject.
	newSpecialObjectsArray at: 6 put: backend smallIntegerClass.
	newSpecialObjectsArray at: 7 put: backend byteStringClass.
	newSpecialObjectsArray at: 8 put: backend arrayClass.
	newSpecialObjectsArray at: 9 put: backend smalltalkInstance.
	newSpecialObjectsArray at: 10 put: backend floatClass.
	newSpecialObjectsArray at: 11 put: backend contextClass.
	newSpecialObjectsArray at: 12 put: backend nilObject.
	newSpecialObjectsArray at: 13 put: backend pointClass.
	newSpecialObjectsArray at: 14 put: backend largePositiveIntegerClass.
	newSpecialObjectsArray at: 15 put: backend nilObject.
	newSpecialObjectsArray at: 16 put: backend messageClass.
	newSpecialObjectsArray at: 17 put: backend methodClass.
	newSpecialObjectsArray at: 18 put: backend nilObject.
	newSpecialObjectsArray at: 19 put: backend semaphoreClass.
	newSpecialObjectsArray at: 20 put: backend characterClass.
	newSpecialObjectsArray at: 21 put: (#doesNotUnderstand: asLiteralInObjectSpace: self).
	newSpecialObjectsArray at: 22 put: (#cannotReturn: asLiteralInObjectSpace: self).
	newSpecialObjectsArray at: 23 put: backend nilObject.
	newSpecialObjectsArray at: 24 put: (#(#+ 1 #- 1 #< 1 #> 1 #'<=' 1 #'>=' 1 #= 1 #'~=' 1 #* 1 #/ 1 #'\\' 1 #@ 1 #bitShift: 1 #'//' 1 #bitAnd: 1 #bitOr: 1 #at: 1 #at:put: 2 #size 0 #next 0 #nextPut: 1 #atEnd 0 #'==' 1 nil 0 nil 1 #value 0 #value: 1 #do: 1 #new 0 #new: 1 #x 0 #y 0) asLiteralInObjectSpace: self).
	newSpecialObjectsArray
		at: 25
		put: backend characterTable. "character table"
	newSpecialObjectsArray at: 26 put: (#mustBeBoolean asLiteralInObjectSpace: self).
	newSpecialObjectsArray at: 27 put: backend byteArrayClass.
	newSpecialObjectsArray at: 28 put: backend processClass.
	newSpecialObjectsArray at: 29 put: self newCompactClassesArray.
	30 to: 56 do: [ :idx | newSpecialObjectsArray at: idx put: backend nilObject ].
	newSpecialObjectsArray at: 37 put: backend blockClass.
	"External semaphore table"
	newSpecialObjectsArray at: 39 put: (backend arrayClass asClassMirror basicNew: 20 ).
	newSpecialObjectsArray at: 43 put: backend largeNegativeIntegerClass.
	newSpecialObjectsArray at: 49 put: (#aboutToReturn:through: asLiteralInObjectSpace: self).
	newSpecialObjectsArray at: 50 put: (#run:with:in: asLiteralInObjectSpace: self).
	self flag: #'add WeakFinalization list'.
	^newSpecialObjectsArray.
]

{ #category : 'compiler' }
EPObjectSpace >> crossCompiler [
	
	^ EPCrossCompiler new
		objectSpace: self;
		yourself
]

{ #category : 'accessing' }
EPObjectSpace >> environment [
	^environment
]

{ #category : 'accessing' }
EPObjectSpace >> environment: anEnvironment [
	environment := anEnvironment.
	"environment objectSpace: self."
]

{ #category : 'special objects' }
EPObjectSpace >> falseObject [
	
	^ self backend falseObject
]

{ #category : 'special objects' }
EPObjectSpace >> falseObject: aNilObject [
	
	self backend falseObject: aNilObject
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalByteArray: aByteArray [ 
	
	"Direct backend transformation"
	^ self backend fromLocalByteArray: aByteArray
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalByteString: aByteString [

	^ self backend fromLocalByteString: aByteString
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalByteSymbol: aByteSymbol [

	^ self symbolTable at: aByteSymbol ifAbsentPut: [ 
		backend fromLocalByteSymbol: aByteSymbol ]
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalCharacter: aCharacter [
	
	^ self backend fromLocalCharacter: aCharacter

]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalCompiledCode: localCompiledCode alreadyTransformed: alreadyTransformed [

	| methodSize methodMirror header |

	alreadyTransformed at: localCompiledCode ifPresent: [ :e | ^ e ]. 
	
   methodSize := localCompiledCode bytecode size + CompiledMethodTrailer empty size.
	header := self convertHeaderToTargetPlatform: localCompiledCode.

	methodMirror := localCompiledCode isCompiledBlock 
		ifTrue: [ self backend
						createCompiledBlockWithSize: methodSize
						andHeader: header ]
		ifFalse: [ self backend
						createCompiledMethodWithSize: methodSize
						andHeader: header ].

	methodMirror bytecodes: localCompiledCode bytecode.

	alreadyTransformed at: localCompiledCode put: methodMirror.
	
	localCompiledCode allLiterals withIndexDo: [ :literal :index | 
		methodMirror literalAt: index put: (self transformLiteral: literal alreadyTransformed: alreadyTransformed).
	].

	^methodMirror
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalCompiledMethod: aCompiledMethod [
	
	^compiledMethodMapping fromLocal: aCompiledMethod inEnvironment: self environment
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalCompiledMethod: aCompiledMethod inEnvironment: anEnvironment [
	
	^compiledMethodMapping fromLocal: aCompiledMethod inEnvironment: anEnvironment
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalFloat: aLocalFloat [

	^ self backend fromLocalFloat: aLocalFloat.
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalInteger: anInteger [

	^backend fromLocalInteger: anInteger
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalMethodProperties: aMethodPropertiesObject [

	^methodPropertiesMapping fromLocal: aMethodPropertiesObject
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalNegativeInteger: aNegativeInteger [

	^backend fromLocalNegativeInteger: aNegativeInteger
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalPositiveInteger: aPositiveInteger [

	^ backend fromLocalPositiveInteger: aPositiveInteger
]

{ #category : 'transformations' }
EPObjectSpace >> fromLocalWideString: aWideString [

	^wideStringMapping fromLocal: aWideString
]

{ #category : 'transformations' }
EPObjectSpace >> fromRemoteBoolean: aBooleanMirror [
	(aBooleanMirror pointsToSameObject: self trueObject)
		ifTrue: [ ^true ].
	(aBooleanMirror pointsToSameObject: self falseObject)
		ifTrue: [  ^false ].
	self error: 'non a boolean remote object'.
]

{ #category : 'transformations' }
EPObjectSpace >> fromRemoteByteArray: aByteArray [ 
	
	^byteArrayMapping fromRemote: aByteArray.
]

{ #category : 'transformations' }
EPObjectSpace >> fromRemoteByteString: aRemoteByteString [
	^byteStringMapping fromRemote: aRemoteByteString
]

{ #category : 'transformations' }
EPObjectSpace >> fromRemoteByteSymbol: aRemoteByteSymbol [
	^byteSymbolMapping fromRemote: aRemoteByteSymbol
]

{ #category : 'transformations' }
EPObjectSpace >> fromRemoteCharacter: aRemoteCharacter [
	^Character value: (aRemoteCharacter instanceVariableAtIndex: 1) target asSmallInteger.
]

{ #category : 'transformations' }
EPObjectSpace >> fromRemoteCompiledMethod: aRemoteCompiledMethod [
	
	^compiledMethodMapping fromRemote: aRemoteCompiledMethod
]

{ #category : 'transformations' }
EPObjectSpace >> fromRemoteFloat: aRemoteFloat [

	| newFloat |
	newFloat := Float basicNew: aRemoteFloat basicSize.
	1 to: 2 do: [ :i | newFloat at: i put: (aRemoteFloat at: i) asLocalLiteral ].
	^newFloat
]

{ #category : 'transformations' }
EPObjectSpace >> fromRemoteLargeNegativeInteger: aNegativeInteger [

	^largeNegativeIntegerMapping fromRemote: aNegativeInteger
]

{ #category : 'transformations' }
EPObjectSpace >> fromRemoteLargePositiveInteger: aPositiveInteger [

	^largePositiveIntegerMapping fromRemote: aPositiveInteger
]

{ #category : 'transformations' }
EPObjectSpace >> fromRemoteWideString: aWideString [

	^wideStringMapping fromRemote: aWideString
]

{ #category : 'converting' }
EPObjectSpace >> fromSmallInteger: anInteger [ 
	
	"Direct backend conversion"
	^ self backend fromSmallInteger: anInteger
]

{ #category : 'execution' }
EPObjectSpace >> giveChanceToRun [

	self rebuildSpecialObjectsArray.
	backend giveChanceToRun.
]

{ #category : 'environment' }
EPObjectSpace >> globalNamed: aGlobalName [
	
	^ self systemDictionary at: aGlobalName
]

{ #category : 'globals' }
EPObjectSpace >> globalObjects [
	
	^ self systemDictionary globalObjects
]

{ #category : 'interfaces' }
EPObjectSpace >> hasInterpreter [

	^ evaluator notNil
]

{ #category : 'accessing' }
EPObjectSpace >> imageFile [

	^ imageFile
]

{ #category : 'accessing' }
EPObjectSpace >> imageFile: aFileReference [

	imageFile := aFileReference
]

{ #category : 'testing' }
EPObjectSpace >> includesClassNamed: aClassName [
	^self environment includesClassNamed: aClassName
]

{ #category : 'testing' }
EPObjectSpace >> includesGlobalNamed: aClassName [
	^self environment includesGlobalNamed: aClassName
]

{ #category : 'initialize-release' }
EPObjectSpace >> initialize [
	super initialize.
	
	"compactClasses := EPDictionary new."
	
	environment := EPSystemDictionary new objectSpace: self; yourself.
	mustRebuildSpecialObjectsArray := false.
	self withInternalSymbolTable.
	self withInternalCharacterTable.

	self initializeMappings.
	self initializeBuilders.
]

{ #category : 'initialize-release' }
EPObjectSpace >> initializeBuilders [
	"self halt."
	methodBuilder := EPVMCompiledMethodMirror.
	"methodDictionaryBuilder := OzMethodDictionaryMirror."
	contextBuilder := EPContextMirror.
	processBuilder := EPProcessMirror.
]

{ #category : 'initialize-release' }
EPObjectSpace >> initializeMappings [
	self methodMapping: (EPMethodMapping new objectSpace: self; yourself).

	"self methodPropertiesMapping: (OzMethodPropertiesMapping new objectSpace: self; yourself).
	self byteStringMapping: (OzByteStringMapping new objectSpace: self; yourself).
	self byteSymbolMapping: (OzByteSymbolMapping new objectSpace: self; yourself).
	self byteArrayMapping: (OzByteArrayMapping new objectSpace: self; yourself).
	self largeNegativeIntegerMapping: (OzLargeNegativeIntegerMapping new objectSpace: self; yourself).
	self largePositiveIntegerMapping: (OzLargePositiveIntegerMapping new objectSpace: self; yourself).
	self wideStringMapping: (OzWideStringMapping new objectSpace: self; yourself)."
]

{ #category : 'execution' }
EPObjectSpace >> installAsActiveProcess: aProcessMirror [
	| activeProcess theProcessor |
	theProcessor := (self environment at: #Processor) asSchedulerMirror.
	activeProcess := theProcessor activeProcess.
	"If this is already the active process we have nothing to do"
	(activeProcess pointsToSameObject: aProcessMirror)
		ifTrue: [ ^self ].
	
	"If there is another active process we queue it"
	activeProcess isNilObject ifFalse: [
		activeProcess queue
	].
	
	aProcessMirror asProcessMirror priorityList: self nilObject.
	theProcessor activeProcess: aProcessMirror.
]

{ #category : 'initialize-release' }
EPObjectSpace >> interpreter [
	evaluator ifNil: [ self error: 'interpreter not initialized for this object space' ].
	^evaluator
]

{ #category : 'initialize-release' }
EPObjectSpace >> interpreter: anEvaluator [
	evaluator := anEvaluator.
	evaluator objectSpace: self.
	backend interpreter: anEvaluator
]

{ #category : 'testing' }
EPObjectSpace >> isMethodProperties: anObjectMirror [
	(self worldConfiguration hasClass: #methodProperties)
		ifFalse: [ ^false ].
	^ anObjectMirror getClass pointsToSameObject:
							self environment methodPropertiesClass
]

{ #category : 'mappings' }
EPObjectSpace >> largeNegativeIntegerMapping [
	
	^ largeNegativeIntegerMapping
]

{ #category : 'mappings' }
EPObjectSpace >> largeNegativeIntegerMapping: anObject [
	
	largeNegativeIntegerMapping := anObject
]

{ #category : 'mappings' }
EPObjectSpace >> largePositiveIntegerMapping [
	
	^ largePositiveIntegerMapping
]

{ #category : 'mappings' }
EPObjectSpace >> largePositiveIntegerMapping: anObject [
	
	largePositiveIntegerMapping := anObject
]

{ #category : 'loading' }
EPObjectSpace >> loadImage: anImageFile [
	
	backend loadImage: anImageFile asFileReference.
	self systemDictionary buildCache.
	self interpreter: (EPASTEvaluator new 
		codeProvider: ((EPRemoteEnvironment
			on: self backend systemDictionary)
			imageFileName: anImageFile;
			yourself);
		objectSpace: self)
]

{ #category : 'printing' }
EPObjectSpace >> longPrintOn: aStream limitedTo: sizeLimit indent: indent [
	aStream cr
]

{ #category : 'builders' }
EPObjectSpace >> methodBuilder [

	^methodBuilder
]

{ #category : 'builders' }
EPObjectSpace >> methodBuilder: aMethodBuilder [ 

	methodBuilder := aMethodBuilder
]

{ #category : 'builders' }
EPObjectSpace >> methodDictionaryBuilder: aBuilder [

	methodDictionaryBuilder := aBuilder
]

{ #category : 'mappings' }
EPObjectSpace >> methodMapping [
	^compiledMethodMapping
]

{ #category : 'mappings' }
EPObjectSpace >> methodMapping: aMethodMapping [ 
	compiledMethodMapping := aMethodMapping
]

{ #category : 'mappings' }
EPObjectSpace >> methodPropertiesMapping [
	^methodPropertiesMapping
]

{ #category : 'mappings' }
EPObjectSpace >> methodPropertiesMapping: aMapping [
	methodPropertiesMapping := aMapping
]

{ #category : 'special objects array' }
EPObjectSpace >> mustNotRebuildSpecialObjectsArray [
	
	mustRebuildSpecialObjectsArray := false.
]

{ #category : 'special objects array' }
EPObjectSpace >> mustRebuildSpecialObjectsArray [
	
	mustRebuildSpecialObjectsArray := true.
]

{ #category : 'instance creation' }
EPObjectSpace >> newArrayOf: size [

	^ self arrayClass basicNew: size
]

{ #category : 'builders' }
EPObjectSpace >> newArrayWithAll: elements [

	| array |
	array := self backend arrayClass asClassMirror basicNew: elements size.
	1 to: elements size do: [ :index | array at: index put: (elements at: index) ].
	^ array
]

{ #category : 'instance creation' }
EPObjectSpace >> newAssociation [

	^ self environment associationClass basicNew
]

{ #category : 'builders' }
EPObjectSpace >> newAssociationWithKey: aKey [

	| association |
	association := backend associationClass basicNew.
	association instanceVariableAtIndex: 1 put: aKey.
	^ association
]

{ #category : 'builders' }
EPObjectSpace >> newAssociationWithKey: aKey andValue: aValue [

	| association |
	association := self backend associationClass basicNew.
	association instanceVariableAtIndex: 1 put: aKey.
	association instanceVariableAtIndex: 2 put: aValue.
	^ association
]

{ #category : 'instance creation' }
EPObjectSpace >> newCompactClassesArray [

	| array |
	array := backend arrayClass asClassMirror basicNew: 31.
	1 to: 31 do: [ :index | 
		array at: index put: (backend compactClassAt: index ifNone: [ self nilObject ]) ].
	^ array
]

{ #category : 'instance creation' }
EPObjectSpace >> newMessageWithSelector: selector arguments: args andLookupClass: lookupClass [

	| message |
	message := self environment messageClass basicNew.
	message instVarAt: 1 put: selector.
	message instVarAt: 2 put: args.
	message instVarAt: 3 put: lookupClass.
	^ message
]

{ #category : 'builders' }
EPObjectSpace >> newMethodWithBytecodeSize: bytecodeSize withHeader: aMethodHeader [

	^ (backend 
					newMethodOfClass: self methodClass target
					withBytecodeSize: bytecodeSize
					withHeader: (aMethodHeader asLiteralInObjectSpace: self) target)
]

{ #category : 'instance creation' }
EPObjectSpace >> newSemaphore [

	| semaphore |
	semaphore := self environment semaphoreClass basicNew.
	semaphore instanceVariableAtIndex: 3 put: 0.
	^ semaphore
]

{ #category : 'special objects' }
EPObjectSpace >> nilObject [
	
	^ self backend nilObject
]

{ #category : 'special objects' }
EPObjectSpace >> nilObject: aNilObject [
	
	self backend nilObject: aNilObject
]

{ #category : 'mirror handling' }
EPObjectSpace >> objectMirrorOn: anObject [
	
	^ EPMirror on: anObject from: self
]

{ #category : 'accessing' }
EPObjectSpace >> objectSpace [

	^ self
]

{ #category : 'accessing' }
EPObjectSpace >> primitives [

	^ backend primitives
]

{ #category : 'builders' }
EPObjectSpace >> processBuilder [

	^processBuilder
]

{ #category : 'builders' }
EPObjectSpace >> processBuilder: aProcessBuilder [

	processBuilder := aProcessBuilder.
]

{ #category : 'execution' }
EPObjectSpace >> processor [

	^ processor
]

{ #category : 'execution' }
EPObjectSpace >> processor: aProcessor [

	^ processor := aProcessor
]

{ #category : 'special objects array' }
EPObjectSpace >> rebuildSpecialObjectsArray [

	mustRebuildSpecialObjectsArray ifFalse: [ ^ self ].
	mustRebuildSpecialObjectsArray := false.
	"self environment createCompactClassesArray."
	self createSpecialObjectsArray in: [ :array |
		self specialObjectsArray: array.
		^array
		]
]

{ #category : 'transformations' }
EPObjectSpace >> serializeInFileNamed: fileName [
	self halt.
	"OzImageSerializer new
		inStream: (FileStream newFileNamed: fileName);
		serialize: (OzGraphTracer new objectSpace: self;yourself)"
]

{ #category : 'well known objects' }
EPObjectSpace >> setBasicSpecialObjectsArray: aRemoteSpecialObjectsArray [

	self specialObjectsArray: (self objectMirrorOn: aRemoteSpecialObjectsArray)
]

{ #category : 'accessing' }
EPObjectSpace >> smalltalkInstance [

	^ smalltalkInstance ifNil: [ self nilObject ]
]

{ #category : 'accessing' }
EPObjectSpace >> smalltalkInstance: aSmalltalkInstance [

	smalltalkInstance := aSmalltalkInstance
]

{ #category : 'accessing' }
EPObjectSpace >> sourceCodeManager [

	sourceCodeManager ifNil: [ self error: 'no source code manager installed in this object space' ].
	^ sourceCodeManager
]

{ #category : 'accessing' }
EPObjectSpace >> sourceCodeManager: aSourceCodeManager [

	sourceCodeManager := aSourceCodeManager.
	sourceCodeManager
		objectSpace: self;
		loadCode
]

{ #category : 'accessing' }
EPObjectSpace >> specialObjectsArray: aSpecialObjectsArray [

	backend specialObjectsArray: aSpecialObjectsArray
]

{ #category : 'initialize-release' }
EPObjectSpace >> startEmptyImage [
	
	backend startEmptyImage
]

{ #category : 'accessing' }
EPObjectSpace >> symbolTable [
	^symbolTransformationTable
]

{ #category : 'symbol-table' }
EPObjectSpace >> symbolTable: aSymbolTable [

	symbolTransformationTable := aSymbolTable
]

{ #category : 'globals' }
EPObjectSpace >> systemDictionary [
	
	^ environment
]

{ #category : 'lookup by name' }
EPObjectSpace >> traitNamed: aTraitName [ 
	
	^self traitMirrorOn: (self environment globalNamed: aTraitName)
]

{ #category : 'accessing' }
EPObjectSpace >> traitNamed: aTraitName ifAbsent: aBlock [

	^ self traitMirrorOn: (self environment globalNamed: aTraitName ifAbsent: [ ^ aBlock value ])
]

{ #category : 'accessing' }
EPObjectSpace >> traits [
	^self environment traits collect: [ :c | self traitMirrorOn: c ] 
]

{ #category : 'execution' }
EPObjectSpace >> transferExecutionTo: aProcess [

	self backend transferExecutionTo: aProcess
]

{ #category : 'converting' }
EPObjectSpace >> transformLiteral: aLiteral alreadyTransformed: aDictionary [
	
	aDictionary at: aLiteral ifPresent: [ :x | ^ x ].
	
	aLiteral isMethodProperties ifTrue: [
		"For now we convert method properties in selectors. Careful! We are losing pragmas at bootstrap time!"
		^ aLiteral selector asLiteralInObjectSpace: self alreadyTransformed: aDictionary
	].
	^ aLiteral asLiteralInObjectSpace: self alreadyTransformed: aDictionary
]

{ #category : 'special objects' }
EPObjectSpace >> trueObject [
	
	^ self backend trueObject
]

{ #category : 'special objects' }
EPObjectSpace >> trueObject: aNilObject [
	
	self backend trueObject: aNilObject
]

{ #category : 'accessing' }
EPObjectSpace >> vmInterface [
	
	^ vmInterface
]

{ #category : 'accessing' }
EPObjectSpace >> wideStringMapping [
	^ wideStringMapping
]

{ #category : 'accessing' }
EPObjectSpace >> wideStringMapping: anObject [
	wideStringMapping := anObject
]

{ #category : 'symbol-table' }
EPObjectSpace >> withInternalCharacterTable [

	"characterTable := OzInternalCharacterTable new objectSpace: self; yourself."
]

{ #category : 'symbol-table' }
EPObjectSpace >> withInternalSymbolTable [

	self symbolTable: (EPInternalSymbolTable new objectSpace: self; yourself).
]

{ #category : 'accessing' }
EPObjectSpace >> wordSize [
	^4
]

{ #category : 'accessing' }
EPObjectSpace >> worldConfiguration [
	^worldConfiguration
]

{ #category : 'accessing' }
EPObjectSpace >> worldConfiguration: configuration [
	worldConfiguration := configuration
]

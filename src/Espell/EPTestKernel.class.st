"
I build a small kernel in an object space simulated by VMMaker, so the tests of Espell run without a bootstrapped image. `EPTestResource` creates me once for all the tests.

I follow the first steps of the bootstrap: I create the objects the VM needs (nil, false, true, the free lists, the class table and the special objects array), then the classes of `#classSpecifications` with their metaclasses, and a system dictionary holding them. Then I prepare the simulator to execute primitives.

I also play the role of the image builder of the bootstrap for the AST interpreter: I am its code provider and its environment. I describe the kernel in a Ring model with the methods of `#methodSpecifications`, map the class mirrors to their Ring definitions (`#classForClassMirror:`) and answer the globals.

## Design Rationale

- The classes use the class shape that `EPInstanceVariableMapping` expects. Metaclass is a subclass of Class, so that metaclasses have the same slots, plus `thisClass`.
- The dictionaries are not hashed, since Espell reads them with a linear search.
- I find the Ring definition of a class mirror by the name of the class, not by its address, since preparing the simulator moves the objects.

## Variables

### Instance variables

- **objectSpace** (`EPObjectSpace`): the object space of the kernel, on an `EPSimulatorBackend`.
- **classes** (`Dictionary` of `Symbol` -> `EPClassMirror`): the classes of the kernel by name.
- **systemDefinition** (`RGEnvironment`): the Ring model of the kernel, where the AST interpreter reads the methods.
- **interpreter** (`EPASTEvaluator`): the AST interpreter running code in the kernel.
- **globals** (`Dictionary`): the globals that interpreted code assigns, which are not classes.
"
Class {
	#name : #EPTestKernel,
	#superclass : #Object,
	#instVars : [
		'objectSpace',
		'classes',
		'systemDefinition',
		'interpreter',
		'globals'
	],
	#category : #'Espell-Tests'
}

{ #category : #definitions }
EPTestKernel >> allInstanceVariableNamesOf: aName [

	| superclassName |
	superclassName := (self specificationOf: aName) second.
	^ (superclassName
		   ifNil: [ #(  ) ]
		   ifNotNil: [ self allInstanceVariableNamesOf: superclassName ]) , (self instanceVariableNamesOf: aName)
]

{ #category : #building }
EPTestKernel >> allocateClassTable [

	"Allocate the root of the class table and enough pages for the classes and metaclasses of the kernel, from the first ordinary class index."

	| memory tableRoot numberOfPages |
	memory := self objectMemory.
	tableRoot := memory allocateSlots: memory classTableRootSlots + memory hiddenRootSlots format: memory arrayFormat classIndex: memory arrayClassIndexPun.
	memory nilFieldsOf: tableRoot.
	numberOfPages := (memory classTablePageSize + (self classSpecifications size * 2) + memory classTableMinorIndexMask / memory classTablePageSize) truncated.
	1 to: numberOfPages do: [ :index | 
		| page |
		page := memory allocateSlots: memory classTablePageSize format: memory arrayFormat classIndex: memory arrayClassIndexPun.
		memory fillObj: page numSlots: memory classTablePageSize with: memory nilObject.
		memory storePointer: index - 1 ofObject: tableRoot withValue: page ].
	memory setHiddenRootsObj: tableRoot
]

{ #category : #building }
EPTestKernel >> allocateFreeLists [

	| memory freeLists |
	memory := self objectMemory.
	freeLists := memory allocateSlots: memory numFreeLists format: memory wordIndexableFormat classIndex: memory wordSizeClassIndexPun.
	0 to: memory numFreeLists - 1 do: [ :index | memory storePointerUnchecked: index ofObject: freeLists withValue: 0 ].
	memory initializeFreeSpacePostLoad: freeLists
]

{ #category : #accessing }
EPTestKernel >> backend [

	^ objectSpace backend
]

{ #category : #'code provider' }
EPTestKernel >> bindingOf: aName [

	(self includesClassNamed: aName) ifFalse: [ ^ nil ].
	^ EPGlobalBinding new
		  name: aName objectSpace: self;
		  yourself
]

{ #category : #building }
EPTestKernel >> build [

	self
		createObjectSpace;
		createVMObjects;
		createClasses;
		installSpecialClasses;
		initializeClasses;
		createSystemDictionary;
		prepareForExecution;
		createSystemDefinition;
		createInterpreter
]

{ #category : #'code provider' }
EPTestKernel >> classForClassMirror: aClassMirror [

	"Answer the Ring definition of a class or a metaclass of the kernel."

	(self isMeta: aClassMirror) ifTrue: [ ^ (self definitionNamed: (self instanceSideOf: aClassMirror) className) classSide ].
	^ self definitionNamed: aClassMirror className
]

{ #category : #'code provider' }
EPTestKernel >> classLoader [

	"The AST evaluator asks the class loader whether a do-it is a class definition. The kernel has no class loader."

	^ self
]

{ #category : #accessing }
EPTestKernel >> classMirrorNamed: aName [

	^ classes at: aName
]

{ #category : #'code provider' }
EPTestKernel >> classNamed: aName [

	^ (self classMirrorNamed: aName) asRemoteClassOrTraitFromEnvironment: self
]

{ #category : #definitions }
EPTestKernel >> classSpecifications [

	"Name, superclass, layout, instance variables, class variables and shared pools of the classes of the kernel, superclasses first.
	Metaclass is a subclass of Class so that metaclasses have the slots of the classes that EPInstanceVariableMapping expects, plus thisClass."

	^ #( #( #ProtoObject nil #fixed '' '' '' ) #( #Object #ProtoObject #fixed '' 'DependentsFields' '' ) #( #UndefinedObject #Object #fixed '' '' '' ) #( #Boolean #Object #fixed '' '' '' )
	     #( #True #Boolean #fixed '' '' '' ) #( #False #Boolean #fixed '' '' '' ) #( #Magnitude #Object #fixed '' '' '' ) #( #Character #Magnitude #immediate '' 'CharacterTable' '' )
	     #( #Number #Magnitude #fixed '' '' '' ) #( #Integer #Number #fixed '' '' '' ) #( #SmallInteger #Integer #immediate '' '' '' ) #( #LargePositiveInteger #Integer #bytes '' '' '' )
	     #( #LargeNegativeInteger #LargePositiveInteger #bytes '' '' '' ) #( #Collection #Object #fixed '' '' '' ) #( #SequenceableCollection #Collection #fixed '' '' '' )
	     #( #ArrayedCollection #SequenceableCollection #fixed '' '' '' ) #( #Array #ArrayedCollection #variable '' '' '' ) #( #String #ArrayedCollection #fixed '' '' '' )
	     #( #ByteString #String #bytes '' '' '' ) #( #Symbol #String #fixed '' '' '' ) #( #ByteSymbol #Symbol #bytes '' '' '' ) #( #ByteArray #ArrayedCollection #bytes '' '' '' )
	     #( #OrderedCollection #SequenceableCollection #fixed 'array firstIndex lastIndex' '' '' ) #( #HashedCollection #Collection #fixed 'tally array' '' '' )
	     #( #Dictionary #HashedCollection #fixed '' '' '' ) #( #SystemDictionary #Dictionary #fixed '' '' '' ) #( #MethodDictionary #Dictionary #variable '' '' '' )
	     #( #LookupKey #Magnitude #fixed 'key' '' '' ) #( #Association #LookupKey #fixed 'value' '' '' ) #( #SharedPool #Object #fixed '' '' '' ) #( #ChronologyConstants #SharedPool #fixed '' 'SecondsInMinute'
	        '' ) #( #Time #Magnitude #fixed 'seconds nanos' '' 'ChronologyConstants' ) #( #Behavior #Object #fixed 'superclass methodDict format' '' '' )
	     #( #ClassDescription #Behavior #fixed 'layout instanceVariables organization' '' '' ) #( #Class #ClassDescription #fixed 'subclasses name classPool sharedPools environment category traitComposition localSelectors'
	        '' '' ) #( #Metaclass #Class #fixed 'thisClass' '' '' ) #( #CompiledCode #ByteArray #compiledMethod '' '' '' ) #( #CompiledMethod #CompiledCode #compiledMethod '' '' '' )
	     #( #CompiledBlock #CompiledCode #compiledMethod '' '' '' ) #( #Context #Object #variable 'sender pc stackp method closureOrNil receiver' '' '' )
	     #( #SmalltalkImage #Object #fixed 'globals' '' '' ) )
]

{ #category : #building }
EPTestKernel >> createClassNamed: aName [

	| metaclass class |
	metaclass := (self classMirrorNamed: #Metaclass) basicNew asClassMirror.
	metaclass format: (self formatOf: #Class).
	class := metaclass basicNew asClassMirror.
	class format: (self formatOf: aName).
	classes at: aName put: class
]

{ #category : #building }
EPTestKernel >> createClasses [

	self createMetaclass.
	self classSpecifications do: [ :definition | definition first = #Metaclass ifFalse: [ self createClassNamed: definition first ] ]
]

{ #category : #building }
EPTestKernel >> createInterpreter [

	interpreter := EPASTEvaluator new
		               codeProvider: self;
		               environment: self;
		               objectSpace: objectSpace;
		               interpreterClass: EPTestASTInterpreter;
		               yourself.
	objectSpace interpreter: interpreter
]

{ #category : #building }
EPTestKernel >> createMetaclass [

	"Metaclass and its metaclass are instances of each other, so we create them from nothing, with a temporary class index, and then set their classes."

	| metaclass metaclassClass |
	metaclass := self newClassWithFormat: (self formatOf: #Class) forInstancesOfFormat: (self formatOf: #Metaclass).
	metaclassClass := self newClassWithFormat: (self formatOf: #Metaclass) forInstancesOfFormat: (self formatOf: #Class).
	metaclass setClass: metaclassClass.
	metaclassClass setClass: metaclass.
	classes at: #Metaclass put: metaclass
]

{ #category : #building }
EPTestKernel >> createObjectSpace [

	objectSpace := EPObjectSpace new.
	objectSpace backend: EPSimulatorBackend for64Bit forBootstrap.
	objectSpace symbolTable: (EPExternalSymbolTable new
			 objectSpace: objectSpace;
			 yourself).
	classes := Dictionary new
]

{ #category : #building }
EPTestKernel >> createSystemDefinition [

	"Describe the classes and the methods of the kernel in a Ring model. The AST interpreter reads the methods there, as it reads the sources of the bootstrapped kernel in the bootstrap."

	systemDefinition := RGEnvironment new.
	globals := Dictionary new.
	self classSpecifications do: [ :specification | 
		| class |
		class := systemDefinition ensureClassNamed: specification first.
		specification second ifNotNil: [ :superclassName | class superclass: (systemDefinition ensureClassNamed: superclassName) ].
		class
			instanceVariables: (self instanceVariableNamesOf: specification first);
			classVariables: (specification at: 5) substrings;
			sharedPools: (specification at: 6) substrings ].
	systemDefinition
		clean;
		fixProtoObjectClassSuperclass.
	"Ring leaves the superclass of ProtoObject unresolved, and an unresolved class is its own superclass, so looking up a missing selector would never end."
	(self definitionNamed: #ProtoObject) superclass: nil.
	self methodSpecifications do: [ :specification | 
		| behavior |
		behavior := self definitionNamed: specification first.
		specification second = #class ifTrue: [ behavior := behavior classSide ].
		behavior compile: specification third classified: 'kernel' ]
]

{ #category : #building }
EPTestKernel >> createSystemDictionary [

	| systemDictionary smalltalk |
	systemDictionary := self
		                    newDictionaryOf: #SystemDictionary
		                    withAll: (self classSpecifications collect: [ :definition | objectSpace newAssociationWithKey: (self symbol: definition first) andValue: (self classMirrorNamed: definition first) ]).
	classes do: [ :class | class instanceVariableAtIndex: (self slotIndexOf: #environment in: #Class) put: systemDictionary ].
	smalltalk := (self classMirrorNamed: #SmalltalkImage) basicNew.
	smalltalk instanceVariableAtIndex: self backend instanceVariableMapping smalltalkImageGlobalsIndex put: systemDictionary.
	self backend smalltalkInstance: smalltalk.
	objectSpace environment: ((EPSystemDictionary withSystemDictionary: systemDictionary)
			 objectSpace: objectSpace;
			 yourself)
]

{ #category : #building }
EPTestKernel >> createVMObjects [

	"Create nil, false and true, then the free lists and the class table, which the memory manager expects right after them, then the special objects array."

	| firstClassIndex |
	firstClassIndex := self objectMemory classTablePageSize.
	objectSpace nilObject: (self backend createObjectWithFormat: 0 withSize: 0 classIndex: firstClassIndex).
	objectSpace falseObject: (self backend createObjectWithFormat: 0 withSize: 0 classIndex: firstClassIndex + 1).
	objectSpace trueObject: (self backend createObjectWithFormat: 0 withSize: 0 classIndex: firstClassIndex + 2).
	self
		allocateFreeLists;
		allocateClassTable.
	objectSpace specialObjectsArray: (self backend createObjectWithFormat: 2 << 16 withSize: 60 classIndex: self objectMemory arrayClassIndexPun).
	objectSpace
		nilObject: objectSpace nilObject;
		falseObject: objectSpace falseObject;
		trueObject: objectSpace trueObject
]

{ #category : #'code provider' }
EPTestKernel >> definitionNamed: aName [

	^ systemDefinition ask behaviorNamed: aName
]

{ #category : #definitions }
EPTestKernel >> formatOf: aName [

	"The format of the instances of the class: the instance specification shifted by 16 bits plus the number of instance variables."

	| layout size |
	layout := (self specificationOf: aName) third.
	size := self instanceSizeOf: aName.
	layout = #immediate ifTrue: [ ^ 7 << 16 ].
	layout = #bytes ifTrue: [ ^ 16 << 16 + size ].
	layout = #compiledMethod ifTrue: [ ^ 24 << 16 + size ].
	layout = #variable ifTrue: [ 
		^ (size = 0
			   ifTrue: [ 2 ]
			   ifFalse: [ 3 ]) << 16 + size ].
	^ (size = 0
		   ifTrue: [ 0 ]
		   ifFalse: [ 1 ]) << 16 + size
]

{ #category : #'code provider' }
EPTestKernel >> globalNamed: aName [

	(self includesClassNamed: aName) ifTrue: [ ^ self classMirrorNamed: aName asSymbol ].
	^ globals at: aName
]

{ #category : #'code provider' }
EPTestKernel >> globalNamed: aName put: aValue [

	globals at: aName put: aValue
]

{ #category : #'code provider' }
EPTestKernel >> includesClassNamed: aName [

	^ classes includesKey: aName asSymbol
]

{ #category : #building }
EPTestKernel >> initializeClassNamed: aName [

	| definition class metaclass mapping |
	definition := self specificationOf: aName.
	class := self classMirrorNamed: aName.
	metaclass := class basicClass asClassMirror.
	mapping := self backend instanceVariableMapping.
	class
		instanceVariableAtIndex: mapping classSuperclassIndex put: (definition second
				 ifNil: [ objectSpace nilObject ]
				 ifNotNil: [ :superclassName | self classMirrorNamed: superclassName ]);
		methodDictionary: self newMethodDictionary;
		instanceVariableAtIndex: mapping classInstanceVariableNamesIndex put: (self newArrayWithAll: ((self instanceVariableNamesOf: aName) collect: [ :each | self symbol: each ]));
		basicSetClassName: (self symbol: aName);
		classPool: (self newClassPoolFor: aName);
		instanceVariableAtIndex: mapping classSharedPoolsIndex put: (self newSharedPoolsFor: aName).
	metaclass
		instanceVariableAtIndex: mapping classSuperclassIndex put: (definition second
				 ifNil: [ self classMirrorNamed: #Class ]
				 ifNotNil: [ :superclassName | (self classMirrorNamed: superclassName) basicClass ]);
		methodDictionary: self newMethodDictionary;
		instanceVariableAtIndex: mapping classInstanceVariableNamesIndex put: (self newArrayWithAll: #(  ));
		instanceVariableAtIndex: (self slotIndexOf: #thisClass in: #Metaclass) put: class
]

{ #category : #building }
EPTestKernel >> initializeClasses [

	self classSpecifications do: [ :definition | self initializeClassNamed: definition first ]
]

{ #category : #building }
EPTestKernel >> installSpecialClasses [

	"Tell the backend which classes the VM knows. This also puts the classes of the immediate objects and Array at their fixed indexes in the class table."

	self backend
		smallIntegerClass: (self classMirrorNamed: #SmallInteger);
		characterClass: (self classMirrorNamed: #Character);
		arrayClass: (self classMirrorNamed: #Array);
		byteStringClass: (self classMirrorNamed: #ByteString);
		byteSymbolClass: (self classMirrorNamed: #ByteSymbol);
		symbolTableClass: (self classMirrorNamed: #Symbol);
		byteArrayClass: (self classMirrorNamed: #ByteArray);
		associationClass: (self classMirrorNamed: #Association);
		largePositiveIntegerClass: (self classMirrorNamed: #LargePositiveInteger);
		largeNegativeIntegerClass: (self classMirrorNamed: #LargeNegativeInteger);
		methodClass: (self classMirrorNamed: #CompiledMethod);
		compiledBlockClass: (self classMirrorNamed: #CompiledBlock);
		contextClass: (self classMirrorNamed: #Context).
	objectSpace nilObject setClass: (self classMirrorNamed: #UndefinedObject).
	objectSpace falseObject setClass: (self classMirrorNamed: #False).
	objectSpace trueObject setClass: (self classMirrorNamed: #True)
]

{ #category : #'code provider' }
EPTestKernel >> instanceSideOf: aMetaclassMirror [

	^ (aMetaclassMirror instanceVariableAtIndex: (self slotIndexOf: #thisClass in: #Metaclass)) asClassMirror
]

{ #category : #definitions }
EPTestKernel >> instanceSizeOf: aName [

	^ (self allInstanceVariableNamesOf: aName) size
]

{ #category : #definitions }
EPTestKernel >> instanceVariableNamesOf: aName [

	^ ((self specificationOf: aName) at: 4) substrings collect: [ :each | each asSymbol ]
]

{ #category : #accessing }
EPTestKernel >> interpreter [

	^ interpreter
]

{ #category : #'code provider' }
EPTestKernel >> isClassDefinition: aString [

	^ false
]

{ #category : #'code provider' }
EPTestKernel >> isMeta: aClassMirror [

	^ aClassMirror basicClass target address = (self classMirrorNamed: #Metaclass) target address
]

{ #category : #'code provider' }
EPTestKernel >> metaclassForClassMirror: aClassMirror [

	^ EPRemoteMetaClass on: aClassMirror environment: self
]

{ #category : #definitions }
EPTestKernel >> methodSpecifications [

	"Class, side and source of the methods that the tests interpret."

	^ #( #( #Object #instance 'yourself
	^ self' ) #( #Object #instance 'initialize
	^ self' ) #( #Object #class 'dependentsFields
	^ DependentsFields' ) #( #Object #class 'dependentsFields: anObject
	DependentsFields := anObject' ) #( #Behavior #instance 'basicNew
	<primitive: 70>
	^ nil' ) #( #Behavior #instance 'basicNew: anInteger
	<primitive: 71>
	^ nil' ) #( #Behavior #instance 'new
	^ self basicNew initialize' ) #( #Behavior #instance 'new: anInteger
	^ (self basicNew: anInteger) initialize' ) #( #SmallInteger #instance '+ aNumber
	<primitive: 1>
	^ nil' ) #( #SmallInteger #instance '< aNumber
	<primitive: 3>
	^ nil' ) #( #Integer #instance 'answer
	^ 41' ) #( #SmallInteger #instance 'answer
	^ super answer + 1' ) #( #HashedCollection #class 'new
	^ self basicNew initialize: 5' ) #( #HashedCollection #instance 'initialize: anInteger
	tally := 0.
	array := Array new: anInteger' ) #( #HashedCollection #instance 'size
	^ tally' ) #( #LookupKey #instance 'key
	^ key' ) #( #LookupKey #instance 'key: anObject
	key := anObject' ) #( #Association #instance 'value
	^ value' ) #( #Association #instance 'value: anObject
	value := anObject' ) #( #Association #class 'key: aKey value: aValue
	^ self new
		key: aKey;
		value: aValue;
		yourself' ) #( #ChronologyConstants #class 'initialize
	SecondsInMinute := 60' ) #( #Time #class 'secondsInMinute
	^ SecondsInMinute' ) )
]

{ #category : #private }
EPTestKernel >> newArrayWithAll: aCollection [

	^ objectSpace newArrayWithAll: aCollection asArray
]

{ #category : #private }
EPTestKernel >> newClassPoolFor: aName [

	| classVariableNames |
	classVariableNames := ((self specificationOf: aName) at: 5) substrings.
	classVariableNames ifEmpty: [ ^ objectSpace nilObject ].
	^ self newDictionaryOf: #Dictionary withAll: (classVariableNames collect: [ :each | objectSpace newAssociationWithKey: (self symbol: each asSymbol) andValue: objectSpace nilObject ])
]

{ #category : #private }
EPTestKernel >> newClassWithFormat: aClassFormat forInstancesOfFormat: anInstanceFormat [

	"EPObjectSpace>>#createClassWithFormat:forInstancesOfFormat: creates the object with the class index 0, which the memory manager takes for a forwarder. We use the class index of the hidden arrays until the class is set."

	| class |
	class := (self backend createObjectWithFormat: aClassFormat withSize: 0 classIndex: self objectMemory arrayClassIndexPun) asClassMirror.
	class format: anInstanceFormat.
	^ class
]

{ #category : #private }
EPTestKernel >> newDictionaryOf: aClassName withAll: someAssociations [

	"The dictionaries of Espell are read by a linear search on their array, so we do not hash the associations."

	| dictionary |
	dictionary := (self classMirrorNamed: aClassName) basicNew.
	dictionary
		instanceVariableAtIndex: 1 put: (self backend smallIntegerMirrorOn: someAssociations size);
		instanceVariableAtIndex: 2 put: (self newArrayWithAll: someAssociations).
	^ dictionary
]

{ #category : #private }
EPTestKernel >> newMethodDictionary [

	| methodDictionary |
	methodDictionary := (self classMirrorNamed: #MethodDictionary) basicNew: 32.
	methodDictionary
		instanceVariableAtIndex: 1 put: (self backend smallIntegerMirrorOn: 0);
		instanceVariableAtIndex: 2 put: ((self classMirrorNamed: #Array) basicNew: 32).
	^ methodDictionary
]

{ #category : #private }
EPTestKernel >> newSharedPoolsFor: aName [

	| pools sharedPools |
	pools := ((self specificationOf: aName) at: 6) substrings collect: [ :each | self classMirrorNamed: each asSymbol ].
	pools ifEmpty: [ ^ objectSpace nilObject ].
	sharedPools := (self classMirrorNamed: #OrderedCollection) basicNew.
	sharedPools
		instanceVariableAtIndex: 1 put: (self newArrayWithAll: pools);
		instanceVariableAtIndex: 2 put: (self backend smallIntegerMirrorOn: 1);
		instanceVariableAtIndex: 3 put: (self backend smallIntegerMirrorOn: pools size + 1).
	^ sharedPools
]

{ #category : #accessing }
EPTestKernel >> objectMemory [

	^ self backend objectMemory
]

{ #category : #accessing }
EPTestKernel >> objectSpace [

	^ objectSpace
]

{ #category : #building }
EPTestKernel >> prepareForExecution [

	"Move the objects to the old space and set up the interpreter, so the simulator can execute primitives, as the bootstrap does after creating its first objects."

	| memory |
	memory := self objectMemory.
	memory initializePostBootstrap.
	self backend simulator initializeInterpreter: 0.
	memory flushNewSpace.
	self backend initializeExecutionContext.
	memory
		initializePostBootstrap;
		initializeNewSpaceVariables;
		bootstrapping: false;
		assimilateNewSegment: (memory segmentManager segments at: 0);
		setCheckForLeaks: 0
]

{ #category : #definitions }
EPTestKernel >> slotIndexOf: aSlotName in: aClassName [

	^ (self allInstanceVariableNamesOf: aClassName) indexOf: aSlotName
]

{ #category : #definitions }
EPTestKernel >> specificationOf: aName [

	^ self classSpecifications detect: [ :definition | definition first = aName ]
]

{ #category : #private }
EPTestKernel >> symbol: aSymbol [

	^ aSymbol asLiteralInObjectSpace: objectSpace
]

{ #category : #accessing }
EPTestKernel >> systemDefinition [

	^ systemDefinition
]

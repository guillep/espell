"
I build a small kernel in an object space simulated by VMMaker, for the tests of Espell.

I create the objects the VM needs (nil, false, true, the free lists, the class table and the special objects array) as the bootstrap does, then the classes described in `#classDefinitions` with their metaclasses, names, instance variables, class pools and shared pools, and a system dictionary holding them.

The classes use the class shape that `EPInstanceVariableMapping` expects. Metaclasses have the same slots plus `thisClass`.

    EPTestKernel new build objectSpace
"
Class {
	#name : #EPTestKernel,
	#superclass : #Object,
	#instVars : [
		'objectSpace',
		'classes'
	],
	#category : #'Espell-Tests'
}

{ #category : #definitions }
EPTestKernel >> allInstanceVariableNamesOf: aName [

	| superclassName |
	superclassName := (self definitionNamed: aName) second.
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
	numberOfPages := (memory classTablePageSize + (self classDefinitions size * 2) + memory classTableMinorIndexMask / memory classTablePageSize) truncated.
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

{ #category : #building }
EPTestKernel >> build [

	self
		createObjectSpace;
		createVMObjects;
		createClasses;
		installSpecialClasses;
		initializeClasses;
		createSystemDictionary;
		prepareForExecution
]

{ #category : #definitions }
EPTestKernel >> classDefinitions [

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

{ #category : #accessing }
EPTestKernel >> classNamed: aName [

	^ classes at: aName
]

{ #category : #building }
EPTestKernel >> createClassNamed: aName [

	| metaclass class |
	metaclass := (self classNamed: #Metaclass) basicNew asClassMirror.
	metaclass format: (self formatOf: #Class).
	class := metaclass basicNew asClassMirror.
	class format: (self formatOf: aName).
	classes at: aName put: class
]

{ #category : #building }
EPTestKernel >> createClasses [

	self createMetaclass.
	self classDefinitions do: [ :definition | definition first = #Metaclass ifFalse: [ self createClassNamed: definition first ] ]
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
EPTestKernel >> createSystemDictionary [

	| systemDictionary smalltalk |
	systemDictionary := self
		                    newDictionaryOf: #SystemDictionary
		                    withAll: (self classDefinitions collect: [ :definition | objectSpace newAssociationWithKey: (self symbol: definition first) andValue: (self classNamed: definition first) ]).
	classes do: [ :class | class instanceVariableAtIndex: (self slotIndexOf: #environment in: #Class) put: systemDictionary ].
	smalltalk := (self classNamed: #SmalltalkImage) basicNew.
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

{ #category : #definitions }
EPTestKernel >> definitionNamed: aName [

	^ self classDefinitions detect: [ :definition | definition first = aName ]
]

{ #category : #definitions }
EPTestKernel >> formatOf: aName [

	"The format of the instances of the class: the instance specification shifted by 16 bits plus the number of instance variables."

	| layout size |
	layout := (self definitionNamed: aName) third.
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

{ #category : #building }
EPTestKernel >> initializeClassNamed: aName [

	| definition class metaclass mapping |
	definition := self definitionNamed: aName.
	class := self classNamed: aName.
	metaclass := class basicClass asClassMirror.
	mapping := self backend instanceVariableMapping.
	class
		instanceVariableAtIndex: mapping classSuperclassIndex put: (definition second
				 ifNil: [ objectSpace nilObject ]
				 ifNotNil: [ :superclassName | self classNamed: superclassName ]);
		methodDictionary: self newMethodDictionary;
		instanceVariableAtIndex: mapping classInstanceVariableNamesIndex put: (self newArrayWithAll: ((self instanceVariableNamesOf: aName) collect: [ :each | self symbol: each ]));
		basicSetClassName: (self symbol: aName);
		classPool: (self newClassPoolFor: aName);
		instanceVariableAtIndex: mapping classSharedPoolsIndex put: (self newSharedPoolsFor: aName).
	metaclass
		instanceVariableAtIndex: mapping classSuperclassIndex put: (definition second
				 ifNil: [ self classNamed: #Class ]
				 ifNotNil: [ :superclassName | (self classNamed: superclassName) basicClass ]);
		methodDictionary: self newMethodDictionary;
		instanceVariableAtIndex: mapping classInstanceVariableNamesIndex put: (self newArrayWithAll: #(  ));
		instanceVariableAtIndex: (self slotIndexOf: #thisClass in: #Metaclass) put: class
]

{ #category : #building }
EPTestKernel >> initializeClasses [

	self classDefinitions do: [ :definition | self initializeClassNamed: definition first ]
]

{ #category : #building }
EPTestKernel >> installSpecialClasses [

	"Tell the backend which classes the VM knows. This also puts the classes of the immediate objects and Array at their fixed indexes in the class table."

	self backend
		smallIntegerClass: (self classNamed: #SmallInteger);
		characterClass: (self classNamed: #Character);
		arrayClass: (self classNamed: #Array);
		byteStringClass: (self classNamed: #ByteString);
		byteSymbolClass: (self classNamed: #ByteSymbol);
		symbolTableClass: (self classNamed: #Symbol);
		byteArrayClass: (self classNamed: #ByteArray);
		associationClass: (self classNamed: #Association);
		largePositiveIntegerClass: (self classNamed: #LargePositiveInteger);
		largeNegativeIntegerClass: (self classNamed: #LargeNegativeInteger);
		methodClass: (self classNamed: #CompiledMethod);
		compiledBlockClass: (self classNamed: #CompiledBlock);
		contextClass: (self classNamed: #Context).
	objectSpace nilObject setClass: (self classNamed: #UndefinedObject).
	objectSpace falseObject setClass: (self classNamed: #False).
	objectSpace trueObject setClass: (self classNamed: #True)
]

{ #category : #definitions }
EPTestKernel >> instanceSizeOf: aName [

	^ (self allInstanceVariableNamesOf: aName) size
]

{ #category : #definitions }
EPTestKernel >> instanceVariableNamesOf: aName [

	^ ((self definitionNamed: aName) at: 4) substrings collect: [ :each | each asSymbol ]
]

{ #category : #private }
EPTestKernel >> newArrayWithAll: aCollection [

	^ objectSpace newArrayWithAll: aCollection asArray
]

{ #category : #private }
EPTestKernel >> newClassPoolFor: aName [

	| classVariableNames |
	classVariableNames := ((self definitionNamed: aName) at: 5) substrings.
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
	dictionary := (self classNamed: aClassName) basicNew.
	dictionary
		instanceVariableAtIndex: 1 put: (self backend smallIntegerMirrorOn: someAssociations size);
		instanceVariableAtIndex: 2 put: (self newArrayWithAll: someAssociations).
	^ dictionary
]

{ #category : #private }
EPTestKernel >> newMethodDictionary [

	| methodDictionary |
	methodDictionary := (self classNamed: #MethodDictionary) basicNew: 32.
	methodDictionary
		instanceVariableAtIndex: 1 put: (self backend smallIntegerMirrorOn: 0);
		instanceVariableAtIndex: 2 put: ((self classNamed: #Array) basicNew: 32).
	^ methodDictionary
]

{ #category : #private }
EPTestKernel >> newSharedPoolsFor: aName [

	| pools sharedPools |
	pools := ((self definitionNamed: aName) at: 6) substrings collect: [ :each | self classNamed: each asSymbol ].
	pools ifEmpty: [ ^ objectSpace nilObject ].
	sharedPools := (self classNamed: #OrderedCollection) basicNew.
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

{ #category : #private }
EPTestKernel >> symbol: aSymbol [

	^ aSymbol asLiteralInObjectSpace: objectSpace
]

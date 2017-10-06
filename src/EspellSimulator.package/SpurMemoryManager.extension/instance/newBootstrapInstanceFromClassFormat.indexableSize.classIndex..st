*EspellSimulator
newBootstrapInstanceFromClassFormat: classFormat indexableSize: nElements classIndex: classIndex
	<api>
	<var: #nElements type: #usqInt>
	"Allocate an instance of a variable class, excepting CompiledMethod."
	| instSpec numSlots newObj fillValue |
	instSpec := self instSpecOfClassFormat: classFormat.
	fillValue := 0.
	instSpec caseOf: {
		[self arrayFormat]	->
			[numSlots := nElements.
			 fillValue := nilObj].
		[self indexablePointersFormat]	->
			[numSlots := (self fixedFieldsOfClassFormat: classFormat) + nElements.
			 fillValue := nilObj].
		[self weakArrayFormat]	->
			[numSlots := (self fixedFieldsOfClassFormat: classFormat) + nElements.
			 fillValue := nilObj].
		[self sixtyFourBitIndexableFormat]	->
			[nElements > (self maxSlotsForAlloc / 2) ifTrue:
				[coInterpreter primitiveFailFor: PrimErrUnsupported.
				 ^nil].
			 numSlots := nElements * 2].
		[self firstLongFormat]	->
			[(classIndex = ClassFloatCompactIndex and: [nElements ~= 2]) ifTrue:
				[coInterpreter primitiveFailFor: PrimErrBadReceiver.
				 ^nil].
			 numSlots := nElements].
		[self firstShortFormat]	->
			[numSlots := nElements + 1 // 2.
			 instSpec := instSpec + (nElements bitAnd: 1)].
		[self firstByteFormat]	->
			[numSlots := nElements + 3 // 4.
			 instSpec := instSpec + (4 - nElements bitAnd: 3)] }
		otherwise: ["some Squeak images include funky fixed subclasses of abstract variable
					 superclasses. e.g. DirectoryEntry as a subclass of ArrayedCollection.
					 Allow fixed classes to be instantiated here iff nElements = 0."
					 (nElements ~= 0 or: [instSpec > self lastPointerFormat]) ifTrue:
						[^nil].
					 numSlots := self fixedFieldsOfClassFormat: classFormat]. "non-indexable"
	numSlots > self maxSlotsForNewSpaceAlloc
		ifTrue:
			[numSlots > self maxSlotsForAlloc ifTrue:
				[coInterpreter primitiveFailFor: PrimErrUnsupported.
				 ^nil].
			 newObj := self allocateSlotsInOldSpace: numSlots format: instSpec classIndex: classIndex]
		ifFalse:
			[newObj := self allocateSlots: numSlots format: instSpec classIndex: classIndex].
	newObj ifNotNil:
		[self fillObj: newObj numSlots: numSlots with: fillValue].
	^newObj
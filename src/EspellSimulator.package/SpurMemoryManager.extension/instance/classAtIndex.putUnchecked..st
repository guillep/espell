*EspellSimulator
classAtIndex: classIndex putUnchecked: objOop
	"for become & GC of classes"
	| classTablePage |
	classTablePage := self fetchPointer: classIndex >> self classTableMajorIndexShift
							ofObject: hiddenRootsObj.
	classTablePage = nilObj ifTrue:
		[self error: 'attempt to add class to empty page'].
	^self
		storePointer: (classIndex bitAnd: self classTableMinorIndexMask)
		ofObject: classTablePage
		withValue: objOop
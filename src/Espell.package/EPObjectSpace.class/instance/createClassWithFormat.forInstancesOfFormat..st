primitives
createClassWithFormat: aClassFormat forInstancesOfFormat: theInstancesFormat

	| mirror |
	self halt.
	mirror := (self createObjectWithFormat: aClassFormat) asClassMirror.
	mirror format: theInstancesFormat.
	^mirror
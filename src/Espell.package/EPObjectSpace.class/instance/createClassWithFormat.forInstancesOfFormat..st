primitives
createClassWithFormat: aClassFormat forInstancesOfFormat: theInstancesFormat

	| mirror |
	mirror := (self createObjectWithFormat: aClassFormat) asClassMirror.
	mirror format: theInstancesFormat.
	^mirror
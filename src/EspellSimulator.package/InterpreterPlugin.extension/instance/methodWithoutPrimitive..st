*EspellSimulator
methodWithoutPrimitive: method
	"Answer either aMethod or a copy of aMehtod, such that the result does /not/ have a primitive."
	<doNotGenerate>
	| mn properties newProperties |
	method primitive = 0 ifTrue:
		[^method].
	mn := method methodNode copy.
	mn pragmas: (mn pragmas select: [:pragma|
		(pragma selector beginsWith: #primitive:) not ]).
	^ mn generate: method trailer
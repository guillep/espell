primitives
instanceFixedSizeOf: aClass
	| format |
	format := aClass format.
	^((format bitShift: -10) bitAnd: 16rC0) + ((format bitShift: -1) bitAnd: 16r3F) - 1
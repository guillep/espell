accessing
primitive
	| primBits |
	primBits := self header bitAnd: 16r100001FF.
	
	^ (primBits bitAnd: 16r1FF) + (primBits bitShift: -19)

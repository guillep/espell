as yet unclassified
numberOfLiteralsOf: aHandle
	"Answer the number of literals used by the receiver."
	
	self halt.
	"header =
	header
	^ (self objectAt: 1) target asSmallInteger"
	^ (aHandle header bitShift: -9) bitAnd: 16rFF
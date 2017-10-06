private
digitCompare: arg 
	"Compare the magnitude of self with that of arg.   
	Return a code of 1, 0, -1 for self >, = , < arg"
	<primitive: 'primDigitCompare' module:'LargeIntegers'>
	Context primitiveFailToken
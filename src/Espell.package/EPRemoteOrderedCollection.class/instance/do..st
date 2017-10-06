iterating
do: aBlockClosure 
	
	| array |
	array := mirror instanceVariableAtIndex: 1.
	1 to: array size do: [ :index | | elem |
		elem := array at: index.
		elem isNilObject ifFalse: [ aBlockClosure value: elem ] ]
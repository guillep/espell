Extension { #name : 'CompiledCode' }

{ #category : '*Espell' }
CompiledCode >> asLiteralInObjectSpace: anObjectSpace [
	
	"Nobody should call me"
	^ 1halt.
]

{ #category : '*Espell' }
CompiledCode >> asLiteralInObjectSpace: anObjectSpace alreadyTransformed: aDictionary [
		
	^ anObjectSpace fromLocalCompiledCode: self alreadyTransformed: aDictionary
]

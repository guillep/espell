Class {
	#name : 'EPSymbolTableTest',
	#superclass : 'EPBaseTest',
	#category : 'Espell-Tests',
	#package : 'Espell',
	#tag : 'Tests'
}

{ #category : 'accessing' }
EPSymbolTableTest class >> resources [

	^{ EPTestResource }
]

{ #category : 'running' }
EPSymbolTableTest >> setUp [

	super setUp.
	objectSpace := EPTestResource current objectSpace
]

{ #category : 'tests' }
EPSymbolTableTest >> testAtSymbolIsCachedFromLoadTime [

	self assert: (objectSpace backend symbolTable includesCachedKey: #at:).
]

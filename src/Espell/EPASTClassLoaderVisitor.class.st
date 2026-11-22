Class {
	#name : 'EPASTClassLoaderVisitor',
	#superclass : 'RBProgramNodeVisitor',
	#instVars : [
		'interpreter'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'accessing' }
EPASTClassLoaderVisitor >> interpreter: anObject [
	interpreter := anObject
]

{ #category : 'visiting' }
EPASTClassLoaderVisitor >> visitArrayNode: aRBArrayNode [ 
	
	^ self visitLiteralNode: aRBArrayNode
]

{ #category : 'visiting' }
EPASTClassLoaderVisitor >> visitGlobalNode: aRBGlobalNode [

	^ self visitVariableNode: aRBGlobalNode
]

{ #category : 'visiting' }
EPASTClassLoaderVisitor >> visitGlobalVariableNode: aRBVariableNode [ 
	
	^ self visitGlobalNode: aRBVariableNode
]

{ #category : 'visiting' }
EPASTClassLoaderVisitor >> visitLiteralArrayNode: aRBLiteralArrayNode [ 
	
	self visitLiteralNode: aRBLiteralArrayNode
]

{ #category : 'accessing' }
EPASTClassLoaderVisitor >> visitLiteralNode: aLiteralNode [

	
]

{ #category : 'accessing' }
EPASTClassLoaderVisitor >> visitMessageNode: aMessageNode [

	aMessageNode receiver acceptVisitor: self.
	aMessageNode arguments do: [ :arg | arg acceptVisitor: self ]
]

{ #category : 'accessing' }
EPASTClassLoaderVisitor >> visitVariableNode: aVariableNode [

	^ interpreter loadClass: aVariableNode
]

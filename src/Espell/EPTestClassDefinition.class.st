"
I look up the variables of the methods that `EPTestASTInterpreter` compiles, from the Ring definition of their class in an `EPTestKernel`. I am a minimal version of `PBClassDefinition` of the bootstrap: I answer the instance variables of the class, the reserved variables, the class variables of the class hierarchy and of its shared pools, and the globals of the kernel.

## Variables

### Instance variables

- **classDefinition** (`RGBehavior`): the Ring definition of the class or the metaclass of the method.
- **environment** (`EPTestKernel`): the kernel, which answers the globals and the definitions of the shared pools.
"
Class {
	#name : #EPTestClassDefinition,
	#superclass : #Object,
	#instVars : [
		'classDefinition',
		'environment'
	],
	#category : #'Espell-Tests'
}

{ #category : #'instance creation' }
EPTestClassDefinition class >> on: aClassDefinition environment: anEnvironment [

	^ self new
		  initializeOn: aClassDefinition environment: anEnvironment;
		  yourself
]

{ #category : #lookup }
EPTestClassDefinition >> classVariableBindingNamed: aName in: aClassDefinition [

	^ EPClassVariableBinding new
		  name: aName ownerName: aClassDefinition name objectSpace: environment;
		  yourself
]

{ #category : #lookup }
EPTestClassDefinition >> classVariableBindingOf: aName [

	"Look for the class variable in the classes of the hierarchy and in their shared pools."

	| class |
	class := classDefinition instanceSide.
	[ class isNil ] whileFalse: [ 
		(self definition: class definesClassVariable: aName) ifTrue: [ ^ self classVariableBindingNamed: aName in: class ].
		class sharedPools do: [ :pool | 
			| poolDefinition |
			poolDefinition := environment definitionNamed: pool name.
			(self definition: poolDefinition definesClassVariable: aName) ifTrue: [ ^ self classVariableBindingNamed: aName in: poolDefinition ] ].
		class := class superclass ].
	^ nil
]

{ #category : #lookup }
EPTestClassDefinition >> definition: aClassDefinition definesClassVariable: aName [

	^ aClassDefinition classVarNames includes: aName
]

{ #category : #initialization }
EPTestClassDefinition >> initializeOn: aClassDefinition environment: anEnvironment [

	classDefinition := aClassDefinition.
	environment := anEnvironment
]

{ #category : #lookup }
EPTestClassDefinition >> lookupVar: aName declare: aBoolean [

	classDefinition allSlots
		detect: [ :slot | slot name = aName ]
		ifFound: [ :slot | ^ slot ].
	Smalltalk globals reservedVariables at: aName ifPresent: [ :variable | ^ variable ].
	(self classVariableBindingOf: aName) ifNotNil: [ :binding | ^ binding ].
	^ environment bindingOf: aName
]

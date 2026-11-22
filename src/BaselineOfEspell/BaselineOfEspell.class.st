Class {
	#name : 'BaselineOfEspell',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfEspell',
	#package : 'BaselineOfEspell'
}

{ #category : 'development support' }
BaselineOfEspell class >> DevelopmentSupport [
	<apiDocumentation>
	^ self
]

{ #category : 'private' }
BaselineOfEspell class >> baseConfigurationClassIfAbsent: t1 [
	^ Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: t1 ]
]

{ #category : 'private' }
BaselineOfEspell class >> ensureMetacello [
	(self baseConfigurationClassIfAbsent: [ nil ]) ensureMetacello.
	^ self
]

{ #category : 'private' }
BaselineOfEspell class >> ensureMetacelloBaseConfiguration [
	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| t1 t2 |
			t2 := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			t2
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :t4 | 
					t1 := t4 version.
					t1 load.
					t1 workingCopy repositoryGroup addRepository: t2 ] ].
	^ self
]

{ #category : 'metacello tool support' }
BaselineOfEspell class >> isMetacelloConfig [
	^ true
]

{ #category : 'loading' }
BaselineOfEspell class >> load [
	<apiDocumentation>
	^ (self project version: #stable) load
]

{ #category : 'loading' }
BaselineOfEspell class >> loadBleedingEdge [
	<apiDocumentation>
	^ (self project version: #bleedingEdge) load
]

{ #category : 'loading' }
BaselineOfEspell class >> loadDevelopment [
	<apiDocumentation>
	^ (self project version: #development) load
]

{ #category : 'accessing' }
BaselineOfEspell class >> project [
	^ self new project
]

{ #category : 'development support' }
BaselineOfEspell class >> validate [
	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : 'baselines' }
BaselineOfEspell >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec description: 'Espell Object Spaces'.			
			"Needs VM simulator"
			spec
				baseline: 'VMMaker'
				with: [ 
					spec
						repository: 'github://pharo-project/pharo-vm:v9.0.21/smalltalksrc' ].

			spec package: 'AST-Interpreter-Core'.
			spec package: 'AST-Interpreter-Extension' with: [ spec requires: #( 'AST-Interpreter-Core' ) ].
			
			spec package: 'EspellSimulator' with: [ spec requires: #( 'Espell' 'VMMaker' ) ].
			spec package: 'Espell' with: [ spec requires: #( 'AST-Interpreter-Core' 'AST-Interpreter-Extension' ) ]. ]
]

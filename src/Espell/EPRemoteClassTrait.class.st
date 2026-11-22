Class {
	#name : 'EPRemoteClassTrait',
	#superclass : 'EPRemoteTrait',
	#instVars : [
		'instanceSide'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'as yet unclassified' }
EPRemoteClassTrait >> binding [

	^ EPMetaclassBinding  new
			name: self name objectSpace: environment;
			yourself 
]

{ #category : 'accessing' }
EPRemoteClassTrait >> classSide [

	^ self
]

{ #category : 'accessing' }
EPRemoteClassTrait >> instanceSide [

	^ instanceSide
]

{ #category : 'accessing' }
EPRemoteClassTrait >> instanceSide: aTrait [

	instanceSide := aTrait
]

{ #category : 'as yet unclassified' }
EPRemoteClassTrait >> name [

	^ self instanceSide name
]

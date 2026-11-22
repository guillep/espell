Extension { #name : 'EPObjectSpace' }

{ #category : '*EspellSimulator' }
EPObjectSpace class >> onSimulatedBackend [

	^ self new
		  backend: EPSimulatorBackend new;
		  yourself
]

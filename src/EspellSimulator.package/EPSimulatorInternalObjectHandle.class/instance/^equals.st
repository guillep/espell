comparing
= aHandle

	^ self species = aHandle species
		and: [ self address == aHandle address ]
I am a primitive decorator that transforms the result of the getclass primitive into a class of the object space. This decorator is needed for the following cases:

- immediate objects: the VM will always return the installed class instead of the one of the object space. This is the case of SmallIntegers for example. If we get an immediate object we return the corresponding class from the object space.

- compact classes: instances of compact classes have no direct pointer to their classes but an index to a special array. The VM will then fetch the corresponding class from this array but not use the one in the object space. We perform the corresponding mapping if it is a compact class.
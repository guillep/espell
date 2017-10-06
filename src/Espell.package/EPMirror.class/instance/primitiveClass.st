private
primitiveClass

	"this method is very special. You should not call it if you don't know exactly what you are doing.
	Warning said, this is the meaning of this method:
		
		This method returns the pointer of the class of the handle, as it is understood *by the VM*.
		That means, instances of compact classes (i.e., Array, Association) will return the class from the Host image ALWAYS"
	
	^ (self executePrimitive: 111) target
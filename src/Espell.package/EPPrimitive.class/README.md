I am an abstract class representing a primitive. I have methods to wrap myself to apply some pre and post execution transformations like:

- transform all literals to a remote literal
- transform the results to remote literals 

These transformations are needed because of VM restrictions: some primitives will check the types of receiver/arguments to work properly. So with these transformations we "fake" it.